// ignore_for_file: file_names

import 'dart:convert';

// Suggestion : Always check data type for each
LorriserviceModel lorriserviceModelFromJson(String str) =>
    LorriserviceModel.fromJson(json.decode(str));

String lorriserviceModelToJson(LorriserviceModel data) =>
    json.encode(data.toJson());

class LorriserviceModel {
  List<Value> value;

  LorriserviceModel({
    required this.value,
  });

  factory LorriserviceModel.fromJson(Map<String, dynamic> json) =>
      LorriserviceModel(
        value: List<Value>.from(json["value"].map((x) => Value.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "value": List<dynamic>.from(value.map((x) => x.toJson())),
      };
}

class Value {
  Location location;
  String locationName;
  List<double> coordinates;
  int? sortKey;

  Value({
    required this.location,
    required this.locationName,
    required this.coordinates,
    this.sortKey,
  });

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        location: Location.fromJson(json["location"]),
        locationName: json["location_name"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
        sortKey: json["sort_key"],
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "location_name": locationName,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "sort_key": sortKey,
      };
}

class Location {
  String suggestion;
  String district;
  double lat;
  String location;
  double lon;
  String state;
  String label;
  int score;
  // waste of time
  double? pincode;

  Location({
    required this.suggestion,
    required this.district,
    required this.lat,
    required this.location,
    required this.lon,
    required this.state,
    required this.label,
    required this.score,
    this.pincode,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        suggestion: json["suggestion"],
        district: json["district"],
        lat: json["lat"]?.toDouble(),
        location: json["location"],
        lon: json["lon"]?.toDouble(),
        state: json["state"],
        label: json["label"],
        score: json["score"],
        pincode: json["pincode"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "suggestion": suggestion,
        "district": district,
        "lat": lat,
        "location": location,
        "lon": lon,
        "state": state,
        "label": label,
        "score": score,
        "pincode": pincode,
      };
}
