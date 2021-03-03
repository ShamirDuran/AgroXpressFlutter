// To parse this JSON data, do
//
//     final categorieModel = categorieModelFromJson(jsonString);

import 'dart:convert';

class Categories {
  List<CategorieModel> items = List();
  Categories();
  Categories.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    items
        .addAll(jsonList.map((item) => CategorieModel.fromJson(item)).toList());
  }
}

CategorieModel categorieModelFromJson(String str) =>
    CategorieModel.fromJson(json.decode(str));

String categorieModelToJson(CategorieModel data) => json.encode(data.toJson());

class CategorieModel {
  CategorieModel({
    this.imageUrl,
    this.id,
    this.name,
  });

  String imageUrl;
  String id;
  String name;

  factory CategorieModel.fromJson(Map<String, dynamic> json) => CategorieModel(
        imageUrl: json["imageUrl"],
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "imageUrl": imageUrl,
        "_id": id,
        "name": name,
      };
}
