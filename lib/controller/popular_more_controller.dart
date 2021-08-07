import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kino_app/base/base_controller.dart';
import 'package:kino_app/core/constants/constants.dart';
import 'package:kino_app/data/model/response/movie_response.dart';
import 'package:kino_app/data/repository/popular_more_repository.dart';

class PopularMoreController extends BaseController {
  final PopularMoreRepository repository;

  PopularMoreController({@required this.repository})
      : assert(repository != null);

  ScrollController scrollController;

  int _popularPage = 1;
  int _totalPopularPage = 1;
  bool _hasNexPopular = true;
  final RxBool _isPopularLoading = false.obs;
  final List<Movie> _popularMovies = [];

  @override
  void onInit() async {
    await getPopularMovies();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        getPopularMovies();
      }
    });
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
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

  List<Movie> get popularMovies => _popularMovies;

  RxBool get isPopularLoading => _isPopularLoading;
}
