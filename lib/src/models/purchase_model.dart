// To parse this JSON data, do
//
//     final purchaseModel = purchaseModelFromJson(jsonString);

import 'dart:convert';
import 'package:intl/intl.dart';

class Purchases {
  List<PurchaseModel> items = List();
  Purchases();
  Purchases.fromJson(List<dynamic> jsonList) {
    if (jsonList == null) return;
    items.addAll(jsonList.map((item) => PurchaseModel.fromJson(item)).toList());
  }
}

PurchaseModel purchaseModelFromJson(String str) =>
    PurchaseModel.fromJson(json.decode(str));

String purchaseModelToJson(PurchaseModel data) => json.encode(data.toJson());

class PurchaseModel {
  PurchaseModel({
    this.id,
    this.seller,
    this.buyer,
    this.publication,
    this.name,
    this.quantity,
    this.cost,
    this.date,
    this.v,
  });

  String id;
  String seller;
  String buyer;
  String publication;
  String name;
  int quantity;
  int cost;
  DateTime date;
  int v;

  factory PurchaseModel.fromJson(Map<String, dynamic> json) => PurchaseModel(
        id: json["_id"],
        seller: json["seller"],
        buyer: json["buyer"],
        publication: json["publication"],
        name: json["name"],
        quantity: json["quantity"],
        cost: json["cost"],
        date: DateTime.parse(json["date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "seller": seller,
        "buyer": buyer,
        "publication": publication,
        "name": name,
        "quantity": quantity,
        "cost": cost,
        "date": date.toIso8601String(),
        "__v": v,
      };

  String getPriceFormated() {
    var template = new NumberFormat("###,###.##");
    return template.format(this.cost);
  }
}
