// To parse this JSON data, do
//
//     final guestModel = guestModelFromJson(jsonString);

import 'dart:convert';

GuestModel guestModelFromJson(String str) => GuestModel.fromJson(json.decode(str));

String guestModelToJson(GuestModel data) => json.encode(data.toJson());

class GuestModel {
  GuestModel({
    this.success,
    this.guestSessionId,
    this.expiresAt,
  });

  bool success;
  String guestSessionId;
  String expiresAt;

  factory GuestModel.fromJson(Map<String, dynamic> json) => GuestModel(
    success: json["success"],
    guestSessionId: json["guest_session_id"],
    expiresAt: json["expires_at"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "guest_session_id": guestSessionId,
    "expires_at": expiresAt,
  };
}
