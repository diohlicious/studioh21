import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studioh21/app/pages/home/models/json_data.dart';
import 'package:studioh21/app/pages/menus/views/movies/movies_bloc.dart';
import 'package:studioh21/app/pages/menus/views/tvs_favorite/tvs_favorite_bloc.dart';
import 'package:studioh21/app/pages/menus/widgets/sliver_grid/sliver_grid_widget.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:studioh21/app/pages/menus/widgets/sliver_list/sliver_list_widget.dart';


class TvsFavoritePage extends StatefulWidget {
  final JsonData jsonData;

  const TvsFavoritePage({Key key, this.jsonData}) : super(key: key);

  @override
  _TvsFavoritePageState createState() => _TvsFavoritePageState();
}

class _TvsFavoritePageState extends State<TvsFavoritePage> {
  TvsFavoriteBloc bloc;
  ScrollController controller;

  bool _switchList = true;
  bool get switchList => _switchList;
  setSwitchList(bool val){
    setState(() {
      _switchList = val;
    });

  }

  @override
  void initState() {
    super.initState();
    bloc = Modular.get<TvsFavoriteBloc>();
    bloc.setJson(widget.jsonData);
    bloc.fetchMovies();
    //controller = new ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    //controller = new ScrollController()..addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.moviesModel$,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            body: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (bloc.isLoading &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  // start loading data
                  bloc.fetchMore().then((value) => bloc.setIsLoading(true));
                  //bloc.fetchMore();
                }
                return true;
              },
              child: RefreshIndicator(
              onRefresh: bloc.fetchMovies,
              child: CustomScrollView(
                controller: controller,
                slivers: [
                  SliverAppBar(
                    expandedHeight: 120.0,
                    onStretchTrigger: bloc.fetchMovies,
                    floating: true,
                    stretch: true,
                    pinned: true,
                    actions: [
                      IconButton(
                        icon: Icon(CupertinoIcons.rectangle_grid_2x2_fill),
                        tooltip: 'Grid',
                        onPressed: () {
                          setSwitchList(true);
                        },
                      ),
                      IconButton(
                        icon: Icon(CupertinoIcons.rectangle_grid_1x2_fill),
                        tooltip: 'List',
                        onPressed: () {
                          setSwitchList(false);
                        },
                      ),
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      stretchModes: [StretchMode.zoomBackground],
                      background: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              image: AssetImage('assets/welcome.png')),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Welcome.',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 23,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 3.0,
                                    color: Colors.white,
                                  ),
                                  Shadow(
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 8.0,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'Millions of movies, TV shows and people to discover. Explore now.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18,
                                shadows: <Shadow>[
                                  Shadow(
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 3.0,
                                    color: Colors.white,
                                  ),
                                  Shadow(
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 8.0,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverVisibility(
                      visible: switchList,
                      sliver: SliverGridWidget(
                          result: snapshot.data, type: widget.jsonData.type)),
                  SliverVisibility(
                      visible: !switchList,
                      sliver: SliverListWidget(
                          result: snapshot.data, type: widget.jsonData.type)),
                  SliverVisibility(
                    visible: bloc.hideLoading,
                    sliver: SliverToBoxAdapter(
                      child: Container(
                        height: bloc.isLoading ? 50.0 : 0,
                        color: Colors.transparent,
                        child: Center(
                          child: new CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ));
        });
  }
}
