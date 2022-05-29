// To parse this JSON data, do
//
//     final salseA = salseAFromJson(jsonString);

import 'dart:convert';

SalseA salseAFromJson(String str) => SalseA.fromJson(json.decode(str));

String salseAToJson(SalseA data) => json.encode(data.toJson());

class SalseA {
  SalseA({
    this.date,
    this.amount,
    this.price,
    this.city,
    this.feadback,
    this.id,
    this.type,
    this.user,
    this.currancy,
  });

  String? date;
  double? amount;
  double? price;
  String? city;
  List<String>? feadback;
  String? id;
  String? type;
  String? user;
  String? currancy;

  factory SalseA.fromJson(Map<String, dynamic> json) => SalseA(
        date: json["date"] == null ? null : json["date"],
        amount: json["amount"] == null ? null : json["amount"].toDouble(),
        price: json["price"] == null ? null : json["price"].toDouble(),
        city: json["city"] == null ? null : json["city"],
        feadback: json["feadback"] == null
            ? null
            : List<String>.from(json["feadback"].map((x) => x)),
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : json["type"],
        user: json["user"] == null ? null : json["user"],
        currancy: json["currancy"] == null ? null : json["currancy"],
      );

  Map<String, dynamic> toJson() => {
        "date": date == null ? null : date,
        "amount": amount == null ? null : amount,
        "price": price == null ? null : price,
        "city": city == null ? null : city,
        "feadback": feadback == null
            ? null
            : List<dynamic>.from(feadback!.map((x) => x)),
        "id": id == null ? null : id,
        "type": type == null ? null : type,
        "user": user == null ? null : user,
        "currancy": currancy == null ? null : currancy,
      };
}
