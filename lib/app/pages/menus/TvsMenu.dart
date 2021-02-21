
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:studioh21/app/pages/home/models/json_data.dart';
import 'package:studioh21/app/pages/menus/views/tvs/tvs_module.dart';


class TvsMenu extends StatelessWidget{
  final JsonData jsonData;
  TvsMenu({this.jsonData});

  @override
  Widget build(BuildContext context) {
    return RouterOutlet(
        module: TvsModule(typeStr: jsonData)
    );
  }

  
}