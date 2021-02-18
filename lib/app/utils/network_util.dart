import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:studioh21/app/network/network_endpoints.dart';

/// Network Util Class -> A utility class for handling network operations
class NetworkUtil {
  //----------------------------------------------------------- Singleton-Instance ------------------------------------------------------------------
  // Singleton Instance
  static NetworkUtil _instance = new NetworkUtil.internal();

  /// NetworkUtil Private Constructor -> NetworkUtil
  /// @param -> _
  /// @usage -> Returns the instance of NetworkUtil class
  NetworkUtil.internal();

  /// NetworkUtil Factory Constructor -> NetworkUtil
  /// @dependency -> _
  /// @usage -> Returns the instance of NetworkUtil class
  factory NetworkUtil() => _instance;

  //------------------------------------------------------------- Variables ---------------------------------------------------------------------------
  // JsonDecoder object
  final JsonDecoder _decoder = new JsonDecoder();

  //------------------------------------------------------------- Methods -----------------------------------------------------------------------------
  /// Get Method -> Future<dynamic>
  /// @param -> @required url -> String
  /// @usage -> Make HTTP-GET request to specified URL and returns the response in JSON format
  Future<dynamic> get({@required String url}) =>
      http.get(url,
          headers: {"Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkNmQ4NTE3ZDY5OGVhMzkxNDVjMzQ0ZjFmNGQ5YTg0MCIsInN1YiI6IjYwMmNlYTlmMmNkZTk4MDAzZTJkNGVmZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ._eE_F-eromWapO0Dj7RATqVN5F81mL68kcsCdEXSU-4"}
      ) // Make HTTP-GET request
          .then((http.Response response) {
        // On response received
        // Get response status code
        final int statusCode = response.statusCode;

        // Check response status code for error condition
        //if (statusCode < 200 || statusCode > 400 || json == null) {
          // Error occurred
          //throw new Exception("Error while fetching data");
        //} else {
          // No error occurred
          // Get response body
          final String res = response.body;
          // Convert response body to JSON object
          return _decoder.convert(res);
        //}
      });

  /// Post Method -> Future<dynamic>
  /// @param -> @required url -> String
  ///        -> headers -> Map
  ///        -> body -> dynamic
  ///        -> encoding -> dynamic
  ///  @usage -> Make HTTP-POST request to specified URL and returns the response in JSON format
  Future<dynamic> post({@required String url, body, encoding}) =>
      http
          .post(url,
              body: body,
              headers: {"Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkNmQ4NTE3ZDY5OGVhMzkxNDVjMzQ0ZjFmNGQ5YTg0MCIsInN1YiI6IjYwMmNlYTlmMmNkZTk4MDAzZTJkNGVmZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ._eE_F-eromWapO0Dj7RATqVN5F81mL68kcsCdEXSU-4"},
              encoding: encoding) // Make HTTP-POST request
          .then((http.Response response) {
        // On response received
        // Get response status code
        final int statusCode = response.statusCode;

        // Check response status code for error condition
        //if (statusCode < 200 || statusCode > 400 || json == null) {
          // Error occurred
          //throw new Exception("Error while fetching data");
        //} else {
          // No error occurred
          // Get response body
          final String res = response.body;
          // Convert response body to JSON object
          return _decoder.convert(res);
        //}
      });
}
