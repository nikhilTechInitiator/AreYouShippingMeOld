import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:are_you_shipping_me/study_materails/map/model_class/distance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_floating_map_marker_titles_core/controller/fmto_controller.dart';
import 'package:flutter_floating_map_marker_titles_core/model/floating_marker_title_info.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_floating_marker_titles/google_maps_flutter_floating_marker_titles.dart';
import 'package:latlong2/latlong.dart' as lt;
import 'package:location/location.dart';
import 'model_class/shipment_route.dart';

class MapWidget extends StatefulWidget {
  final String? userId;
  final String? token;

  const MapWidget({Key? key, this.userId, this.token}) : super(key: key);

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
  static String key = "AIzaSyB-_vym9wZXKCkVr7_pqtRmdNsJGgB3AAk";
  static String? distanceBwtwn;
  static String? duration;
  static String? speed;
  static String? destinationName;
  static String? originName;
  final LatLng _center = const LatLng(
      40.730610, -73.935242); //NewYork coordinates -- default location
  bool added = false;
  double? startLatitude;
  double? startLongitude;
  double? endLatitude;
  double? endLongitude;
  bool? currentPolyline;
  bool onMapCreatedTapAction = false;
  List<LatLng> tempPolylineCoordinates2 = [];

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
    duration = null;
    distanceBwtwn = null;
    speed = null;
    currentLocation = null;
    destinationName = null;
    originName = null;
    startLatitude = null;
    startLongitude = null;
    endLatitude = null;
    endLongitude = null;
    currentPolyline = null;
    deletePolylineOnTap();
    super.dispose();
  }

  void _setMapStyle() async {
    String style = await DefaultAssetBundle.of(context)
        .loadString('assets/json/map_style.json');
    _googleMapController?.setMapStyle(style);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("location").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (added && widget.userId != null) {
                  showMapSingleDriverLocation(snapshot);
                } else if (added && widget.userId == null) {
                  showMapAllDriverLocation(snapshot);
                }

                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return GoogleMapWithFMTO(
                  mapType: MapType.normal,
                  floatingTitles: floatingTitles,
                  myLocationEnabled: false,
                  myLocationButtonEnabled: false,
                  onMapCreated: onMapCreated,
                  onTap: (L) {
                    debugPrint("L.latitude:${L.latitude}");
                    debugPrint("L.longitude:${L.longitude}");
                    getDistance(
                        startLatitude: currentLocation!.latitude!,
                        startLongitude: currentLocation!.longitude!,
                        endLatitude: L.latitude,
                        endLongitude: L.longitude);
                    startLatitude = currentLocation!.latitude!;
                    startLongitude = currentLocation!.longitude!;
                    endLatitude = L.latitude;
                    endLongitude = L.longitude;
                    onMapCreatedTapAction = true;
                  },
                  initialCameraPosition: CameraPosition(
                    target: currentLocation != null
                        ? LatLng(currentLocation!.latitude!,
                            currentLocation!.longitude!)
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
                );
              }),
          Positioned.fill(
            left: 0,
            top: 10,
            child: Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 40,
                  width: 40,
                  margin: const EdgeInsets.only(left: 20, top: 20),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      shape: BoxShape.circle),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.grey.shade700,
                    size: 26,
                  ),
                ),
              ),
            ),
          ),
          if (speed != null &&
              duration != null &&
              distanceBwtwn != null &&
              destinationName != null)
            _appBarView(),
          if (speed != null &&
              duration != null &&
              distanceBwtwn != null &&
              destinationName != null)
            Align(alignment: Alignment.bottomCenter, child: _bottomButton())
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 150),
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

  Widget _appBarView() {
    return Container(
        decoration: BoxDecoration(
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(1),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    margin: const EdgeInsets.only(left: 11),
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 2,
                      color: Colors.white54,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      deletePolylineOnTap();
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      child: const Icon(Icons.close, color: Colors.white54),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.black,
                        child: const Icon(Icons.location_on_sharp,
                            color: Colors.white54),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "$destinationName",
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    color: Colors.black,
                    child: const Icon(Icons.location_on_sharp,
                        color: Colors.white54)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "$originName",
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 26, top: 6),
              child: Column(children: [
                Row(
                  children: [
                    if (duration != null)
                      const Icon(
                        Icons.timer_outlined,
                        color: Colors.white54,
                        size: 14,
                      ),
                    const SizedBox(
                      width: 8,
                    ),
                    if (duration != null)
                      Text(
                        "$duration",
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    const SizedBox(
                      width: 15,
                    ),
                    if (distanceBwtwn != null)
                      Image.asset(
                        "assets/distance.png",
                        color: Colors.white54,
                        height: 14,
                        fit: BoxFit.fitHeight,
                      ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (distanceBwtwn != null)
                      Text(
                        "($distanceBwtwn)",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                  ],
                ),
                if (speed != null)
                  Row(
                    children: [
                      const Icon(
                        Icons.speed_sharp,
                        color: Colors.white54,
                        size: 14,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        " $speed",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
              ]),
            )
          ],
        ));
  }

  Widget _bottomButton() {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (currentPolyline != true) {
          createPolylineOnTap();
        } else {
          deletePolylineOnTap();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(1),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.directions_sharp, color: Colors.white, size: 20),
            Text(currentPolyline != true ? "Start" : "Stop",
                style: const TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
      ),
    );
  }

  void onMapCreated(controller) {
    _googleMapController = controller;
    added = true;
    _setMapStyle();
    setState(() {});
  }

  void addCustomIcon() {
    if (Platform.isIOS) {
      BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(size: Size(12, 12)),
              "assets/destination_ios.png")
          .then((value) {
        destinationIcon = value;
      });
      BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(
                size: Size(12, 12),
              ),
              "assets/shipment_ios.png")
          .then((value) {
        shipmentIconForStops = value;
      });
      BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(size: Size(12, 12)),
              "assets/3d_truck.png")
          .then((value) {
        navigationIcon = value;
      });
      BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(size: Size(30, 30)),
              "assets/shipment.png")
          .then(
        (icon) {
          setState(() {
            shipmentIcon = icon;
          });
        },
      );
    } else {
      BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(size: Size(12, 12)),
              "assets/destination.png")
          .then((value) {
        destinationIcon = value;
      });
      BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(
                size: Size(12, 12),
              ),
              "assets/shipment.png")
          .then((value) {
        shipmentIconForStops = value;
      });
      BitmapDescriptor.fromAssetImage(
              const ImageConfiguration(size: Size(12, 12)),
              "assets/3d_truck2x.png")
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

  Future<void> createPolylineOnTap() async {
    PolylinePoints polylinePoints2 = PolylinePoints();
    tempPolylineCoordinates2.clear();
    currentPolyline = true;
    PolylineResult result2 = await polylinePoints2.getRouteBetweenCoordinates(
      key, // Your Google Map Key
      PointLatLng(startLatitude!, startLongitude!),
      PointLatLng(endLatitude!, endLongitude!),
    );
    if (result2.points.isNotEmpty) {
      result2.points.forEach(
        (PointLatLng point) => tempPolylineCoordinates2.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
    }
    if (onMapCreatedTapAction == true) {
      markerList.add(Marker(
          markerId: const MarkerId("currentPolyline"),
          position: LatLng(endLatitude!, endLongitude!),
          draggable: false,
          flat: true,
          zIndex: 2,
          anchor: const Offset(0.5, 0.5),
          icon: BitmapDescriptor.defaultMarker));
    }
    onMapCreatedTapAction = false;
    setState(() {});
  }

  Future<void> deletePolylineOnTap() async {
    tempPolylineCoordinates2.clear();
    currentPolyline = null;
    speed = null;
    duration = null;
    distanceBwtwn = null;
    destinationName = null;
    startLatitude = null;
    startLongitude = null;
    endLatitude = null;
    endLongitude = null;
    currentPolyline = null;
    onMapCreatedTapAction = false;
    markerList.removeWhere(
      (element) => element.markerId == const MarkerId("currentPolyline"),
    );
    setState(() {});
  }

  Future<void> showMapSingleDriverLocation(
      AsyncSnapshot<QuerySnapshot> snapshot) async {
    await _googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
              snapshot.data?.docs.singleWhere(
                  (element) => element.id == widget.userId)["latitude"],
              snapshot.data?.docs.singleWhere(
                  (element) => element.id == widget.userId)["longitude"]),
          zoom: 15,
        ),
      ),
    );
    markerList.add(Marker(
        markerId: MarkerId(widget.userId!),
        position: LatLng(
            snapshot.data?.docs.singleWhere(
                (element) => element.id == widget.userId)["latitude"],
            snapshot.data?.docs.singleWhere(
                (element) => element.id == widget.userId)["longitude"]),
        draggable: false,
        infoWindow: InfoWindow(
            title: snapshot.data?.docs
                .singleWhere((element) => element.id == widget.userId)["name"],
            snippet:
                "${snapshot.data?.docs.singleWhere((element) => element.id == widget.userId)["speed"].toStringAsFixed(2)} KM/hr"),
        flat: true,
        zIndex: 2,
        anchor: const Offset(0.5, 0.5),
        rotation: snapshot.data?.docs
            .singleWhere((element) => element.id == widget.userId)["direction"],
        onTap: () {},
        icon: navigationIcon));
  }

  Future<void> showMapAllDriverLocation(
      AsyncSnapshot<QuerySnapshot> snapshot) async {
    snapshot.data?.docs.forEach((element) {
      if (widget.token != element["token"]) {
        markerList.add(Marker(
            markerId: MarkerId(element["token"]),
            position: LatLng(element["latitude"], element["longitude"]),
            draggable: false,
            infoWindow: InfoWindow(
                title: element["name"],
                snippet: "${element["speed"].toStringAsFixed(2)} KM/hr"),
            flat: true,
            zIndex: 2,
            anchor: const Offset(0.5, 0.5),
            rotation: element["direction"],
            onTap: () {},
            icon: navigationIcon));
      }
    });
  }

  List<Polyline> getPolyLines() {
    List<Polyline> tempList = [];
    for (var element in polylineCoordinatesForStop) {
      tempList.add(Polyline(
        polylineId: PolylineId("route${tempList.length}"),
        points: element,
        color: Colors.black87,
        patterns: const [PatternItem.dot],
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
      ));
    }
    if (currentPolyline == true) {
      tempList.add(Polyline(
        polylineId: const PolylineId("currentPolyline"),
        points: tempPolylineCoordinates2,
        color: Colors.blue,
        patterns: [PatternItem.dash(5)],
        width: 7,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
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
              infoWindow: const InfoWindow(title: "currentLocation"),
              flat: true,
              zIndex: 2,
              anchor: const Offset(0.5, 0.5),
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
            onTap: () {
              getDistance(
                  startLatitude: currentLocation!.latitude!,
                  startLongitude: currentLocation!.longitude!,
                  endLatitude: element.lattitud!,
                  endLongitude: element.longitude!);
              startLatitude = currentLocation!.latitude!;
              startLongitude = currentLocation!.longitude!;
              endLatitude = element.lattitud!;
              endLongitude = element.longitude;
            },
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

  Future<dynamic> getDistance(
      {required double startLatitude,
      required double startLongitude,
      required double endLatitude,
      required double endLongitude}) async {
    destinationName = null;
    originName = null;
    distanceBwtwn = null;
    speed = null;
    duration = null;
    String Url =
        'https://maps.googleapis.com/maps/api/distancematrix/json?destinations=$startLatitude,$startLongitude&origins=$endLatitude,$endLongitude&key=$key';
    Dio dio = Dio();
    try {
      Response response = await dio.get(Url);
      DistanceResponse distanceResponse =
          DistanceResponse.fromJson(response.data);
      if (response.statusCode == 200) {
        distanceBwtwn = distanceResponse.routeList
            ?.elementAt(0)
            .distanceList
            ?.elementAt(0)
            .distance;
        debugPrint("distanceBwtwn:$distanceBwtwn");
        duration = distanceResponse.routeList
            ?.elementAt(0)
            .distanceList
            ?.elementAt(0)
            .duration;

        if (distanceResponse.destinationAddress?.isNotEmpty == true &&
            distanceResponse.destinationAddress?.contains("+") != true) {
          destinationName =
              distanceResponse.destinationAddress?.split(",").first;
        } else if (distanceResponse.destinationAddress?.isNotEmpty == true &&
            distanceResponse.destinationAddress?.contains("+") == true) {
          destinationName = distanceResponse.destinationAddress
              ?.split(",")
              .toList()
              .elementAt(1);
        } else {
          destinationName = distanceResponse.destinationAddress;
        }
        if (distanceResponse.originAddress?.isNotEmpty == true &&
            distanceResponse.originAddress?.contains("+") != true) {
          originName = distanceResponse.originAddress?.split(",").first;
        } else if (distanceResponse.originAddress?.isNotEmpty == true &&
            distanceResponse.originAddress?.contains("+") == true) {
          originName =
              distanceResponse.originAddress?.split(",").toList().elementAt(1);
        } else {
          originName = distanceResponse.originAddress;
        }
        debugPrint("duration:$duration");
        debugPrint("destinationName:$destinationName");
        debugPrint("originName:$originName");
        _calculateSpeedBetweenLocations();
        setState(() {});
        return (response.data);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  void _calculateSpeedBetweenLocations() {
    if (currentLocation == null) {
      speed = null;
      debugPrint("speed:$speed");
    } else {
      speed =
          '${currentLocation?.speed != null && currentLocation!.speed! * 3600 / 1000 > 0 ? (currentLocation!.speed! * 3600 / 1000).toStringAsFixed(2) : 0} KM/h';
      debugPrint("speed:$speed");
    }
  }
}
