import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studioh21/app/network/network_endpoints.dart';
import 'package:studioh21/app/pages/movies/model/movies_model.dart';

class SliverGridWidget extends StatelessWidget {
  final List<Result> result;

  const SliverGridWidget({Key key, this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var gridItems = <Widget>[];
    for (var i = 0; i < result.length; i++) {
      var d = result[i];
      gridItems.add(Container(
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        height: 500,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(
                0.3, 3.0), // 10% of the width, so there are ten blinds.
            colors: [Colors.white, Colors.brown[900]], // red to yellow
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 170,
              height: 170,
              margin: EdgeInsets.fromLTRB(3, 6, 3, 0),
              padding: EdgeInsets.only(bottom: 3.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(9),
                  image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: NetworkImage(
                          '${NetworkEndpoints.IMAGE_URL}/${d.posterPath}'))),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(9),
                              bottomRight: Radius.circular(9)),
                          color: Colors.blue.withOpacity(0.5),
                        ),
                        padding: EdgeInsets.all(3),
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.star_fill,
                              color: Colors.white,
                              size: 15,
                            ),
                            Text(
                              d.voteAverage.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              CupertinoIcons.person_2_fill,
                              color: Colors.white,
                              size: 18,
                            ),
                            Text(
                              d.voteCount.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Spacer()
                    ],
                  ),
                  Spacer(),
                  Container(
                    color: Colors.white.withOpacity(0.5),
                    child: Text(
                      d.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 3.0,
                            color: Colors.grey,
                          ),
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 8.0,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              d.overview,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ));
    }
    return SliverGrid.count(
      children: gridItems,
      crossAxisCount: 2,
    );
  }
}
