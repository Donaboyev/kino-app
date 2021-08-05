import 'package:flutter/foundation.dart';
import 'package:kino_app/data/data_sources/remote/remote_source.dart';

class HomeRepository {
  final RemoteSource remoteSource;

  const HomeRepository({@required this.remoteSource})
      : assert(remoteSource != null);

  Future<dynamic> getUpcomingMovies({@required String apiKey}) async {
    final response = await remoteSource.getUpcomingMovies(apiKey: apiKey);
    if (response.data != null) {
      return response.data;
    }
    return 'Error occurred';
  }

  Future<dynamic> getNowPlayingMovies({
    @required String apiKey,
    @required int page,
  }) async {
    final response =
        await remoteSource.getNowPlayingMovies(apiKey: apiKey, page: page);
    if (response.data != null) {
      return response.data;
    }
    return 'Error occurred';
  }

  Future<dynamic> getPopularMovies({
    @required String apiKey,
    @required int page,
  }) async {
    final response =
        await remoteSource.getPopularMovies(apiKey: apiKey, page: page);
    if (response.data != null) {
      return response.data;
    }
    return 'Error occurred';
  }

  Future<dynamic> getTopRatedMovies({
    @required String apiKey,
    @required int page,
  }) async {
    final response =
        await remoteSource.getTopRatedMovies(apiKey: apiKey, page: page);
    if (response.data != null) {
      return response.data;
    }
    return 'Error occurred';
  }

  Future<dynamic> getMoviesByGenre({
    @required int genreId,
    @required String apiKey,
    @required int page,
  }) async {
    final response = await remoteSource.getMoviesByGenre(
        genreId: genreId, page: page, apiKey: apiKey);
    if (response.data != null) {
      return response.data;
    }
    return 'Error occurred';
  }

  Future<dynamic> getGenres({@required String apiKey}) async {
    final response = await remoteSource.getGenres(apiKey: apiKey);
    if (response.data != null) {
      return response.data;
    }
    return 'Error occurred';
  }

  Future<dynamic> getTrendingPeople(
      {@required String apiKey, @required int page}) async {
    final response =
        await remoteSource.getTrendingPersons(apiKey: apiKey, page: page);
    if (response.data != null) {
      return response.data;
    }
    return 'Error occurred';
  }
}
