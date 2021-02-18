import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:studioh21/app/pages/home/repositories/home_repository.dart';

import 'models/detail_model.dart';

class HomeBloc extends Disposable {
  final HomeRepository homeRepository;

  HomeBloc(this.homeRepository);

  BehaviorSubject<DetailModel> detailModel$ = BehaviorSubject<DetailModel>();

  Future fetchDetail(String sessionId) async {
    detailModel$.add(await HomeRepository().fetchDetail(sessionId));
  }

  int _selectedDrawerIndex = 0;

  int get selectedDrawerIndex => _selectedDrawerIndex;

  set selectedDrawerIndex(int val) {
    _selectedDrawerIndex = val;
    notifyListeners();
  }

  Future onSelectItem(int index) async {
    selectedDrawerIndex = index;
    // close the drawer
  }

  void notifyListeners() {}

  @override
  void dispose() {
    detailModel$.close();
  }


}
