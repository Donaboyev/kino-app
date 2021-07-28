import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:kino_app/core/constants/constants.dart';
import 'package:kino_app/data/model/response/cast.dart';
import 'package:kino_app/data/model/response/genre_response.dart';
import 'package:kino_app/data/model/response/movie_response.dart';
import 'package:kino_app/data/model/response/movie_detail.dart';
import 'package:kino_app/data/model/response/movie_image.dart';
import 'package:kino_app/data/model/response/person_response.dart';
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

  static ApiClient _apiClient;

  static ApiClient getInstance({String baseUrl = Constants.BASE_URL}) {
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

  @GET('movie/now_playing')
  Future<MovieResponse> getNowPlayingMovies(@Query('api_key') String apiKey);

  @GET('discover/movie')
  Future<MovieResponse> getMoviesByGenre(
    @Query('with_genres') int genreId,
    @Query('api_key') String apiKey,
  );

  @GET('genre/movie/list')
  Future<GenreResponse> getGenres(@Query('api_key') String apiKey);

  @GET('trending/person/week')
  Future<PersonResponse> getTrendingPeople(@Query('api_key') String apiKey);

  @GET('movie/{movieId}')
  Future<MovieDetail> getMovieDetail(
    @Path('movieId') int movieId,
    @Query('api_key') String apiKey,
  );

  @GET('movie/{movieId}/videos')
  Future<String> getTrailerId(
    @Path('movieId') int movieId,
    @Query('api_key') String apiKey,
  );

  @GET('movie/{movieId}/images')
  Future<MovieImage> getMovieImage(
    @Path('movieId') int movieId,
    @Query('api_key') String apiKey,
  );

  @GET('movie/{movieId}/credits')
  Future<List<Cast>> getCastList(
    @Path('movieId') int movieId,
    @Query('api_key') String apiKey,
  );
}
