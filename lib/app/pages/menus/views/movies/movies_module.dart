import 'package:flutter_modular/flutter_modular.dart';
import 'package:studioh21/app/pages/home/models/json_data.dart';
import 'package:studioh21/app/pages/menus/repositories/menu_repositories.dart';

import 'movies_bloc.dart';
import 'movies_page.dart';


class MoviesModule extends ChildModule {
  final JsonData typeStr;
  MoviesModule({this.typeStr});

  static Inject get to => Inject<MoviesModule>.of();

  @override
  List<Bind> get binds => [
    Bind((i) => MoviesBloc(i.get())),
    Bind((i) => MenuRepository()),
  ];


  @override
  List<ModularRouter> get routers => [
    ModularRouter('/', child: (_, __) => MoviesPage(jsonData: typeStr,))
  ];
}