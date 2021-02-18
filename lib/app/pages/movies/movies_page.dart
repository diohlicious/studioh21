import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:studioh21/app/pages/movies/movies_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:studioh21/app/pages/movies/widgets/sliver_grid/sliver_grid_widget.dart';

class MoviesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MoviesBloc bloc = Modular.get<MoviesBloc>();
    bloc.fetchMovies();
    return StreamBuilder(
      stream: bloc.moviesModel$,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            body: CustomScrollView(
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
                SliverGridWidget(result: snapshot.data.results),
              ],
            ),
          );
        }
    );
  }
}
