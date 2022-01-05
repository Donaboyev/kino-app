import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repository/home_repository.dart';
import '../data/response/person_response.dart';
import '../data/response/movie_response.dart';
import '../data/response/genre_response.dart';
import '../core/constants/constants.dart';
import '../base/base_controller.dart';

class HomeController extends BaseController {
  HomeController({required this.repository});

  final RxBool _isDiscoverLoading = false.obs;
  final RxInt _selectedGenreIndex = 0.obs;
  final List<Movie> _upcomingMovies = [];
  final List<Movie> _moviesByGenre = [];
  bool _isAnotherGenreClicked = false;
  bool _isDiscoverScrollable = false;
  ScrollController? scrollController;
  final HomeRepository repository;
  bool _hasNextDiscover = true;
  int? _totalDiscoverPage = 1;
  List<Genre>? _genres = [];
  int _discoverPage = 1;

  final RxBool _isNowPlayingLoading = false.obs;
  final List<Movie> _nowPlayingMovies = [];
  bool _hasNextNowPlaying = true;
  int? _totalNowPlayingPage = 1;
  int _nowPlayingPage = 1;

  final RxBool _isPeopleLoading = false.obs;
  final List<Person> _people = [];
  bool _hasNextPeople = true;
  int? _totalPeoplePage = 1;
  int _peoplePage = 1;

  final RxBool _isTopRatedLoading = false.obs;
  final List<Movie> _topRatedMovies = [];
  bool _hasNextTopRated = true;
  int? _totalTopRatedPage = 1;
  int _topRatedPage = 1;

  final RxBool _isPopularLoading = false.obs;
  final List<Movie> _popularMovies = [];
  bool _hasNexPopular = true;
  int? _totalPopularPage = 1;
  int _popularPage = 1;

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
    scrollController?.dispose();
    super.dispose();
  }

  Future<void> getUpcomingMovies() async {
    setLoading(true);
    final result = await repository.getUpcomingMovies(
      apiKey: Constants.API_KEY,
    );
    setLoading(false);
    if (result is MovieResponse) {
      _upcomingMovies.addAll(result.movies!);
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
      if (_topRatedPage > _totalTopRatedPage!) _hasNextTopRated = false;
      _topRatedMovies.addAll(result.movies!);
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
      if (_popularPage > _totalPopularPage!) _hasNexPopular = false;
      _popularMovies.addAll(result.movies!);
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
      if (_nowPlayingPage > _totalNowPlayingPage!) _hasNextNowPlaying = false;
      _nowPlayingMovies.addAll(result.movies!);
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
      genreId: genres![_selectedGenreIndex.value].id,
    );
    _isDiscoverLoading.value = false;
    setLoading(false);
    if (result is MovieResponse) {
      _totalDiscoverPage = result.totalPages;
      _discoverPage++;
      if (_discoverPage > _totalDiscoverPage!) _hasNextDiscover = false;
      _moviesByGenre.addAll(result.movies!);
      if (_isDiscoverScrollable) {
        scrollController!.animateTo(
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
      if (_peoplePage > _totalPeoplePage!) _hasNextPeople = false;
      _people.addAll(result.people!);
      update();
    } else {
      print('===================> error: $result');
    }
  }

  RxBool get isNowPlayingLoading => _isNowPlayingLoading;

  List<Movie> get nowPlayingMovies => _nowPlayingMovies;

  RxInt get selectedGenreIndex => _selectedGenreIndex;

  RxBool get isDiscoverLoading => _isDiscoverLoading;

  RxBool get isTopRatedLoading => _isTopRatedLoading;

  List<Movie> get upcomingMovies => _upcomingMovies;

  List<Movie> get topRatedMovies => _topRatedMovies;

  RxBool get isPopularLoading => _isPopularLoading;

  List<Movie> get popularMovies => _popularMovies;

  List<Movie> get moviesByGenre => _moviesByGenre;

  RxBool get isPeopleLoading => _isPeopleLoading;

  List<Genre>? get genres => _genres;

  List<Person> get people => _people;
}
