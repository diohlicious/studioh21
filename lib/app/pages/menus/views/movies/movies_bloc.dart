
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:studioh21/app/pages/home/models/json_data.dart';
import 'package:studioh21/app/pages/menus/model/menu_model.dart';
import 'package:studioh21/app/pages/menus/repositories/menu_repositories.dart';


class MoviesBloc extends Disposable{
  final MenuRepository moviesRepository;
  
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
    print(_isLoading);
    notifyListeners();
  }

  JsonData _json;

  JsonData get json => _json;

  setJson(JsonData val){
    _json = val;
    notifyListeners();
  }

  Future fetchMovies() async {
    moviesModel$ = new BehaviorSubject<List<Result>>();
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
        moviesModel$.add(movieList);
    }
  }

  //Future fetchMore() async{
  //           if(isLoading) {
  //             isLoading = false;
  //             index += 1;
  //             var _movies = await tvsRepository.fetchTvs(index);
  //             tvList.addAll(_movies.results);
  //             moviesModel$.add(tvList);
  //           }
  //         }

  Future ok() async{
    Modular.to.pop();
  }

  @override
  void dispose() {
    moviesModel$.close();
  }

  void notifyListeners() {}


}