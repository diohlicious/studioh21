
import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:studioh21/app/network/network_endpoints.dart';
import 'package:studioh21/app/pages/movies/model/movies_model.dart';
import 'package:studioh21/app/utils/network_util.dart';

class MoviesRepository extends Disposable{

  Future<MoviesModel> fetchMovies(int index) => NetworkUtil().get(
    // HTTP-GET request
      url: '${NetworkEndpoints.BASE_API}/movie/popular?language=en-US&page=$index').then((dynamic response) {
    final resStr = jsonEncode(response);
    final Map parsed = jsonDecode(resStr);
    final detailModel = MoviesModel.fromJson(parsed);
    return detailModel; // Map json response to TokenModel object
  });

  @override
  void dispose() {
  }

}