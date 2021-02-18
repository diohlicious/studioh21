import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studioh21/app/network/network_endpoints.dart';
import 'package:studioh21/app/pages/movies/model/movies_model.dart';

class SliverGridWidget extends StatelessWidget{
  final List<Result> result;

  const SliverGridWidget(
      {Key key, this.result})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var gridItems = <Widget>[];
    for(var i = 0; i<result.length;i++ ){
      var d = result[i];
      gridItems.add(Container(
        width: MediaQuery.of(context).size.width * 0.45,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: NetworkImage('${NetworkEndpoints.IMAGE_URL}/${d.posterPath}')
            )
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(CupertinoIcons.star_fill),
                Text(d.voteAverage.toString()),
                Icon(CupertinoIcons.person_2_fill),
                Text(d.voteCount.toString()),
              ],
            ),
            Text(d.title),
          ],
        ),
      )) ;
    }
    return SliverGrid.count(
      children: gridItems,
      crossAxisCount: 2,
    );
  }

}