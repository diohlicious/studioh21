import 'package:flutter_modular/flutter_modular.dart';
import 'package:studioh21/app/pages/login/repositories/login_repository.dart';

import 'login_bloc.dart';
import 'login_page.dart';

class LoginModule extends ChildModule {
  static Inject get to => Inject<LoginModule>.of();

  @override
  List<Bind> get binds => [
    Bind((i) => LoginBloc(i.get())),
    Bind((i) => LoginRepository()),
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter('/', child: (context, args) => LoginPage())
  ];
}