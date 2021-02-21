import 'package:flutter_modular/flutter_modular.dart';
import 'package:studioh21/app/pages/home/repositories/home_repository.dart';

import 'home_bloc.dart';
import 'home_page.dart';

class HomeModule extends ChildModule {
  static Inject get to => Inject<HomeModule>.of();

  @override
  List<Bind> get binds => [
    Bind((i) => HomeBloc(i.get())),
    Bind((i) => HomeRepository()),
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter('/', child: (_, args) => HomePage(args.data)),
  ];
}