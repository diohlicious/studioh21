import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:studioh21/app/network/network_endpoints.dart';
import 'package:studioh21/app/pages/movies/movies_module.dart';
import 'home_bloc.dart';
import 'models/detail_model.dart';
import 'models/drawer_model.dart';

class HomePage extends StatelessWidget {
  final String title;
  final String sessionId;

  HomePage(this.sessionId, {Key key, this.title = 'Home'}) : super(key: key);

  final drawerItems = [
    DrawerItem("Movies", CupertinoIcons.home),
  ];

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return RouterOutlet(module: MoviesModule());
      default:
        return Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    HomeBloc bloc = Modular.get<HomeBloc>();
    bloc.fetchDetail(sessionId);
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
            drawerOptions.add(ListTile(
              leading: Icon(d.icon),
              title: Text(
                d.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              selectedTileColor: Colors.blue[100].withOpacity(0.3),
              selected: i == bloc.selectedDrawerIndex,
              onTap: () => bloc
                  .onSelectItem(i)
                  .then((value) => Navigator.of(context).pop()),
            ));
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
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
