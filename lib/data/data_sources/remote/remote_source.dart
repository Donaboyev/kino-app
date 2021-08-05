import 'package:flutter/foundation.dart';
import 'package:kino_app/data/model/response/cast_response.dart';
import 'package:kino_app/data/model/response/genre_response.dart';
import 'package:kino_app/data/model/response/movie_response.dart';
import 'package:kino_app/data/model/response/movie_detail.dart';
import 'package:kino_app/data/model/response/movie_image.dart';
import 'package:kino_app/data/model/response/person_response.dart';
import 'package:kino_app/data/model/response/trailer_response.dart';
import 'package:kino_app/data/remote/api_client.dart';
import 'package:kino_app/data/remote/response_handler.dart';
import 'package:kino_app/data/remote/server_error.dart';

class RemoteSource {
  ApiClient apiClient;

  RemoteSource({@required this.apiClient}) : assert(apiClient != null);

  Future<ResponseHandler<MovieResponse>> getUpcomingMovies(
      {@required String apiKey}) async {
    MovieResponse response;
    try {
      response = await apiClient.getUpcomingMovies(apiKey);
    } catch (error, stacktrace) {
      print(
          'Exceptions occurred getNowPlayingMovies: $error stacktrace: $stacktrace');
      return ResponseHandler()
        ..setException(ServerError.withError(error: error));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<MovieResponse>> getNowPlayingMovies({
    @required String apiKey,
    @required int page,
  }) async {
    MovieResponse response;
    try {
      response = await apiClient.getNowPlayingMovies(apiKey, page);
    } catch (error, stacktrace) {
      print(
          'Exceptions occurred getNowPlayingMovies: $error stacktrace: $stacktrace');
      return ResponseHandler()
        ..setException(ServerError.withError(error: error));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<MovieResponse>> getTopRatedMovies({
    @required String apiKey,
    @required int page,
  }) async {
    MovieResponse response;
    try {
      response = await apiClient.getTopRatedMovies(apiKey, page);
    } catch (error, stacktrace) {
      print(
          'Exceptions occurred getNowPlayingMovies: $error stacktrace: $stacktrace');
      return ResponseHandler()
        ..setException(ServerError.withError(error: error));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<MovieResponse>> getPopularMovies({
    @required String apiKey,
    @required int page,
  }) async {
    MovieResponse response;
    try {
      response = await apiClient.getPopularMovies(apiKey, page);
    } catch (error, stacktrace) {
      print(
          'Exceptions occurred getNowPlayingMovies: $error stacktrace: $stacktrace');
      return ResponseHandler()
        ..setException(ServerError.withError(error: error));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<MovieResponse>> getMoviesByGenre(
      {@required int genreId,
      @required String apiKey,
      @required int page}) async {
    MovieResponse response;
    try {
      response = await apiClient.getMoviesByGenre(genreId, page, apiKey);
    } catch (error, stacktrace) {
      print(
          'Exceptions occurred getNowPlayingMovies: $error stacktrace: $stacktrace');
      return ResponseHandler()
        ..setException(ServerError.withError(error: error));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<GenreResponse>> getGenres(
      {@required String apiKey}) async {
    GenreResponse response;
    try {
      response = await apiClient.getGenres(apiKey);
    } catch (error, stacktrace) {
      print(
          'Exceptions occurred getNowPlayingMovies: $error stacktrace: $stacktrace');
      return ResponseHandler()
        ..setException(ServerError.withError(error: error));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<PersonResponse>> getTrendingPersons(
      {@required String apiKey, @required int page}) async {
    PersonResponse response;
    try {
      response = await apiClient.getTrendingPeople(apiKey, page);
    } catch (error, stacktrace) {
      print(
          'Exceptions occurred getNowPlayingMovies: $error stacktrace: $stacktrace');
      return ResponseHandler()
        ..setException(ServerError.withError(error: error));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<MovieDetail>> getMovieDetail(
      {@required int movieId, @required String apiKey}) async {
    MovieDetail movieDetail;
    try {
      movieDetail = await apiClient.getMovieDetail(movieId, apiKey);
    } catch (error, stacktrace) {
      print(
          'Exceptions occurred getNowPlayingMovies: $error stacktrace: $stacktrace');
      return ResponseHandler()
        ..setException(ServerError.withError(error: error));
    }
    return ResponseHandler()..data = movieDetail;
  }

  Future<ResponseHandler<TrailerResponse>> getTrailerId(
      {@required int movieId, @required String apiKey}) async {
    TrailerResponse response;
    try {
      response = await apiClient.getTrailerId(movieId, apiKey);
    } catch (error, stacktrace) {
      print(
          'Exceptions occurred getNowPlayingMovies: $error stacktrace: $stacktrace');
      return ResponseHandler()
        ..setException(ServerError.withError(error: error));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<MovieImage>> getMovieImage(
      {@required int movieId, @required String apiKey}) async {
    MovieImage movieImage;
    try {
      movieImage = await apiClient.getMovieImage(movieId, apiKey);
    } catch (error, stacktrace) {
      print(
          'Exceptions occurred getNowPlayingMovies: $error stacktrace: $stacktrace');
      return ResponseHandler()
        ..setException(ServerError.withError(error: error));
    }
    return ResponseHandler()..data = movieImage;
  }

  Future<ResponseHandler<CastResponse>> getCastList(
      {@required int movieId, @required String apiKey}) async {
    CastResponse casts;
    try {
      casts = await apiClient.getCastList(movieId, apiKey);
    } catch (error, stacktrace) {
      print(
          'Exceptions occurred getNowPlayingMovies: $error stacktrace: $stacktrace');
      return ResponseHandler()
        ..setException(ServerError.withError(error: error));
    }
    return ResponseHandler()..data = casts;
  }
}
