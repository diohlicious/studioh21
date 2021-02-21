import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:studioh21/app/network/network_endpoints.dart';

class SliverListWidget extends StatelessWidget {
  final List result;
  final String type;

  const SliverListWidget({Key key, this.result, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var listItems = <Widget>[];
    for (var i = 0; i < result.length; i++) {
      var d = result[i];
      listItems.add(
        GestureDetector(
          onTap: (){Modular.to.pushNamed('/detail', arguments: {'id':d.id,'type':type}, );},
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            margin: EdgeInsets.fromLTRB(3, 5, 3, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(
                    3.0, 0.3), // 10% of the width, so there are ten blinds.
                colors: [Colors.white, Colors.brown[900], ], // red to yellow
                tileMode:
                    TileMode.repeated, // repeats the gradient over the canvas
              ),
            ),
            child: Row(
              children: [
                Container(
                  height: 80,
                  width: 120,
                  margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(
                            '${NetworkEndpoints.IMAGE_URL}/${d.backdropPath}'),
                      )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                  color: Colors.white.withOpacity(0.2),
                  ),
                  padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${type=='movie'?d.title:d.name}(${type=='movie'?d.releaseDate.year:d.firstAirDate.year})',
                        style: TextStyle(color: Colors.blue[900],
                        fontWeight: FontWeight.bold),
                      ),
                      Text('Rate: ${d.voteAverage} ꞏ Reviews: ${d.voteCount}',
                          style: TextStyle(color: Colors.blue[900])),
                      Text('genre: ',
                          style: TextStyle(color: Colors.blue[900])),
                      Text('${d.overview}',
                          style: TextStyle(color: Colors.blue[900], fontSize: 12),overflow: TextOverflow.ellipsis,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return SliverList(
      delegate: SliverChildListDelegate(listItems),
    );
  }
}
