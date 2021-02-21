// To parse this JSON data, do
//
//     final favModel = favModelFromJson(jsonString);

import 'dart:convert';

FavModel favModelFromJson(String str) => FavModel.fromJson(json.decode(str));

String favModelToJson(FavModel data) => json.encode(data.toJson());

class FavModel {
  FavModel({
    this.success,
    this.statusCode,
    this.statusMessage,
  });

  bool success;
  int statusCode;
  String statusMessage;

  factory FavModel.fromJson(Map<String, dynamic> json) => FavModel(
    success: json["success"],
    statusCode: json["status_code"],
    statusMessage: json["status_message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "status_message": statusMessage,
  };
}
