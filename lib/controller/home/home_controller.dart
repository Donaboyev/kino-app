import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:kino_app/base/base_controller.dart';
import 'package:kino_app/core/constants/constants.dart';
import 'package:kino_app/data/model/response/genre_response.dart';
import 'package:kino_app/data/model/response/movie_response.dart';
import 'package:kino_app/data/model/response/person_response.dart';
import 'package:kino_app/data/repository/home_repository.dart';

class HomeController extends BaseController {
  final HomeRepository repository;

  HomeController({@required this.repository}) : assert(repository != null);

  List<Movie> _nowPlayingMovies = [];
  List<Genre> _genres = [];
  List<Movie> _moviesByGenre = [];
  List<Person> _people = [];
  RxBool _isPageLoading = false.obs;
  RxBool _hasNext = true.obs;
  int _page = 1;

  @override
  void onInit() {
    getNowPlayingMovies();
    getGenres();
    getTrendingPerson();
    super.onInit();
  }

  Future<void> getNowPlayingMovies() async {
    print('===========================> page: $_page');
    if (!_hasNext.value) {
      return;
    }
    if (_page == 1) {
      setLoading(true);
    } else {
      _isPageLoading.value = true;
    }
    final result = await repository.getNowPlayingMovies(
      apiKey: Constants.API_KEY,
      page: _page,
    );
    _isPageLoading.value = false;
    setLoading(false);
    if (result is MovieResponse) {
      if (result.movies.isEmpty) {
        _hasNext.value = false;
      }
      _page++;
      _nowPlayingMovies.addAll(result.movies);
      update();
    } else {
      print('===================> error: $result');
    }
  }

  Future<void> getGenres() async {
    setLoading(true);
    final result = await repository.getGenres(apiKey: Constants.API_KEY);
    setLoading(false);
    if (result is GenreResponse) {
      _genres = result.genres;
      update();
    } else {
      print('===================> error: $result');
    }
  }

  Future<void> getMoviesByGenre(int genreId) async {
    setLoading(true);
    final result = await repository.getMoviesByGenre(
        genreId: genreId, apiKey: Constants.API_KEY);
    setLoading(false);
    if (result is MovieResponse) {
      _moviesByGenre = result.movies;
      update();
    } else {
      print('===================> error: $result');
    }
  }

  Future<void> getTrendingPerson() async {
    setLoading(true);
    final result =
        await repository.getTrendingPeople(apiKey: Constants.API_KEY);
    setLoading(false);
    if (result is PersonResponse) {
      _people = result.people;
      update();
    } else {
      print('===================> error: $result');
    }
  }

  List<Movie> get nowPlayingMovies => _nowPlayingMovies;

  List<Genre> get genres => _genres;

  List<Movie> get moviesByGenre => _moviesByGenre;

  List<Person> get people => _people;

  RxBool get isPageLoading => _isPageLoading;
}
