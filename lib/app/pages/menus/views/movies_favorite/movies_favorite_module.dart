import 'package:flutter_modular/flutter_modular.dart';
import 'package:studioh21/app/pages/home/models/json_data.dart';
import 'package:studioh21/app/pages/menus/repositories/menu_repositories.dart';

import 'movies_favorite_bloc.dart';
import 'movies_favorite_page.dart';


class MoviesFavoriteModule extends ChildModule {
  final JsonData typeStr;
  MoviesFavoriteModule({this.typeStr});

  static Inject get to => Inject<MoviesFavoriteModule>.of();

  @override
  List<Bind> get binds => [
    Bind((i) => MoviesFavoriteBloc(i.get())),
    Bind((i) => MenuRepository()),
  ];


  @override
  List<ModularRouter> get routers => [
    ModularRouter('/', child: (_, __) => MoviesFavoritePage(jsonData: typeStr,))
  ];
}