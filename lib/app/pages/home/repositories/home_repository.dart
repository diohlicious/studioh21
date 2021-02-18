import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:studioh21/app/network/network_endpoints.dart';
import 'package:studioh21/app/pages/home/models/detail_model.dart';
import 'package:studioh21/app/utils/network_util.dart';

class HomeRepository extends Disposable{

  Future<DetailModel> fetchDetail(String sessionId) => NetworkUtil().get(
    // HTTP-GET request
      url: NetworkEndpoints.BASE_API+'/account?session_id=$sessionId').then((dynamic response) {
    final resStr = jsonEncode(response);
    final Map parsed = jsonDecode(resStr);
    final detailModel = DetailModel.fromJson(parsed);
    return detailModel; // Map json response to TokenModel object
  });

  @override
  void dispose() {
  }

}