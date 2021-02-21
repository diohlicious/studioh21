import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:studioh21/app/pages/detail/model/detail_model.dart';
import 'package:studioh21/app/pages/detail/repositories/detail_repository.dart';
import 'package:studioh21/app/pages/home/models/json_data.dart';
import 'package:url_launcher/url_launcher.dart';

import 'model/fav_model.dart';

class DetailBloc extends Disposable{
  final DetailRepository detailRepository;

  DetailBloc(this.detailRepository);

  BehaviorSubject<DetailModel> detailModel$ = BehaviorSubject<DetailModel>();

  Future fetchDetail(int id, String type) async{
    var _detail = await detailRepository.fetchDetail(id, type);
    detailModel$.add(_detail);
  }
  
  String _snackStr;
  
  String get snackStr => _snackStr;
  
  set snackStr(String val){
    _snackStr=val;
    notifyListeners();
  }

  Future posFav(JsonData _jsonData,  int _idMedia,bool _isFav) async{
    Map<String, dynamic> _map = {
      //request body
      "media_type": _jsonData.type,
    "media_id": _idMedia,
    "favorite": !_jsonData.isFav
    };
    FavModel _detail = await detailRepository.postFav(_jsonData, _map);
    print (_detail.toJson());
    if (_detail.success){
      snackStr=_detail.statusMessage;
      print(_detail.statusMessage);
    }
  }

  launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }



  @override
  void dispose() {
    detailModel$.close();
  }

  void notifyListeners() {}

}