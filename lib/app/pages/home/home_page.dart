import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:studioh21/app/network/network_endpoints.dart';
import 'package:studioh21/app/pages/menus/MoviesFavoriteMenu.dart';
import 'package:studioh21/app/pages/menus/MoviesMenu.dart';
import 'package:studioh21/app/pages/menus/TvsFavoriteMenu.dart';
import 'package:studioh21/app/pages/menus/TvsMenu.dart';
import 'home_bloc.dart';
import 'models/detail_model.dart';
import 'models/drawer_model.dart';

class HomePage extends StatefulWidget {
  final String title;
  final String sessionId;

  HomePage(this.sessionId, {Key key, this.title = 'Home'}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc bloc;

  @override
  void initState() {
    bloc = Modular.get<HomeBloc>();
    bloc.fetchDetail(widget.sessionId).then((value) => bloc.fetchInfoMenu());
    super.initState();
  }

  final drawerItems = [
    DrawerItem("Movies", CupertinoIcons.arrowtriangle_right_square),
    DrawerItem("Tvs", CupertinoIcons.tv_circle),
    DrawerItem("Movies Favorite", CupertinoIcons.square_favorites_alt),
    DrawerItem("Tvs Favorite", CupertinoIcons.square_favorites_alt_fill),
  ];

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return MoviesMenu(jsonData: bloc.movieJson);
      case 1:
        return TvsMenu(jsonData: bloc.tvJson,);
      case 2:
        return MoviesFavoriteMenu(jsonData: bloc.movieFavJson,);
      case 3:
        return TvsFavoriteMenu(jsonData: bloc.tvFavJson,);
      default:
        return Text('');
    }
  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<DetailModel>(
        stream: bloc.detailModel$,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var detailModel = snapshot.data;

          var drawerOptions = <Widget>[];
          for (var i = 0; i < drawerItems.length; i++) {
            var d = drawerItems[i];
            drawerOptions.add(
              ListTile(
                leading: Icon(d.icon),
                title: Text(
                  d.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                selectedTileColor: Colors.blue[100].withOpacity(0.3),
                selected: i == bloc.selectedDrawerIndex,
                onTap: () => bloc.onSelectItem(i).then((value) => Navigator.of(context).pop()),//Modular.to.pop()),//
              ),
            );
          }
          return Scaffold(
            drawer: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.purple[900],
                //other styles
              ),
              child: Drawer(
                child: Container(
                  decoration: BoxDecoration(
                    //color: Colors.green.withOpacity(0.5),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(
                          Colors.grey[300].withOpacity(0.5),
                          BlendMode.luminosity),
                      image: AssetImage('assets/blue_green_vector.png'),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      UserAccountsDrawerHeader(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Colors.blue[700].withOpacity(0.8),
                                  Colors.white.withOpacity(0.38)
                                ]),
                            //borderRadius: BorderRadius.all(Radius.circular(100.0)),
                          ),
                          currentAccountPicture: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        '${NetworkEndpoints.GRAVATAR_URL}/${detailModel.avatar.gravatar.hash}'))),
                          ),
                          accountName: Text(detailModel.username,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500)),
                          accountEmail: Text(detailModel.id.toString())),
                      Column(children: drawerOptions),
                      ListTile(
                          leading: Icon(CupertinoIcons.power),
                          title: Text(
                            'Log Out',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: () => Modular.to.pushReplacementNamed('/')),
                      ListTile(
                        title: Text('App version 1.0.0'),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: _getDrawerItemWidget(bloc.selectedDrawerIndex),
          );
        });
  }
}
