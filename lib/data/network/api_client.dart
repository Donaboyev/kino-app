import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:kino_app/core/constants/constants.dart';
import 'package:kino_app/data/response/cast_response.dart';
import 'package:kino_app/data/response/genre_response.dart';
import 'package:kino_app/data/response/movie_detail.dart';
import 'package:kino_app/data/response/movie_image.dart';
import 'package:kino_app/data/response/movie_response.dart';
import 'package:kino_app/data/response/person_detail.dart';
import 'package:kino_app/data/response/person_response.dart';
import 'package:kino_app/data/response/trailer_response.dart';
import 'package:retrofit/http.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: Constants.BASE_URL)
abstract class ApiClient {
  static Alice alice = Alice(
    showNotification: true,
    showInspectorOnShake: false,
    darkTheme: false,
  );

  static get getDio {
    Dio dio = Dio(BaseOptions(followRedirects: false));
    dio.interceptors.add(alice.getDioInterceptor());
    dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        requestBody: true,
        request: true,
      ),
    );
    return dio;
  }

  static ApiClient? _apiClient;

  static ApiClient? getInstance({String baseUrl = Constants.BASE_URL}) {
    if (_apiClient != null)
      return _apiClient;
    else {
      _apiClient = ApiClient(getDio, baseUrl);
      return _apiClient;
    }
  }

  factory ApiClient(Dio dio, String baseUrl) {
    dio.options = BaseOptions(receiveTimeout: 30000, connectTimeout: 30000);
    return _ApiClient(dio, baseUrl: baseUrl);
  }

  @GET('movie/upcoming')
  Future<MovieResponse> getUpcomingMovies(@Query('api_key') String apiKey);

  @GET('movie/now_playing')
  Future<MovieResponse> getNowPlayingMovies(
    @Query('api_key') String apiKey,
    @Query('page') int page,
  );

  @GET('movie/popular')
  Future<MovieResponse> getPopularMovies(
    @Query('api_key') String apiKey,
    @Query('page') int page,
  );

  @GET('movie/top_rated')
  Future<MovieResponse> getTopRatedMovies(
    @Query('api_key') String apiKey,
    @Query('page') int page,
  );

  @GET('discover/movie')
  Future<MovieResponse> getMoviesByGenre(
    @Query('with_genres') int? genreId,
    @Query('page') int page,
    @Query('api_key') String apiKey,
  );

  @GET('genre/movie/list')
  Future<GenreResponse> getGenres(@Query('api_key') String apiKey);

  @GET('person/popular')
  Future<PersonResponse> getTrendingPeople(
    @Query('api_key') String apiKey,
    @Query('page') int page,
  );

  @GET('movie/{movieId}')
  Future<MovieDetail> getMovieDetail(
    @Path('movieId') int? movieId,
    @Query('api_key') String apiKey,
  );

  @GET('movie/{movieId}/videos')
  Future<TrailerResponse> getTrailerId(
    @Path('movieId') int? movieId,
    @Query('api_key') String apiKey,
  );

  @GET('movie/{movieId}/images')
  Future<MovieImage> getMovieImage(
    @Path('movieId') int? movieId,
    @Query('api_key') String apiKey,
  );

  @GET('movie/{movieId}/credits')
  Future<CastResponse> getCastList(
    @Path('movieId') int? movieId,
    @Query('api_key') String apiKey,
  );

  @GET('person/{personId}')
  Future<PersonDetail> getPersonDetail(
    @Path('personId') int? personId,
    @Query('api_key') String apiKey,
  );
}
