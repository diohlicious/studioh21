
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:studioh21/app/pages/home/models/json_data.dart';
import 'package:studioh21/app/pages/menus/views/movies_favorite/movies_favorite_module.dart';


class MoviesFavoriteMenu extends StatelessWidget{
  final JsonData jsonData;
  MoviesFavoriteMenu({this.jsonData});

  @override
  Widget build(BuildContext context) {
      return RouterOutlet(
          module: MoviesFavoriteModule(typeStr: jsonData)
      );
    }
}