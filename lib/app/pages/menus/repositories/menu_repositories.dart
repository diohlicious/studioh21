
import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:studioh21/app/network/network_endpoints.dart';
import 'package:studioh21/app/pages/menus/model/menu_model.dart';
import 'package:studioh21/app/utils/network_util.dart';

class MenuRepository extends Disposable{

  Future<MoviesModel> fetchMovies(int index) => NetworkUtil().get(
    // HTTP-GET request
      url: '${NetworkEndpoints.BASE_API}/movie/popular?language=en-US&page=$index').then((dynamic response) {
    final resStr = jsonEncode(response);
    final Map<String, dynamic> parsed = jsonDecode(resStr);
    final detailModel = MoviesModel.fromJson(parsed);
    return detailModel; // Map json response to TokenModel object
  });

  Future<MoviesModel> fetchFavMovies(int index, String sort, id, sessionId) => NetworkUtil().get(
    // HTTP-GET request
      url: '${NetworkEndpoints.BASE_API}/account/$id/favorite/movies?session_id=$sessionId&language=en-US&sort_by=${sort??'created_at.asc'}&page=$index').then((dynamic response) {
    final resStr = jsonEncode(response);
    final Map<String, dynamic> parsed = jsonDecode(resStr);
    final detailModel = MoviesModel.fromJson(parsed);
    return detailModel; // Map json response to TokenModel object
  });

  Future<MoviesModel> fetchTvs(int index) => NetworkUtil().get(
    // HTTP-GET request
      url: '${NetworkEndpoints.BASE_API}/tv/popular?language=en-US&page=$index').then((dynamic response) {
    final resStr = jsonEncode(response);
    final Map<String, dynamic> parsed = jsonDecode(resStr);
    final detailModel = MoviesModel.fromJson(parsed);
    return detailModel; // Map json response to TokenModel object
  });

  Future<MoviesModel> fetchFavTvs(int index, String sort, id, sessionId) => NetworkUtil().get(
    // HTTP-GET request
      url: '${NetworkEndpoints.BASE_API}/account/$id/favorite/tvs?session_id=$sessionId&language=en-US&sort_by=${sort??'created_at.asc'}&page=$index').then((dynamic response) {
    final resStr = jsonEncode(response);
    final Map<String, dynamic> parsed = jsonDecode(resStr);
    final detailModel = MoviesModel.fromJson(parsed);
    return detailModel; // Map json response to TokenModel object
  });

  @override
  void dispose() {
  }

}