import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShipmentRout {
  bool? success;
  Data? data;
  String? message;

  ShipmentRout({this.success, this.data, this.message});

  ShipmentRout.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  List<Routes>? routes;

  Data({this.routes});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['routes'] != null) {
      routes = <Routes>[];
      json['routes'].forEach((v) {
        routes!.add(new Routes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.routes != null) {
      data['routes'] = this.routes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Routes {
  int? routeId;
  List<LocationModel>? locationList;

  Routes({this.routeId, this.locationList});

  Routes.fromJson(Map<String, dynamic> json) {
    routeId = json['route_id'];
    if (json['location_list'] != null) {
      locationList = <LocationModel>[];
      json['location_list'].forEach((v) {
        locationList!.add(new LocationModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['route_id'] = this.routeId;
    if (this.locationList != null) {
      data['location_list'] =
          this.locationList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LocationModel {
  int? id;
  int? markerId;
  String? markerTitle;
  double? lattitud;
  double? longitude;
  String? locationStatus;
  int? markerTitleId;

  LocationModel({this.id,
    this.markerId,
    this.markerTitle,
    this.lattitud,
    this.longitude,
    this.locationStatus,
    this.markerTitleId});

  LocationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    markerId = json['marker_id'];
    markerTitle = json['marker_title'];
    lattitud = json['lattitud'];
    longitude = json['longitude'];
    locationStatus = json['location_status'];
    markerTitleId = json['marker_title_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['marker_id'] = this.markerId;
    data['marker_title'] = this.markerTitle;
    data['lattitud'] = this.lattitud;
    data['longitude'] = this.longitude;
    data['location_status'] = this.locationStatus;
    data['marker_title_id'] = this.markerTitleId;
    return data;
  }
}

class Cordinates {
  LatLng? latLng;

  Cordinates({
    required this.latLng,
  });

  Cordinates.fromJson(Map<String, dynamic> json) {
    latLng = json['latLng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latLng'] = this.latLng;
    return data;
  }
}

