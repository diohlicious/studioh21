// To parse this JSON data, do
//
//     final sessionModel = sessionModelFromJson(jsonString);

import 'dart:convert';

SessionModel sessionModelFromJson(String str) => SessionModel.fromJson(json.decode(str));

String sessionModelToJson(SessionModel data) => json.encode(data.toJson());

class SessionModel {
  SessionModel({
    this.success,
    this.sessionId,
  });

  bool success;
  String sessionId;

  factory SessionModel.fromJson(Map<String, dynamic> json) => SessionModel(
    success: json["success"],
    sessionId: json["session_id"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "session_id": sessionId,
  };
}
