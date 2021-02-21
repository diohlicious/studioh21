import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:studioh21/app/pages/detail/detail_module.dart';
import 'package:studioh21/app/pages/home/home_module.dart';
import 'package:studioh21/app/pages/login/login_module.dart';
import 'package:studioh21/app/pages/menus/views/movies/movies_module.dart';
import 'package:studioh21/app/pages/menus/views/movies_favorite/movies_favorite_module.dart';
import 'package:studioh21/app/pages/menus/views/tvs/tvs_module.dart';
import 'package:studioh21/app/pages/menus/views/tvs_favorite/tvs_favorite_module.dart';

import 'app_bloc.dart';
import 'app_widget.dart';

// app_module.dart
class AppModule extends MainModule {

  // Provide a list of dependencies to inject into your project
  @override
  List<Bind> get binds => [
    Bind((i) => AppBloc()),

  ];

  // Provide all the routes for your module
  @override
  List<ModularRouter> get routers => [
    ModularRouter("/", module: LoginModule()),
    ModularRouter("/home", module: HomeModule()),
    ModularRouter("/movies", module: MoviesModule(),),
    ModularRouter("/moviesfavorite", module: MoviesFavoriteModule(),),
    ModularRouter("/tvs", module: TvsModule(),),
    ModularRouter("/tvsfavorite", module: TvsFavoriteModule(),),
    ModularRouter("/detail", module: DetailModule(),),
  ];

  // Provide the root widget associated with your module
  // In this case, it's the widget you created in the first step
  @override
  Widget get bootstrap => AppWidget();
}