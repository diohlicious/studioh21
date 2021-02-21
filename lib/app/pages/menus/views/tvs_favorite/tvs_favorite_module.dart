import 'package:flutter_modular/flutter_modular.dart';
import 'package:studioh21/app/pages/home/models/json_data.dart';
import 'package:studioh21/app/pages/menus/repositories/menu_repositories.dart';
import 'package:studioh21/app/pages/menus/views/tvs_favorite/tvs_favorite_bloc.dart';
import 'package:studioh21/app/pages/menus/views/tvs_favorite/tvs_favorite_page.dart';


class TvsFavoriteModule extends ChildModule {
  final JsonData typeStr;
  TvsFavoriteModule({this.typeStr});

  static Inject get to => Inject<TvsFavoriteModule>.of();

  @override
  List<Bind> get binds => [
    Bind((i) => TvsFavoriteBloc(i.get())),
    Bind((i) => MenuRepository()),
  ];


  @override
  List<ModularRouter> get routers => [
    ModularRouter('/', child: (_, __) => TvsFavoritePage(jsonData: typeStr,))
  ];
}