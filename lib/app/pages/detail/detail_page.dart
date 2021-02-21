import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studioh21/app/network/network_endpoints.dart';
import 'package:studioh21/app/pages/detail/detail_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> map;

  const DetailPage({Key key, this.map}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DetailBloc bloc = Modular.get<DetailBloc>();
    bloc.fetchDetail(map['id'], map['type']);
    return StreamBuilder(
        stream: bloc.detailModel$,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var d = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: Text('${d.title}'),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(
                        3.0, 0.3), // 10% of the width, so there are ten blinds.
                    colors: [Colors.white, Colors.brown[500]], // red to yellow
                    tileMode:
                        TileMode.repeated, // repeats the gradient over the canvas
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: 238,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            image: DecorationImage(
                              image: NetworkImage(
                                  '${NetworkEndpoints.IMAGE_URL}/${d.backdropPath}'),
                            ),),
                        child: IconButton(
                          color: Colors.blue[500].withOpacity(0.5),
                          iconSize: 58,
                          icon: Icon(Icons.play_circle_fill),
                          onPressed: (){bloc.launchUrl(d.homepage);},
                        ),
                      ),
                      Text(
                        '${d.title}',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${d.tagline}',
                        style: TextStyle(fontSize: 18),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            CupertinoIcons.star_fill,
                            color: Colors.white,
                          ),
                          Text('${d.voteAverage}'),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            CupertinoIcons.person_2_fill,
                            color: Colors.white,
                          ),
                          Text('${d.voteCount}'),
                        ],
                      ),
                      Divider(),
                      Container(
                          margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: Text(
                            '${d.overview}',
                            style: TextStyle(
                              color: Colors.white,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(1.0, 1.0),
                                  blurRadius: 1.0,
                                  color: Colors.white,
                                ),
                                Shadow(
                                  offset: Offset(1.0, 1.0),
                                  blurRadius: 1.0,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.justify,
                          )),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.95,
                        color: Colors.white.withOpacity(0.5),
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              color: Colors.white,
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(5),
                              child: Text(
                                'Genre: ${d.genres}',
                                textAlign: TextAlign.start,
                                style: TextStyle(color: Colors.brown),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              color: Colors.white,
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(5),
                              child: Text(
                                'Duration: ${d.runtime}',
                                textAlign: TextAlign.start,
                                style: TextStyle(color: Colors.brown),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              color: Colors.white,
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(5),
                              child: Text(
                                'Production Companies: ${d.productionCompanies}',
                                textAlign: TextAlign.start,
                                style: TextStyle(color: Colors.brown),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              color: Colors.white,
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(5),
                              child: Text(
                                'Production Countries: ${d.productionCountries}',
                                textAlign: TextAlign.start,
                                style: TextStyle(color: Colors.brown),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
              ),
                ),
            ),
          );
        });
  }
}
