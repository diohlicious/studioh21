
import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:studioh21/app/network/network_config.dart';
import 'package:studioh21/app/network/network_endpoints.dart';
import 'package:studioh21/app/pages/login/models/login_model.dart';
import 'package:studioh21/app/pages/login/models/new_session_model.dart';
import 'package:studioh21/app/pages/login/models/token_model.dart';
import 'package:studioh21/app/utils/network_util.dart';

class LoginRepository extends Disposable{

  Future<TokenModel> getToken() => NetworkUtil().get(
    // HTTP-GET request
      url: NetworkEndpoints.BASE_AUT+'/token/new').then((dynamic response) {
        final resStr = jsonEncode(response);
    final Map parsed = jsonDecode(resStr);
    final tokenModel = TokenModel.fromJson(parsed);
    return tokenModel; // Map json response to TokenModel object
  });

  Future<LoginModel> isAuthenticUser(String usernameStr, passStr, tokenStr) => NetworkUtil().post(
    // HTTP-POST request
      url: NetworkEndpoints.LOGIN_API, // REST api URL
      body: {
        // Request body
        NetworkConfig.API_KEY_USER_NAME: usernameStr,
        NetworkConfig.API_KEY_USER_PASSWORD: passStr,
        NetworkConfig.API_KEY_REQUEST_TOKEN: tokenStr

      }).then((dynamic response) {
    // On response received
    final resStr = jsonEncode(response);
    final Map parsed = jsonDecode(resStr);
    final loginModel = LoginModel.fromJson(parsed);
    return loginModel; // Map json response to UserModel object
  });

  Future<NewSessionModel> newSession(String tokenStr) => NetworkUtil().post(
    // HTTP-POST request
      url: NetworkEndpoints.BASE_AUT+'/session/new', // REST api URL
      body: {
        // Request body
        NetworkConfig.API_KEY_REQUEST_TOKEN: tokenStr
      }).then((dynamic response) {
    // On response received
    final resStr = jsonEncode(response);
    final Map parsed = jsonDecode(resStr);
    final newSessionModel = NewSessionModel.fromJson(parsed);
    return newSessionModel; // Map json response to UserModel object
  });



  @override
  void dispose() {
  }

}