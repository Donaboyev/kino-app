import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

  final List<Movie> _upcomingMovies = [];

  List<Genre> _genres = [];
  final List<Movie> _moviesByGenre = [];
  final RxInt _selectedGenreIndex = 0.obs;
  bool _hasNextDiscover = true;
  final RxBool _isDiscoverLoading = false.obs;
  int _discoverPage = 1;
  int _totalDiscoverPage = 1;
  ScrollController scrollController;
  bool _isAnotherGenreClicked = false;
  bool _isDiscoverScrollable = false;

  final List<Movie> _nowPlayingMovies = [];
  bool _hasNextNowPlaying = true;
  final RxBool _isNowPlayingLoading = false.obs;
  int _nowPlayingPage = 1;
  int _totalNowPlayingPage = 1;

  final List<Person> _people = [];
  int _totalPeoplePage = 1;
  int _peoplePage = 1;
  bool _hasNextPeople = true;
  final RxBool _isPeopleLoading = false.obs;

  int _topRatedPage = 1;
  int _totalTopRatedPage = 1;
  bool _hasNextTopRated = true;
  final RxBool _isTopRatedLoading = false.obs;
  final List<Movie> _topRatedMovies = [];

  int _popularPage = 1;
  int _totalPopularPage = 1;
  bool _hasNexPopular = true;
  final RxBool _isPopularLoading = false.obs;
  final List<Movie> _popularMovies = [];

  @override
  void onInit() async {
    await getUpcomingMovies();
    await getGenres();
    await getNowPlayingMovies();
    await getPopularMovies();
    await getTopRatedMovies();
    await getTrendingPeople();
    scrollController = ScrollController();
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> getUpcomingMovies() async {
    setLoading(true);
    final result =
        await repository.getUpcomingMovies(apiKey: Constants.API_KEY);
    setLoading(false);
    if (result is MovieResponse) {
      _upcomingMovies.addAll(result.movies);
      update();
    } else {
      print('===================> error: $result');
    }
  }

  Future<void> getTopRatedMovies() async {
    if (!_hasNextTopRated) return;

    if (_topRatedPage == 1)
      setLoading(true);
    else
      _isTopRatedLoading.value = true;

    final result = await repository.getTopRatedMovies(
      apiKey: Constants.API_KEY,
      page: _topRatedPage,
    );
    _isTopRatedLoading.value = false;
    setLoading(false);
    if (result is MovieResponse) {
      _totalTopRatedPage = result.totalPages;
      _topRatedPage++;
      if (_topRatedPage > _totalTopRatedPage) {
        _hasNextTopRated = false;
      }
      _topRatedMovies.addAll(result.movies);
      update();
    } else {
      print('===================> error: $result');
    }
  }

  Future<void> getPopularMovies() async {
    if (!_hasNexPopular) return;

    if (_popularPage == 1)
      setLoading(true);
    else
      _isPopularLoading.value = true;

    final result = await repository.getPopularMovies(
      apiKey: Constants.API_KEY,
      page: _popularPage,
    );
    _isPopularLoading.value = false;
    setLoading(false);
    if (result is MovieResponse) {
      _totalPopularPage = result.totalPages;
      _popularPage++;
      if (_popularPage > _totalPopularPage) _hasNexPopular = false;
      _popularMovies.addAll(result.movies);
      update();
    } else {
      print('===================> error: $result');
    }
  }

  Future<void> getNowPlayingMovies() async {
    if (!_hasNextNowPlaying) return;

    if (_nowPlayingPage == 1)
      setLoading(true);
    else
      _isNowPlayingLoading.value = true;

    final result = await repository.getNowPlayingMovies(
      apiKey: Constants.API_KEY,
      page: _nowPlayingPage,
    );
    _isNowPlayingLoading.value = false;
    setLoading(false);
    if (result is MovieResponse) {
      _totalNowPlayingPage = result.totalPages;
      _nowPlayingPage++;
      if (_nowPlayingPage > _totalNowPlayingPage) _hasNextNowPlaying = false;
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
      getMoviesByGenre();
      update();
    } else {
      print('===================> error: $result');
    }
  }

  Future<void> setSelectedGenreIndex(int index) async {
    _isAnotherGenreClicked = _selectedGenreIndex.value != index;
    _selectedGenreIndex.value = index;
    if (_isAnotherGenreClicked) {
      _isDiscoverScrollable = true;
      _isAnotherGenreClicked = false;
      _discoverPage = 1;
      _totalDiscoverPage = 1;
      _moviesByGenre.clear();
      getMoviesByGenre();
    }
  }

  Future<void> getMoviesByGenre() async {
    if (!_hasNextDiscover) return;

    if (_discoverPage == 1)
      setLoading(true);
    else
      _isDiscoverLoading.value = true;

    final result = await repository.getMoviesByGenre(
      apiKey: Constants.API_KEY,
      page: _discoverPage,
      genreId: genres[_selectedGenreIndex.value].id,
    );
    _isDiscoverLoading.value = false;
    setLoading(false);
    if (result is MovieResponse) {
      _totalDiscoverPage = result.totalPages;
      _discoverPage++;
      if (_discoverPage > _totalDiscoverPage) _hasNextDiscover = false;
      _moviesByGenre.addAll(result.movies);
      if (_isDiscoverScrollable) {
        scrollController.animateTo(
          0,
          duration: Duration(milliseconds: 1300),
          curve: Curves.easeOut,
        );
        _isDiscoverScrollable = false;
      }
      update();
    } else {
      print('===================> error: $result');
    }
  }

  Future<void> getTrendingPeople() async {
    if (!_hasNextPeople) return;

    if (_peoplePage == 1)
      setLoading(true);
    else
      _isPeopleLoading.value = true;

    final result = await repository.getTrendingPeople(
      apiKey: Constants.API_KEY,
      page: _peoplePage,
    );
    _isPeopleLoading.value = false;
    setLoading(false);
    if (result is PersonResponse) {
      _totalPeoplePage = result.totalPages;
      _peoplePage++;
      if (_peoplePage > _totalPeoplePage) _hasNextPeople = false;
      _people.addAll(result.people);
      update();
    } else {
      print('===================> error: $result');
    }
  }

  List<Movie> get upcomingMovies => _upcomingMovies;

  List<Genre> get genres => _genres;

  List<Person> get people => _people;

  RxBool get isPageLoading => _isNowPlayingLoading;

  RxBool get isPeopleLoading => _isPeopleLoading;

  List<Movie> get topRatedMovies => _topRatedMovies;

  RxBool get isTopRatedLoading => _isTopRatedLoading;

  List<Movie> get popularMovies => _popularMovies;

  RxBool get isPopularLoading => _isPopularLoading;

  List<Movie> get nowPlayingMovies => _nowPlayingMovies;

  RxBool get isNowPlayingLoading => _isNowPlayingLoading;

  List<Movie> get moviesByGenre => _moviesByGenre;

  RxBool get isDiscoverLoading => _isDiscoverLoading;

  RxInt get selectedGenreIndex => _selectedGenreIndex;
}
