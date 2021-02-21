import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:studioh21/app/network/network_endpoints.dart';
import 'package:studioh21/app/pages/detail/model/detail_model.dart';
import 'package:studioh21/app/pages/detail/model/fav_model.dart';
import 'package:studioh21/app/pages/home/models/json_data.dart';
import 'package:studioh21/app/utils/network_util.dart';

class DetailRepository extends Disposable {

  Future<DetailModel> fetchDetail(int id, String type) =>
      NetworkUtil().get(
        // HTTP-GET request
          url: '${NetworkEndpoints.BASE_API}/$type/$id?language=en-US').then((
          dynamic response) {
        final resStr = jsonEncode(response);
        final Map<String, dynamic> parsed = jsonDecode(resStr);
        Map<String, dynamic> _detailMap = new Map();

        String _genresStr = '';
        for (var i = 0; i < parsed['genres'].length; i++) {
          _genresStr = '$_genresStr ${parsed['genres'][i]['name']}${i ==
              parsed['genres'].length - 1 ? '.' : ','}';
        }
        String _prodStr = '';
        for (var i = 0; i < parsed['production_companies'].length; i++) {
          _prodStr =
          '$_prodStr ${parsed['production_companies'][i]['name']}${i ==
              parsed['production_companies'].length - 1 ? '.' : ','}';
        }
        String _countryStr = '';
        for (var i = 0; i < parsed['production_countries'].length; i++) {
          _countryStr =
          '$_countryStr ${parsed['production_countries'][i]['name']}${i ==
              parsed['production_countries'].length - 1 ? '.' : ','}';
        }

        _detailMap.addAll(
            {
              "genres": _genresStr ?? '',
              "backdrop_path": parsed['backdrop_path'] ?? '',
              "homepage": parsed['homepage'] ?? '',
              "production_companies": _prodStr ?? '',
              "production_countries": _countryStr ?? '',
              "release_date": type == 'movie'
                  ? parsed['release_date']
                  : parsed['last_air_date'],
              "runtime": type == 'movie'
                  ? parsed['runtime']
                  : parsed['next_episode_to_air']['episode_number'],
              "tagline": parsed['tagline'] ?? '',
              "title": type == 'movie' ? parsed['title'] : parsed['name'],
              "overview": parsed['overview'] ?? '',
              "vote_average": parsed['vote_average'] ?? '',
              "vote_count": parsed['vote_count'] ?? ''
            }
        );

        final detailModel = DetailModel.fromJson(_detailMap);
        return detailModel; // Map json response to TokenModel object
      });


  Future<FavModel> postFav(JsonData _jsonData, Map<String, dynamic> _body) =>
      NetworkUtil().post(
        // HTTP-POST request
          url: '${NetworkEndpoints.BASE_API}/account/${_jsonData.id}/favorite?session_id=${_jsonData.sessionId}', // REST api URL
      body: jsonEncode(_body),
      ).then((dynamic response) {
        // On response received
        final resStr = jsonEncode(response);
        final Map parsed = jsonDecode(resStr);
        final favModel = FavModel.fromJson(parsed);
        print(jsonEncode(_body));
        return favModel; // Map json response to UserModel object
      });


  @override
  void dispose() {
  }

}
