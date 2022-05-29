// To parse this JSON data, do
//
//     final cites = citesFromJson(jsonString);

import 'dart:convert';

Cites citesFromJson(String str) => Cites.fromJson(json.decode(str));

String citesToJson(Cites data) => json.encode(data.toJson());

class Cites {
  Cites({
    this.name,
    this.id,
    this.currancy,
  });

  String? name;
  int? id;
  List<Currancy>? currancy;

  factory Cites.fromJson(Map<String, dynamic> json) => Cites(
        name: json["name"] == null ? null : json["name"],
        id: json["id"] == null ? null : json["id"],
        currancy: json["currancy"] == null
            ? null
            : List<Currancy>.from(
                json["currancy"].map((x) => Currancy.fromJson(jsonDecode(x)))),
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "id": id == null ? null : id,
        "currancy": currancy == null
            ? null
            : List<dynamic>.from(currancy!.map((x) => x.toJson())),
      };
}

class Currancy {
  Currancy({
    this.name,
    this.id,
    this.price,
  });

  String? name;
  int? id;
  Price? price;

  factory Currancy.fromJson(Map<String, dynamic> json) => Currancy(
        name: json["name"] == null ? null : json["name"],
        id: json["id"] == null ? null : json["id"],
        price: json["price"] == null ? null : Price.fromJson(json["price"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "id": id == null ? null : id,
        "price": price == null ? null : price!.toJson(),
      };
}

class Price {
  Price({
    this.minS,
    this.maxS,
    this.avargeS,
    this.minP,
    this.maxP,
    this.avargeP,
  });

  double? minS;
  double? maxS;
  double? avargeS;
  double? minP;
  double? maxP;
  double? avargeP;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        minS: json["minS"] == null ? null : json["minS"].toDouble(),
        maxS: json["maxS"] == null ? null : json["maxS"].toDouble(),
        avargeS: json["avargeS"] == null ? null : json["avargeS"].toDouble(),
        minP: json["minP"] == null ? null : json["minP"].toDouble(),
        maxP: json["maxP"] == null ? null : json["maxP"].toDouble(),
        avargeP: json["avargeP"] == null ? null : json["avargeP"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "minS": minS == null ? null : minS,
        "maxS": maxS == null ? null : maxS,
        "avargeS": avargeS == null ? null : avargeS,
        "minP": minP == null ? null : minP,
        "maxP": maxP == null ? null : maxP,
        "avargeP": avargeP == null ? null : avargeP,
      };
}
