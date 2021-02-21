import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:studioh21/app/network/network_endpoints.dart';
import 'package:studioh21/app/pages/detail/model/detail_model.dart';
import 'package:studioh21/app/utils/network_util.dart';

class DetailRepository extends Disposable{

  Future<DetailModel> fetchDetail(int id, String type) => NetworkUtil().get(
    // HTTP-GET request
      url: '${NetworkEndpoints.BASE_API}/$type/$id?language=en-US').then((dynamic response) {
    final resStr = jsonEncode(response);
    final Map<String, dynamic> parsed = jsonDecode(resStr);
    Map<String, dynamic> _detailMap=new Map();

    String _genresStr ='';
    for (var i=0 ; i<parsed['genres'].length; i++){
      _genresStr = '$_genresStr ${parsed['genres'][i]['name']}${i==parsed['genres'].length-1?'.':','}';
    }
    String _prodStr ='';
    for (var i=0 ; i<parsed['production_companies'].length; i++){
      _prodStr = '$_prodStr ${parsed['production_companies'][i]['name']}${i==parsed['production_companies'].length-1?'.':','}';
    }
    String _countryStr ='';
    for (var i=0 ; i<parsed['production_countries'].length; i++){
      _countryStr = '$_countryStr ${parsed['production_countries'][i]['name']}${i==parsed['production_countries'].length-1?'.':','}';
    }



    _detailMap.addAll(
        {
          "genres":_genresStr??'',
          "backdrop_path":parsed['backdrop_path']??'',
          "homepage":parsed['homepage']??'',
          "production_companies":_prodStr??'',
          "production_countries":_countryStr??'',
          "release_date":parsed['release_date']??'',
          "runtime":parsed['runtime']??'',
          "tagline":parsed['tagline']??'',
          "title":parsed['title']??'',
          "overview":parsed['overview']??'',
          "vote_average":parsed['vote_average']??'',
          "vote_count":parsed['vote_count']??''
        }
    );

    final detailModel = DetailModel.fromJson(_detailMap);
    return detailModel; // Map json response to TokenModel object
  });


  @override
  void dispose() {
  }

}
