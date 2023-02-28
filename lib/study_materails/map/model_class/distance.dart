class DistanceResponse {
  List<RouteDetails>? routeList;
  String? destinationAddress;
  String? originAddress;

  DistanceResponse.fromJson(Map<String, dynamic> json) {
    if (json["rows"] is List) {
      routeList =
          List<RouteDetails>.from(json["rows"].map<RouteDetails>((dynamic e) {
        return RouteDetails.fromJson(e);
      }));
    }
    if(json["destination_addresses"] != null){
      destinationAddress = List<String>.from(json["destination_addresses"]).join(", ");
    }
    if(json["origin_addresses"] != null){
      originAddress = List<String>.from(json["origin_addresses"]).join(", ");
    }
  }
}

class RouteDetails {
  List<Distance>? distanceList;

  RouteDetails.fromJson(Map<String, dynamic> json) {
    if (json["elements"] is List) {
      distanceList =
          List<Distance>.from(json["elements"].map<Distance>((dynamic e) {
        return Distance.fromJson(e);
      }));
    }
  }
}

class Distance {
  String? distance;
  String? duration;

  Distance.fromJson(Map<String, dynamic> json) {
    if (json["distance"] != null) {
      distance = json["distance"]["text"];
    }
    if (json["duration"] != null) {
      duration = json["duration"]["text"];
    }
  }
}
