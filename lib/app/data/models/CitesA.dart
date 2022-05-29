// To parse this JSON data, do
//
//     final citesA = citesAFromJson(jsonString);

import 'dart:convert';

CitesA citesAFromJson(String str) => CitesA.fromJson(json.decode(str));

String citesAToJson(CitesA data) => json.encode(data.toJson());

class CitesA {
  CitesA({
    this.name,
    this.currancy,
  });

  String? name;
  List<String>? currancy;

  factory CitesA.fromJson(Map<String, dynamic> json) => CitesA(
        name: json["name"] == null ? null : json["name"],
        currancy: json["currancy"] == null
            ? null
            : List<String>.from(json["currancy"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "currancy": currancy == null
            ? null
            : List<dynamic>.from(currancy!.map((x) => x)),
      };
}
