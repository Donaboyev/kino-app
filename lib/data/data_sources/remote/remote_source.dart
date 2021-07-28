import 'package:flutter/foundation.dart';
import 'package:kino_app/data/model/response/cast.dart';
import 'package:kino_app/data/model/response/genre_response.dart';
import 'package:kino_app/data/model/response/movie_response.dart';
import 'package:kino_app/data/model/response/movie_detail.dart';
import 'package:kino_app/data/model/response/movie_image.dart';
import 'package:kino_app/data/model/response/person_response.dart';
import 'package:kino_app/data/remote/api_client.dart';
import 'package:kino_app/data/remote/response_handler.dart';
import 'package:kino_app/data/remote/server_error.dart';

class RemoteSource {
  ApiClient apiClient;

  RemoteSource({@required this.apiClient}) : assert(apiClient != null);

  Future<ResponseHandler<MovieResponse>> getNowPlayingMovies(
      {@required String apiKey}) async {
    MovieResponse response;
    try {
      response = await apiClient.getNowPlayingMovies(apiKey);
    } catch (error, stacktrace) {
      print(
          'Exceptions occurred getNowPlayingMovies: $error stacktrace: $stacktrace');
      return ResponseHandler()
        ..setException(ServerError.withError(error: error));
    }
    return ResponseHandler()..data = response;
  }

  Future<ResponseHandler<MovieResponse>> getMoviesByGenre(
      {@required int genreId, @required String apiKey}) async {
    MovieResponse response;
    try {
      response = await apiClient.getMoviesByGenre(genreId, apiKey);
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
      {@required String apiKey}) async {
    PersonResponse response;
    try {
      response = await apiClient.getTrendingPeople(apiKey);
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

  Future<ResponseHandler<String>> getTrailerId(
      {@required int movieId, @required String apiKey}) async {
    String trailerId;
    try {
      trailerId = await apiClient.getTrailerId(movieId, apiKey);
    } catch (error, stacktrace) {
      print(
          'Exceptions occurred getNowPlayingMovies: $error stacktrace: $stacktrace');
      return ResponseHandler()
        ..setException(ServerError.withError(error: error));
    }
    return ResponseHandler()..data = trailerId;
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

  Future<ResponseHandler<List<Cast>>> getCastList(
      {@required int movieId, @required String apiKey}) async {
    List<Cast> casts;
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
