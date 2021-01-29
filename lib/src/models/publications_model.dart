// To parse this JSON data, do
//
//     final publicationModel = publicationModelFromJson(jsonString);

import 'dart:convert';

PublicationModel publicationModelFromJson(String str) =>
    PublicationModel.fromJson(json.decode(str));

String publicationModelToJson(PublicationModel data) =>
    json.encode(data.toJson());

String publicationModelToJsonRegister(PublicationModel data) =>
    json.encode(data.toJsonRegister());

class PublicationModel {
  PublicationModel({
    this.id,
    this.user,
    this.name,
    this.description,
    this.image,
    this.product,
    this.availableUnits,
    this.measurementUnit,
    this.unitPrice,
    this.recurrence,
    this.productLocation,
    this.qualification,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String user;
  String name;
  String description;
  String image;
  // TODO: Cambiar este campo por categoria
  String product;
  String availableUnits;
  String measurementUnit;
  int unitPrice;
  int recurrence;
  String productLocation;
  int qualification;
  DateTime createdAt;
  DateTime updatedAt;

  factory PublicationModel.fromJson(Map<String, dynamic> json) =>
      PublicationModel(
        id: json["id"] ?? "NN",
        user: json["user"] ?? "NN",
        name: json["name"],
        description: json["description"] ?? "",
        image: json["image"] ??
            "https://www.cvn.com.co/wp-content/uploads/2018/09/papa-criolla.jpg",
        product: json["product"] ?? "NN",
        availableUnits: json["available_units"],
        measurementUnit: json["measurement_unit"] ?? "",
        unitPrice: json["unit_price"],
        recurrence: json["recurrence"] ?? 0,
        productLocation: json["product_location"] ?? "Locación no especificada",
        qualification: json["qualification"] ?? 0,
        createdAt: DateTime.parse(json["createdAt"]) ?? "",
        updatedAt: DateTime.parse(json["updatedAt"]) ?? "",
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "product": product,
        "_id": id,
        "name": name,
        "description": description,
        "recurrence": recurrence,
        "available_units": availableUnits,
        "measurement_unit": measurementUnit,
        "unit_price": unitPrice,
        "product_location": productLocation,
        "qualification": qualification,
        "user": user,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };

  Map<String, dynamic> toJsonRegister() => {
        "name": name,
        "description": description,
        "recurrence": recurrence,
        "available_units": availableUnits,
        "measurement_unit": measurementUnit,
        "unit_price": unitPrice,
        "product_location": productLocation,
        "qualification": qualification,
        "product": product,
      };
}
