import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repository/now_playing_more_repository.dart';
import '../data/response/movie_response.dart';
import '../core/constants/constants.dart';
import '../base/base_controller.dart';

class NowPlayingMoreController extends BaseController {
  NowPlayingMoreController({required this.repository});

  final RxBool _isNowPlayingLoading = false.obs;
  final NowPlayingMoreRepository repository;
  final List<Movie> _nowPlayingMovies = [];
  ScrollController? scrollController;
  bool _hasNextNowPlaying = true;
  int? _totalNowPlayingPage = 1;
  int _nowPlayingPage = 1;

  @override
  void onInit() async {
    await getNowPlayingMovies();
    scrollController = ScrollController();
    scrollController?.addListener(
      () {
        if (scrollController!.position.maxScrollExtent ==
            scrollController!.position.pixels) getNowPlayingMovies();
      },
    );
    super.onInit();
  }

  @override
  void dispose() {
    scrollController?.dispose();
    super.dispose();
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

  RxBool get isNowPlayingLoading => _isNowPlayingLoading;

  List<Movie> get nowPlayingMovies => _nowPlayingMovies;
}
