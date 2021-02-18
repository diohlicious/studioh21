import 'package:flutter_modular/flutter_modular.dart';
import 'package:studioh21/app/pages/movies/repositories/movies_repositories.dart';

import 'movies_bloc.dart';
import 'movies_page.dart';


class MoviesModule extends ChildModule {
  static Inject get to => Inject<MoviesModule>.of();

  @override
  List<Bind> get binds => [
    Bind((i) => MoviesBloc(i.get())),
    Bind((i) => MoviesRepository()),
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter('/', child: (_, __) => MoviesPage())
  ];
}