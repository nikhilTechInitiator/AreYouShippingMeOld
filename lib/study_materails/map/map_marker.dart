import 'package:flutter/material.dart';
import 'package:flutter_floating_map_marker_titles_core/model/floating_marker_title_info.dart';
import 'package:latlong2/latlong.dart';


class MapPointer {
  FloatingMarkerTitleInfo getFloatingMarkerTitleInfo(
      {required String title, required int id, required double lat, required double lng}) {
    print(title);
    print("data.Name");
    return FloatingMarkerTitleInfo(
      isBold: true,
      color: Colors.blue,
      id: id,
      title: title, latLng:LatLng(lat,lng),
    );
  }
}