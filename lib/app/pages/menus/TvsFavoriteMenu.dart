
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:studioh21/app/pages/home/models/json_data.dart';
import 'package:studioh21/app/pages/menus/views/tvs_favorite/tvs_favorite_module.dart';

class TvsFavoriteMenu extends StatelessWidget{
  final JsonData jsonData;
  TvsFavoriteMenu({this.jsonData});

  @override
  Widget build(BuildContext context) {
      return RouterOutlet(
          module: TvsFavoriteModule(typeStr: jsonData)
      );
    }
}