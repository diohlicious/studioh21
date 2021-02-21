// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.success,
    this.expiresAt,
    this.requestToken,
    this.statusCode,
    this.statusMessage,
  });

  bool success;
  String expiresAt;
  int statusCode;
  String statusMessage;
  String requestToken;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    success: json["success"],
    expiresAt: json["expires_at"],
    requestToken: json["request_token"],
    statusCode: json["status_code"],
    statusMessage: json["status_message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "expires_at": expiresAt,
    "request_token": requestToken,
    "statusCode": statusCode,
    "statusMessage": statusMessage,
  };
}
