

import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:studioh21/app/pages/home/repositories/home_repository.dart';

import 'models/detail_model.dart';
import 'models/json_data.dart';

class HomeBloc extends Disposable {
  final HomeRepository homeRepository;

  HomeBloc(this.homeRepository);

  BehaviorSubject<DetailModel> detailModel$ = BehaviorSubject<DetailModel>();

  DetailModel _jsonData;

  DetailModel get jsonData => _jsonData;

  set jsonData(DetailModel val){
    _jsonData=val;
    notifyListeners();
  }

  String _sessionId;

  String get sessionId => _sessionId;

  set sessionId(String val){
    _sessionId=val;
    notifyListeners();
  }

  Future fetchDetail(String _sessionId) async {
    final _detailModel = await HomeRepository().fetchDetail(_sessionId);
    final resStr = jsonEncode(_detailModel);
    final Map parsed = jsonDecode(resStr);
    jsonData = DetailModel.fromJson(parsed);
    sessionId = _sessionId;
    detailModel$.add(_detailModel);
  }

  int _selectedDrawerIndex = 0;

  int get selectedDrawerIndex => _selectedDrawerIndex;

  set selectedDrawerIndex(int val) {
    _selectedDrawerIndex = val;
    notifyListeners();
  }

  BehaviorSubject<int> selectedDrawerIndex$ = BehaviorSubject<int>();

  Future onSelectItem(int index) async {
    selectedDrawerIndex=index;
    selectedDrawerIndex$.add(index);
    //print(index);
    // close the drawer
  }

  JsonData _movieJson;
  JsonData get movieJson => _movieJson;
  set movieJson(JsonData val) {
    _movieJson = val;
    notifyListeners();
  }

  JsonData _movieFavJson;
  JsonData get movieFavJson => _movieFavJson;
  set movieFavJson(JsonData val) {
    _movieFavJson = val;
    notifyListeners();
  }

  JsonData _tvJson;
  JsonData get tvJson => _tvJson;
  set tvJson(JsonData val) {
    _tvJson = val;
    notifyListeners();
  }

  JsonData _tvFavJson;
  JsonData get tvFavJson => _tvFavJson;
  set tvFavJson(JsonData val) {
    _tvFavJson = val;
    notifyListeners();
  }


  Future fetchInfoMenu() async{
    movieJson = HomeRepository().movieData(jsonData,sessionId);
    movieFavJson =  HomeRepository().movieFavData(jsonData,sessionId)  ;
    tvJson =  HomeRepository().tvData(jsonData,sessionId);
    tvFavJson =  HomeRepository().tvFavData(jsonData,sessionId);
}


  void notifyListeners() {}

  @override
  void dispose() {
    detailModel$.close();
    selectedDrawerIndex$.close();
  }


}
