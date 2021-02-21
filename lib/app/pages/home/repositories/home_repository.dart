import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:studioh21/app/network/network_endpoints.dart';
import 'package:studioh21/app/pages/home/models/detail_model.dart';
import 'package:studioh21/app/pages/home/models/json_data.dart';
import 'package:studioh21/app/utils/network_util.dart';

class HomeRepository extends Disposable{

  Future<DetailModel> fetchDetail(String sessionIdStr) => NetworkUtil().get(
    // HTTP-GET request
      url: NetworkEndpoints.BASE_API+'/account?session_id=$sessionIdStr').then((dynamic response) {
    final resStr = jsonEncode(response);
    final Map parsed = jsonDecode(resStr);
    final _detailModel = DetailModel.fromJson(parsed);
    return _detailModel; // Map json response to TokenModel object
  });


  JsonData movieData(DetailModel _detailModel, String sessionId) {
    Map<String, dynamic> _rawJson = new Map();
    _rawJson.addAll(
      {
        "type":"movie",
        "sort": "",
        "id": _detailModel.id,
        "sessionId":sessionId,
        "isFav" : false
      }
    );
    final _json = JsonData.fromJson(_rawJson);
    return _json;
  }

  JsonData movieFavData(DetailModel _detailModel, String sessionId){
    Map<String, dynamic> _rawJson= new Map();
    _rawJson.addAll(
        {
          "type":"movie",
          "sort": "",
          "id":_detailModel.id,
          "sessionId":sessionId,
          "isFav" : true
        }
    );
    final _json = JsonData.fromJson(_rawJson);
    return _json;
  }

  JsonData tvData(DetailModel _detailModel, String sessionId){
    Map<String, dynamic> _rawJson= new Map();
    _rawJson.addAll(
        {
          "type":"tv",
          "sort": "",
          "id":_detailModel.id,
          "sessionId":sessionId,
          "isFav" : false
        }
    );
    final _json = JsonData.fromJson(_rawJson);
    return _json;
  }

  JsonData tvFavData(DetailModel _detailModel, String sessionId){
    Map<String, dynamic> _rawJson= new Map();
    _rawJson.addAll(
        {
          "type":"tv",
          "sort": "",
          "id":_detailModel.id,
          "sessionId":sessionId,
          "isFav" : true
        }
    );
    final _json = JsonData.fromJson(_rawJson);
    return _json;
  }

  void notifyListeners() {}

  @override
  void dispose() {
  }

}