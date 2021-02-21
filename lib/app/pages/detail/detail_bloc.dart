import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:studioh21/app/pages/detail/model/detail_model.dart';
import 'package:studioh21/app/pages/detail/repositories/detail_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailBloc extends Disposable{
  final DetailRepository detailRepository;

  DetailBloc(this.detailRepository);

  BehaviorSubject<DetailModel> detailModel$ = BehaviorSubject<DetailModel>();

  Future fetchDetail(int id, String type) async{
    var _detail = await detailRepository.fetchDetail(id, type);
    detailModel$.add(_detail);
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

}