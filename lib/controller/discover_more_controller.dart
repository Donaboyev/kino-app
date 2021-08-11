import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kino_app/base/base_controller.dart';
import 'package:kino_app/core/constants/constants.dart';
import 'package:kino_app/data/response/genre_response.dart';
import 'package:kino_app/data/response/movie_response.dart';
import 'package:kino_app/data/repository/discover_more_repository.dart';

class DiscoverMoreController extends BaseController {
  final DiscoverMoreRepository repository;

  DiscoverMoreController({@required this.repository})
      : assert(repository != null);

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

  @override
  void onInit() async {
    await getGenres();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) getMoviesByGenre();
    });
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
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

  List<Genre> get genres => _genres;

  List<Movie> get moviesByGenre => _moviesByGenre;

  RxBool get isDiscoverLoading => _isDiscoverLoading;

  RxInt get selectedGenreIndex => _selectedGenreIndex;
}
