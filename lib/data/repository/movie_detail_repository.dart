import 'package:flutter/foundation.dart';
import 'package:kino_app/data/data_sources/remote/remote_source.dart';

class MovieDetailRepository {
  final RemoteSource remoteSource;

  const MovieDetailRepository({this.remoteSource})
      : assert(remoteSource != null);

  Future<dynamic> getMovieDetail({
    @required int movieId,
    @required String apiKey,
  }) async {
    final response = await remoteSource.getMovieDetail(
      movieId: movieId,
      apiKey: apiKey,
    );
    if (response.data != null) {
      return response.data;
    }
    return 'Error occurred';
  }

  Future<dynamic> getTrailerId({
    @required int movieId,
    @required String apiKey,
  }) async {
    final response = await remoteSource.getTrailerId(
      movieId: movieId,
      apiKey: apiKey,
    );
    if (response.data != null) {
      return response.data;
    }
    return 'Error occurred';
  }

  Future<dynamic> getMovieImage({
    @required int movieId,
    @required String apiKey,
  }) async {
    final response = await remoteSource.getMovieImage(
      movieId: movieId,
      apiKey: apiKey,
    );
    if (response.data != null) {
      return response.data;
    }
    return 'Error occurred';
  }

  Future<dynamic> getCastList({
    @required int movieId,
    @required String apiKey,
  }) async {
    final response = await remoteSource.getCastList(
      movieId: movieId,
      apiKey: apiKey,
    );
    if (response.data != null) {
      return response.data;
    }
    return 'Error occurred';
  }
}
