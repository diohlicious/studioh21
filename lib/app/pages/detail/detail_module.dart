import 'package:flutter_modular/flutter_modular.dart';
import 'package:studioh21/app/pages/detail/repositories/detail_repository.dart';

import 'detail_bloc.dart';
import 'detail_page.dart';

class DetailModule extends ChildModule{

  static Inject get to => Inject<DetailModule>.of();

  @override
  List<Bind> get binds => [
    Bind((i) => DetailBloc(i.get())),
    Bind((i) => DetailRepository()),
  ];


  @override
  List<ModularRouter> get routers => [
    ModularRouter('/', child: (_, args) => DetailPage(list: args.data))
  ];

}