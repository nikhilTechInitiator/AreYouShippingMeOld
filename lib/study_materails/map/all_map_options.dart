import 'dart:async';
import 'dart:io';
import 'package:are_you_shipping_me/study_materails/map/google_map.dart';
import 'package:are_you_shipping_me/study_materails/map/location_picker.dart';
import 'package:are_you_shipping_me/widgets/app_bars/app_bar_default.dart';
import 'package:are_you_shipping_me/widgets/popup_and_loaders/custom_popup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';

class AllMapOptions extends StatefulWidget {
  const AllMapOptions({Key? key}) : super(key: key);

  @override
  State<AllMapOptions> createState() => _AllMapOptionsState();
}

class _AllMapOptionsState extends State<AllMapOptions> {
  final Location location = Location();
  StreamSubscription<LocationData>? _locationSubscription;
  String? token;
  String? sourceLocationName;
  String? destinationLocationName;
  LatLng? locationData;
  final LatLng _center = const LatLng(40.730610, -73.935242); //Newyork

  @override
  void initState() {
    // TODO: implement initState
    _requestPermision();
    _storeFCMToken();
    location.changeSettings(
      interval: 300,
      accuracy: LocationAccuracy.high,
    );
    location.enableBackgroundMode(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDefault('All Map Options'),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MapWidget(
                              token: token,
                            )),
                  );
                },
                child: const Text("Show All Drivers")),
            ElevatedButton(
                onPressed: () {
                  _getLocation();
                },
                child: const Text("Add My Location")),
            ElevatedButton(
                onPressed: () {
                  _listenLocation();
                },
                child: const Text("Enable Live Location")),
            ElevatedButton(
                onPressed: () {
                  _stopLocation();
                },
                child: const Text("Stop Live Location")),
            ElevatedButton(
                onPressed: () {
                  _sourceLocationPicker();
                },
                child:  Text( sourceLocationName?.isNotEmpty == true ? "$sourceLocationName" :"Source Location Picker",textAlign: TextAlign.center)),
            ElevatedButton(
                onPressed: () {
                  _destinationLocationPicker();
                },
                child:  Text( destinationLocationName?.isNotEmpty == true ? "$destinationLocationName" :"Destination Location Picker",textAlign: TextAlign.center)),
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("location")
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                snapshot.data!.docs[index]["name"].toString(),
                              ),
                              subtitle: Row(
                                children: [
                                  Text(snapshot.data!.docs[index]["latitude"]
                                      .toString()),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(snapshot.data!.docs[index]["longitude"]
                                      .toString()),
                                ],
                              ),
                              trailing: IconButton(
                                  icon: Icon(Icons.directions),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MapWidget(
                                              userId: snapshot
                                                  .data!.docs[index].id)),
                                    );
                                  }),
                            );
                          });
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  _getLocation() async {
    try {
      final LocationData _locationResult = await location.getLocation();
      locationData =
          LatLng(_locationResult.latitude!, _locationResult.longitude!);
      await FirebaseFirestore.instance.collection("location").doc(token).set({
        "latitude": _locationResult.latitude,
        "longitude": _locationResult.longitude,
        "direction": _locationResult.heading,
        "speed": _locationResult.speed,
        "speedAccuracy": _locationResult.speedAccuracy,
        "name": "Dane",
        "token": token,
      }, SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
  }

  _listenLocation() async {
    _locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      _locationSubscription?.cancel();
      setState(() {
        _locationSubscription = null;
      });
    }).listen((LocationData currentLocation) async {
      locationData =
          LatLng(currentLocation.latitude!, currentLocation.longitude!);
      await FirebaseFirestore.instance.collection("location").doc(token).set({
        "latitude": currentLocation.latitude,
        "longitude": currentLocation.longitude,
        "direction": currentLocation.heading,
        "speed": currentLocation.speed,
        "speedAccuracy": currentLocation.speedAccuracy,
        "name": "Dane",
        "token": token,
      }, SetOptions(merge: true));
    });
  }

  _stopLocation() async {
    _locationSubscription?.cancel();
    setState(() {
      _locationSubscription = null;
    });
  }

  _requestPermision() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print("Done");
    } else if (status.isDenied) {
      _requestPermision();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  _storeFCMToken() async {
    try {
      FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      token = await firebaseMessaging.getToken();
    } on SocketException {
      print("Socket Exception");
    } catch (onError) {
      print("catch storeFCMToken");
      print(onError);
    }
  }

  _sourceLocationPicker() async {
    AddressResult result = await showGoogleMapLocationPicker(
      pinWidget: Image.asset("assets/shipment.png",height: 20,fit: BoxFit.fitHeight),
      pinColor: Colors.blue,
      context: context,
      addressPlaceHolder: "Choose Location",
      addressTitle: "Selected Location",
      apiKey: "AIzaSyB-_vym9wZXKCkVr7_pqtRmdNsJGgB3AAk",
      appBarTitle: "Source Location",
      confirmButtonColor: Colors.black,
      confirmButtonText: "Done",
      confirmButtonTextColor: Colors.white,
      country: "in",
      language: "en",
      searchHint: "Choose Location",
      initialLocation: locationData ?? _center,
    );
    if (result != null) {
      setSourceLocation(result.address);
    }
  }
  _destinationLocationPicker() async {
    AddressResult result = await showGoogleMapLocationPicker(
      pinWidget: Image.asset("assets/destination.png",height: 20,fit: BoxFit.fitHeight,),
      pinColor: Colors.blue,
      context: context,
      addressPlaceHolder: "Choose Location",
      addressTitle: "Selected Location",
      apiKey: "AIzaSyB-_vym9wZXKCkVr7_pqtRmdNsJGgB3AAk",
      appBarTitle: "Destination Location",
      confirmButtonColor: Colors.black,
      confirmButtonText: "Done",
      confirmButtonTextColor: Colors.white,
      country: "in",
      language: "en",
      searchHint: "Choose Location",
      initialLocation: locationData ?? _center,
    );
    if (result != null) {
      setDestinationLocation(result.address);
    }
  }

  void setSourceLocation(String? newLocation) {
    sourceLocationName = newLocation;
    debugPrint("sourceLocationName: $sourceLocationName");
    setState(() {});
  }
  void setDestinationLocation(String? newLocation) {
    destinationLocationName = newLocation;
    debugPrint("destinationLocationName: $destinationLocationName");
    setState(() {});
  }
}
