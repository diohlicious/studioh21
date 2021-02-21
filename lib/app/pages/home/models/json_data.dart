// To parse this JSON data, do
//
//     final jsonData = jsonDataFromJson(jsonString);

import 'dart:convert';

JsonData jsonDataFromJson(String str) => JsonData.fromJson(json.decode(str));

String jsonDataToJson(JsonData data) => json.encode(data.toJson());

class JsonData {
  JsonData({
    this.type,
    this.sort,
    this.id,
    this.sessionId,
    this.isFav,
  });

  String type;
  String sort;
  int id;
  String sessionId;
  bool isFav;

  factory JsonData.fromJson(Map<String, dynamic> json) => JsonData(
    type: json["type"],
    sort: json["sort"],
    id: json["id"],
    sessionId: json["sessionId"],
    isFav: json["isFav"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "sort": sort,
    "id": id,
    "sessionId": sessionId,
    "isFav": isFav,
  };
}
