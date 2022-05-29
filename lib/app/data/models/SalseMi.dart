// To parse this JSON data, do
//
//     final salseMi = salseMiFromJson(jsonString);

import 'dart:convert';

SalseMi salseMiFromJson(String str) => SalseMi.fromJson(json.decode(str));

String salseMiToJson(SalseMi data) => json.encode(data.toJson());

class SalseMi {
  SalseMi({
    this.slasemi,
  });

  List<Slasemi>? slasemi;

  factory SalseMi.fromJson(Map<String, dynamic> json) => SalseMi(
        slasemi: json["slasemi"] == null
            ? null
            : List<Slasemi>.from(
                json["slasemi"].map((x) => Slasemi.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "slasemi": slasemi == null
            ? null
            : List<dynamic>.from(slasemi!.map((x) => x.toJson())),
      };
}

class Slasemi {
  Slasemi({
    this.id,
    this.date,
    this.amount,
    this.price,
    this.city,
    this.type,
    this.currancy,
  });

  String? id;
  String? date;
  double? amount;
  double? price;
  String? city;
  String? type;
  String? currancy;

  factory Slasemi.fromJson(Map<String, dynamic> json) => Slasemi(
        id: json["id"] == null ? null : json["id"],
        date: json["date"] == null ? null : json["date"],
        amount: json["amount"] == null ? null : json["amount"].toDouble(),
        price: json["price"] == null ? null : json["price"].toDouble(),
        city: json["city"] == null ? null : json["city"],
        type: json["type"] == null ? null : json["type"],
        currancy: json["currancy"] == null ? null : json["currancy"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "date": date == null ? null : date,
        "amount": amount == null ? null : amount,
        "price": price == null ? null : price,
        "city": city == null ? null : city,
        "type": type == null ? null : type,
        "currancy": currancy == null ? null : currancy,
      };
}
