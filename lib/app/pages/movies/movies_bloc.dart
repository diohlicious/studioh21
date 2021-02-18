
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:studioh21/app/pages/movies/model/movies_model.dart';
import 'package:studioh21/app/pages/movies/repositories/movies_repositories.dart';

class MoviesBloc extends Disposable{
  final MoviesRepository moviesRepository;
  
  MoviesBloc(this.moviesRepository);

  BehaviorSubject<MoviesModel> moviesModel$ = BehaviorSubject<MoviesModel>();

  Future fetchMovies() async {
    moviesModel$.add(await moviesRepository.fetchMovies()) ;
    //print(tokenModel.requestToken);
  }

  @override
  void dispose() {
    moviesModel$.close();
  }

  void notifyListeners() {}


}