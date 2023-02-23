import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_floating_map_marker_titles_core/controller/fmto_controller.dart';
import 'package:flutter_floating_map_marker_titles_core/model/floating_marker_title_info.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_floating_marker_titles/google_maps_flutter_floating_marker_titles.dart';
import 'package:latlong2/latlong.dart' as lt;
import 'package:location/location.dart';
import 'model_class/shipment_route.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  GoogleMapController? _googleMapController;
  LocationData? currentLocation;
  ShipmentRout? data;
  List<Routes> routesApi = [];
  List<Marker> markerList = [];
  List<List<LatLng>> routes = [];
  List<FloatingMarkerTitleInfo> floatingTitles = <FloatingMarkerTitleInfo>[];
  List<List<LatLng>> polylineCoordinatesForStop = [];
  StreamSubscription? _locationSubscription;
  BitmapDescriptor shipmentIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor shipmentIconForStops = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor navigationIcon = BitmapDescriptor.defaultMarker;
  final String key = "AIzaSyB-_vym9wZXKCkVr7_pqtRmdNsJGgB3AAk";
  final LatLng _center = const LatLng(
      40.730610, -73.935242); //NewYork coordinates -- default location

  @override
  void initState() {
    addCustomIcon();
    getCurrentLocationChanged();
    getRoutes();
    getFloatingTitle();
    super.initState();
  }

  @override
  void dispose() {
    _googleMapController?.dispose();
    if (_locationSubscription != null) {
      _locationSubscription?.cancel();
    }
    super.dispose();
  }

  void _setMapStyle() async {
    String style = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    _googleMapController?.setMapStyle(style);
  }

  void onMapCreated(controller) {
    _googleMapController = controller;
    _setMapStyle();
    setState(() {});
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(12, 12)),
            "assets/destination.png")
        .then((value) {
      destinationIcon = value;
    });
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(12, 12)), "assets/shipment.png")
        .then((value) {
      shipmentIconForStops = value;
    });
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(12, 12)),
            "assets/ic_truck_top.png")
        .then((value) {
      navigationIcon = value;
    });
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(30, 30)),
            "assets/shipment2x.png")
        .then(
      (icon) {
        setState(() {
          shipmentIcon = icon;
        });
      },
    );
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    for (var element in routes) {
      List<LatLng> tempPolylineCoordinates = [];

      for (var i = 0; i < (element.length - 1); i++) {
        PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          key, // Your Google Map Key
          PointLatLng(
              element.elementAt(i).latitude, element.elementAt(i).longitude),
          PointLatLng(element.elementAt(i + 1).latitude,
              element.elementAt(i + 1).longitude),
        );
        if (result.points.isNotEmpty) {
          result.points.forEach(
            (PointLatLng point) => tempPolylineCoordinates.add(
              LatLng(point.latitude, point.longitude),
            ),
          );
          polylineCoordinatesForStop.add(tempPolylineCoordinates);
        }
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      appBar: AppBar(
        title: const Text("Demo"),
      ),
      body: GoogleMapWithFMTO(
        mapType: MapType.normal,
        floatingTitles: floatingTitles,
        myLocationEnabled: false,
        myLocationButtonEnabled: true,
        onMapCreated: onMapCreated,
        onTap: (L) {
          debugPrint("L.latitude:${L.latitude}");
          debugPrint("L.longitude:${L.longitude}");
        },
        initialCameraPosition: CameraPosition(
          target: currentLocation != null
              ? LatLng(currentLocation!.latitude!, currentLocation!.longitude!)
              : _center,
          zoom: currentLocation != null ? 15 : 8,
        ),
        markers: Set.from(markerList),
        zoomControlsEnabled: true,
        polylines: Set.from(getPolyLines()),
        fmtoOptions: const FMTOOptions(
          textSize: 14.0,
          titlePlacementPolicy: FloatingMarkerPlacementPolicy(
            FloatingMarkerGravity.bottom,
            6,
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: FloatingActionButton(
          backgroundColor: Colors.white.withOpacity(0.7),
          mini: true,
          elevation: 5,
          onPressed: getMyCurrentLocation,
          child: Icon(
            Icons.my_location_outlined,
            color: Colors.grey.shade700,
          ),
        ),
      ),
    );
  }

  List<Polyline> getPolyLines() {
    List<Polyline> tempList = [];
    for (var element in polylineCoordinatesForStop) {
      tempList.add(Polyline(
        polylineId: PolylineId("route${tempList.length}"),
        points: element,
        color: Colors.black,
        patterns: const [PatternItem.dot],
        width: 3,
      ));
    }
    return tempList;
  }

  void getCurrentLocationChanged() async {
    Location location = Location();
    location.hasPermission();
    location.requestPermission();
    location.changeSettings(
        accuracy: LocationAccuracy.high, distanceFilter: 5.0);
    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );
    _locationSubscription = location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;
        _googleMapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 17,
              target: LatLng(
                newLoc.latitude!,
                newLoc.longitude!,
              ),
            ),
          ),
        );
        if (currentLocation != null) {
          markerList.add(Marker(
              markerId: const MarkerId("currentLocation"),
              position: LatLng(
                  currentLocation!.latitude!, currentLocation!.longitude!),
              draggable: false,
              infoWindow: InfoWindow(title: "currentLocation"),
              flat: true,
              zIndex: 2,
              anchor: Offset(0.5, 0.5),
              rotation: currentLocation!.heading!,
              icon: navigationIcon));
        }
        setState(() {});
      },
    );
  }

  void getMyCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );
    if (currentLocation != null) {
      _googleMapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 15,
            target: LatLng(
              currentLocation!.latitude!,
              currentLocation!.longitude!,
            ),
          ),
        ),
      );
    }
  }

  void getRoutes() async {
    String response = await DefaultAssetBundle.of(context)
        .loadString("assets/json/shipment_routes.json");
    data = ShipmentRout.fromJson(json.decode(response));
    routesApi = data?.data?.routes ?? [];
    getMarker();
    getStops();
    getPolyPoints();
  }

  void getStops() {
    routes.clear();
    routesApi.forEach((route) {
      List<LatLng> stopList = [];
      route.locationList?.forEach((element) {
        stopList.add(LatLng(element.lattitud!, element.longitude!));
      });
      routes.add(stopList);
    });
  }

  void getMarker() {
    markerList.clear();
    for (var route in routesApi) {
      route.locationList?.forEach((element) {
        markerList.add(Marker(
            markerId: MarkerId(element.markerId.toString()),
            position: LatLng(element.lattitud!, element.longitude!),
            draggable: true,
            infoWindow: InfoWindow(title: element.markerTitle),
            anchor: const Offset(0.5, 1.0),
            icon: element.locationStatus == "pickup"
                ? shipmentIcon
                : element.locationStatus == "delivery"
                    ? destinationIcon
                    : shipmentIconForStops));
      });
    }
  }

  List<FloatingMarkerTitleInfo> getFloatingTitle() {
    for (var route in routesApi) {
      route.locationList?.forEach((element) {
        floatingTitles.add(FloatingMarkerTitleInfo(
            id: element.markerTitleId!.toInt(),
            latLng: lt.LatLng(element.lattitud!, element.longitude!),
            title: element.markerTitle ?? "",
            color: Colors.black,
            isBold: true));
      });
    }
    return floatingTitles;
  }
}
