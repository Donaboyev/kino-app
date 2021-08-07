import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kino_app/base/base_controller.dart';
import 'package:kino_app/core/constants/constants.dart';
import 'package:kino_app/data/model/response/movie_response.dart';
import 'package:kino_app/data/repository/top_rated_more_repository.dart';

class TopRatedMoreController extends BaseController {
  final TopRatedMoreRepository repository;

  TopRatedMoreController({@required this.repository})
      : assert(repository != null);

  ScrollController scrollController;
  int _topRatedPage = 1;
  int _totalTopRatedPage = 1;
  bool _hasNextTopRated = true;
  final RxBool _isTopRatedLoading = false.obs;
  final List<Movie> _topRatedMovies = [];

  @override
  void onInit() async {
    await getTopRatedMovies();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        getTopRatedMovies();
      }
    });
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
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

  List<Movie> get topRatedMovies => _topRatedMovies;

  RxBool get isTopRatedLoading => _isTopRatedLoading;
}
