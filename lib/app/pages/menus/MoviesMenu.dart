
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:studioh21/app/pages/home/models/json_data.dart';
import 'package:studioh21/app/pages/menus/views/movies/movies_module.dart';


class MoviesMenu extends StatelessWidget{
  final JsonData jsonData;

  const MoviesMenu({Key key, this.jsonData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return RouterOutlet(
          module: MoviesModule(typeStr: jsonData)
      );
    }
}