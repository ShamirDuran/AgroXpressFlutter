// To parse this JSON data, do
//
//     final publicationModel = publicationModelFromMap(jsonString);

import 'dart:convert';
import 'package:intl/intl.dart';

class Publications {
  List<PublicationModel> items = List();

  Publications();

  Publications.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    items.addAll(
        jsonList.map((item) => PublicationModel.fromJson(item)).toList());
  }
}

PublicationModel publicationModelFromMap(String str) =>
    PublicationModel.fromJson(json.decode(str));

String publicationModelToMap(PublicationModel data) =>
    json.encode(data.toMap());

String publicationModelToJsonRegister(PublicationModel data) =>
    json.encode(data.toJsonRegister());

class PublicationModel {
  PublicationModel({
    this.id,
    this.authorId,
    this.productId,
    this.name,
    this.description,
    this.creationDate,
    this.recurrence,
    this.availableUnits,
    this.measurementUnit,
    this.unitPrice,
    this.productLocation,
    this.totalVotes,
    this.image,
  });

  String id;
  String authorId;
  String productId;
  String name;
  String description;
  DateTime creationDate;
  int recurrence;
  int availableUnits;
  String measurementUnit;
  int unitPrice;
  String productLocation;
  int totalVotes;
  String image;

  factory PublicationModel.fromJson(Map<String, dynamic> json) =>
      PublicationModel(
        id: json["id"] ?? json["_id"],
        authorId: json["author_id"],
        productId: json["product_id"],
        name: json["name"],
        description: json["description"],
        creationDate: json["creation_date"] != null
            ? DateTime.parse(json["creation_date"])
            : null,
        recurrence: json["recurrence"],
        availableUnits: json["available_units"],
        measurementUnit: json["measurement_unit"],
        unitPrice: json["unit_price"],
        productLocation: json["product_location"],
        totalVotes: json["total_votes"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "author_id": authorId,
        "product_id": productId,
        "name": name,
        "description": description,
        // "creation_date": creationDate.toIso8601String(),
        "recurrence": recurrence,
        "available_units": availableUnits,
        "measurement_unit": measurementUnit,
        "unit_price": unitPrice,
        "product_location": productLocation,
        "total_votes": totalVotes,
        "image": image,
      };

  Map<String, dynamic> toJsonRegister() => {
        "name": name,
        "description": description,
        "recurrence": recurrence,
        "available_units": availableUnits,
        "measurement_unit": measurementUnit,
        "unit_price": unitPrice,
        "product_location": productLocation,
        "qualification": totalVotes,
        "product": productId,
      };

  String getPriceFormated() {
    var template = new NumberFormat("###,###.##");
    return template.format(this.unitPrice);
  }

  /*
  * Se debe tratar las unidades debido a que el api retorna algunas veces
  * solo la unidad, ejem: "Kg", pero en otras ocasiones retorna ejem: "Libras (lb)".
  */

  /// Trata el string de unidades que retorna el api de forma que solo obtenga la nomenclatura de la unidad
  String getMeasurement() {
    if (this.measurementUnit.length < 4) return this.measurementUnit;

    final temp = this.measurementUnit.split(" ")[1];

    return temp.substring(1, temp.length - 1);
  }
}
