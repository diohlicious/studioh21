import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studioh21/app/pages/movies/movies_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:studioh21/app/pages/movies/widgets/sliver_grid/sliver_grid_widget.dart';

class MoviesPage extends StatefulWidget {
  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  MoviesBloc bloc;
  ScrollController controller;

  @override
  void initState() {
    super.initState();
    bloc = Modular.get<MoviesBloc>();
    bloc.fetchMovies();
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
                      if (bloc.isLoading && scrollInfo.metrics.pixels ==
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
                            flexibleSpace: FlexibleSpaceBar(
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
                            floating: true,
                          ),
                          SliverGridWidget(result: snapshot.data),
                          SliverToBoxAdapter(
                            child: Container(
                              height: bloc.isLoading ? 50.0 : 0,
                              color: Colors.transparent,
                              child: Center(
                                child: new CircularProgressIndicator(),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
            );
        });
  }
/*void _scrollListener() async {
    //print(controller.position.extentAfter);
    if (//controller.position.extentAfter < 500
    scrollInfo.metrics.maxScrollExtent
    // ) {
      bloc.fetchMore();
    }*/

}
