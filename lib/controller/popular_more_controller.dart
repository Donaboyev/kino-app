import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repository/popular_more_repository.dart';
import '../data/response/movie_response.dart';
import '../core/constants/constants.dart';
import '../base/base_controller.dart';

class PopularMoreController extends BaseController {
  PopularMoreController({required this.repository});

  final RxBool _isPopularLoading = false.obs;
  final PopularMoreRepository repository;
  final List<Movie> _popularMovies = [];
  ScrollController? scrollController;
  bool _hasNexPopular = true;
  int? _totalPopularPage = 1;
  int _popularPage = 1;

  @override
  void onInit() async {
    await getPopularMovies();
    scrollController = ScrollController();
    scrollController?.addListener(
      () {
        if (scrollController!.position.maxScrollExtent ==
            scrollController!.position.pixels) getPopularMovies();
      },
    );
    super.onInit();
  }

  @override
  void dispose() {
    scrollController?.dispose();
    super.dispose();
  }

  Future<void> getPopularMovies() async {
    if (!_hasNexPopular) return;

    if (_popularPage == 1) {
      setLoading(true);
    } else {
      _isPopularLoading.value = true;
    }

    final result = await repository.getPopularMovies(
      apiKey: Constants.apiKey,
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
      debugPrint('===================> error: $result');
    }
  }

  RxBool get isPopularLoading => _isPopularLoading;

  List<Movie> get popularMovies => _popularMovies;
}
