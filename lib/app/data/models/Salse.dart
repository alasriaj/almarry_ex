// To parse this JSON data, do
//
//     final salse = salseFromJson(jsonString);

import 'dart:convert';

Salse salseFromJson(String str) => Salse.fromJson(json.decode(str));

String salseToJson(Salse data) => json.encode(data.toJson());

class Salse {
  Salse({
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
  List<Feadback>? feadback;
  String? id;
  String? type;
  String? user;
  String? currancy;

  factory Salse.fromJson(Map<String, dynamic> json) => Salse(
        date: json["date"] == null ? null : json["date"],
        amount: json["amount"] == null ? null : json["amount"].toDouble(),
        price: json["price"] == null ? null : json["price"].toDouble(),
        city: json["city"] == null ? null : json["city"],
        feadback: json["feadback"] == null
            ? null
            : List<Feadback>.from(
                json["feadback"].map((x) => Feadback.fromJson(jsonDecode(x)))),
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
            : List<dynamic>.from(feadback!.map((x) => x.toJson())),
        "id": id == null ? null : id,
        "type": type == null ? null : type,
        "user": user == null ? null : user,
        "currancy": currancy == null ? null : currancy,
      };
}

class Feadback {
  Feadback({
    this.user,
    this.status,
    this.note,
  });

  String? user;
  String? status;
  String? note;

  factory Feadback.fromJson(Map<String, dynamic> json) => Feadback(
        user: json["user"] == null ? null : json["user"],
        status: json["status"] == null ? null : json["status"],
        note: json["note"] == null ? null : json["note"],
      );

  Map<String, dynamic> toJson() => {
        "user": user == null ? null : user,
        "status": status == null ? null : status,
        "note": note == null ? null : note,
      };
}
