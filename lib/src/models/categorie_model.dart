// To parse this JSON data, do
//
//     final categorieModel = categorieModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

CategorieModel categorieModelFromJson(String str) =>
    CategorieModel.fromJson(json.decode(str));

String categorieModelToJson(CategorieModel data) => json.encode(data.toJson());

class CategorieModel {
  CategorieModel({
    @required this.id,
    @required this.name,
    @required this.image,
  });

  String id;
  String name;
  String image;

  factory CategorieModel.fromJson(Map<String, dynamic> json) => CategorieModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}
