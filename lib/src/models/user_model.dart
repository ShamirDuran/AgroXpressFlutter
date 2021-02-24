// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.img,
    this.id,
    this.email,
    this.name,
    this.surname,
  });

  dynamic img;
  String id;
  String email;
  String name;
  String surname;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        img: json["img"],
        id: json["_id"],
        email: json["email"],
        name: json["name"],
        surname: json["surname"],
      );

  Map<String, dynamic> toJson() => {
        "img": img,
        "_id": id,
        "email": email,
        "name": name,
        "surname": surname,
      };
}
