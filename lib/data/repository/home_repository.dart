import 'package:flutter/foundation.dart';
import 'package:kino_app/data/data_sources/remote/remote_source.dart';

class HomeRepository {
  final RemoteSource remoteSource;

  const HomeRepository({@required this.remoteSource})
      : assert(remoteSource != null);

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

  Future<dynamic> getMoviesByGenre(
      {@required int genreId, @required String apiKey}) async {
    final response =
        await remoteSource.getMoviesByGenre(genreId: genreId, apiKey: apiKey);
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

  Future<dynamic> getTrendingPeople({@required String apiKey}) async {
    final response = await remoteSource.getTrendingPersons(apiKey: apiKey);
    if (response.data != null) {
      return response.data;
    }
    return 'Error occurred';
  }

  Future<dynamic> getMovieDetail(
      {@required int movieId, @required String apiKey}) async {
    final response =
        await remoteSource.getMovieDetail(movieId: movieId, apiKey: apiKey);
    if (response.data != null) {
      return response.data;
    }
    return 'Error occurred';
  }

  Future<dynamic> getTrailerId(
      {@required int movieId, @required String apiKey}) async {
    final response =
        await remoteSource.getTrailerId(movieId: movieId, apiKey: apiKey);
    if (response.data != null) {
      return response.data;
    }
    return 'Error occurred';
  }

  Future<dynamic> getMovieImage(
      {@required int movieId, @required String apiKey}) async {
    final response =
        await remoteSource.getMovieImage(movieId: movieId, apiKey: apiKey);
    if (response.data != null) {
      return response.data;
    }
    return 'Error occurred';
  }

  Future<dynamic> getCastList(
      {@required int movieId, @required String apiKey}) async {
    final response =
        await remoteSource.getCastList(movieId: movieId, apiKey: apiKey);
    if (response.data != null) {
      return response.data;
    }
    return 'Error occurred';
  }
}
