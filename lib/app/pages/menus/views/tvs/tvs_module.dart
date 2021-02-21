import 'package:flutter_modular/flutter_modular.dart';
import 'package:studioh21/app/pages/home/models/json_data.dart';
import 'package:studioh21/app/pages/menus/repositories/menu_repositories.dart';
import 'package:studioh21/app/pages/menus/views/tvs/tvs_bloc.dart';
import 'package:studioh21/app/pages/menus/views/tvs/tvs_page.dart';


class TvsModule extends ChildModule {
  final JsonData typeStr;
  TvsModule({this.typeStr});

  static Inject get to => Inject<TvsModule>.of();

  @override
  List<Bind> get binds => [
    Bind((i) => TvsBloc(i.get())),
    Bind((i) => MenuRepository()),
  ];


  @override
  List<ModularRouter> get routers => [
    ModularRouter('/', child: (_, __) => TvsPage(jsonData: typeStr,))
  ];
}