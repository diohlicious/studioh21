
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:studioh21/app/pages/movies/model/movies_model.dart';
import 'package:studioh21/app/pages/movies/repositories/movies_repositories.dart';

class MoviesBloc extends Disposable{
  final MoviesRepository moviesRepository;
  
  MoviesBloc(this.moviesRepository);

  BehaviorSubject<List<Result>> moviesModel$ = BehaviorSubject<List<Result>>();

  List<Result> _movieList = [];

  List<Result> get movieList => _movieList;

  set movieList(List<Result> val){
    _movieList = val;
    notifyListeners();
  }

  int _index = 0;

  int get index => _index;

  set index(int val){
    _index = val;
    notifyListeners();
  }

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  set isLoading(bool val){
    _isLoading = val;
    notifyListeners();
  }

  setIsLoading(bool val){
    _isLoading = val;
    notifyListeners();
  }


  Future fetchMovies() async {
    movieList=[];
    index = 1;
    var _movies = await moviesRepository.fetchMovies(index);
    movieList.addAll(_movies.results);
    moviesModel$.add(movieList) ;
  }

  Future fetchMore() async{
    if(isLoading) {
        isLoading = false;
        index += 1;
        var _movies = await moviesRepository.fetchMovies(index);
        movieList.addAll(_movies.results);
        print('ok ini index ke $index');
        moviesModel$.add(movieList);
    }
  }


  Future ok() async{
    //print(tokenModel.requestToken);
    print('ok');
  }

  @override
  void dispose() {
    moviesModel$.close();
  }

  void notifyListeners() {}


}