import 'package:flutter_modular/flutter_modular.dart';
import 'package:studioh21/app/pages/movies/widgets/sliver_grid/sliver_grid_widget.dart';

import '../../movies_bloc.dart';


class MoviesModule extends ChildModule {
  static Inject get to => Inject<MoviesModule>.of();

  @override
  List<Bind> get binds => [
    Bind((i) => MoviesBloc(i.get())),
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter('/', child: (_, __) => SliverGridWidget())
  ];
}