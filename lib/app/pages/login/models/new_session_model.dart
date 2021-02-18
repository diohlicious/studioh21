// To parse this JSON data, do
//
//     final newSessionModel = newSessionModelFromJson(jsonString);

import 'dart:convert';

NewSessionModel newSessionModelFromJson(String str) => NewSessionModel.fromJson(json.decode(str));

String newSessionModelToJson(NewSessionModel data) => json.encode(data.toJson());

class NewSessionModel {
  NewSessionModel({
    this.success,
    this.sessionId,
  });

  bool success;
  String sessionId;

  factory NewSessionModel.fromJson(Map<String, dynamic> json) => NewSessionModel(
    success: json["success"],
    sessionId: json["session_id"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "session_id": sessionId,
  };
}
