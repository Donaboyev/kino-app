import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repository/top_rated_more_repository.dart';
import '../data/response/movie_response.dart';
import '../core/constants/constants.dart';
import '../base/base_controller.dart';

class TopRatedMoreController extends BaseController {
  TopRatedMoreController({required this.repository});

  final RxBool _isTopRatedLoading = false.obs;
  final TopRatedMoreRepository repository;
  final List<Movie> _topRatedMovies = [];
  ScrollController? scrollController;
  bool _hasNextTopRated = true;
  int? _totalTopRatedPage = 1;
  int _topRatedPage = 1;

  @override
  void onInit() async {
    await getTopRatedMovies();
    scrollController = ScrollController();
    scrollController?.addListener(
      () {
        if (scrollController!.position.maxScrollExtent ==
            scrollController!.position.pixels) getTopRatedMovies();
      },
    );
    super.onInit();
  }

  @override
  void dispose() {
    scrollController?.dispose();
    super.dispose();
  }

  Future<void> getTopRatedMovies() async {
    if (!_hasNextTopRated) return;
    if (_topRatedPage == 1) {
      setLoading(true);
    } else {
      _isTopRatedLoading.value = true;
    }
    final result = await repository.getTopRatedMovies(
      apiKey: Constants.apiKey,
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
      debugPrint('===================> error: $result');
    }
  }

  RxBool get isTopRatedLoading => _isTopRatedLoading;

  List<Movie> get topRatedMovies => _topRatedMovies;
}
