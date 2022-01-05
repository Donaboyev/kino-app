import '../data/repository/movie_detail_repository.dart';
import '../data/response/trailer_response.dart';
import '../data/response/cast_response.dart';
import '../data/response/movie_detail.dart';
import '../data/response/movie_image.dart';
import '../core/constants/constants.dart';
import '../base/base_controller.dart';

class MovieDetailController extends BaseController {
  MovieDetailController({required this.repository});

  final MovieDetailRepository repository;
  MovieDetail? _movieDetail;
  int? movieId;

  void setMovieId(int? value) async {
    movieId = value;
    await getMovieDetail();
    await getMovieCastList();
    await getMovieScreenshots();
    await getMovieTrailerId();
  }

  Future<void> getMovieDetail() async {
    setLoading(true);
    final result = await repository.getMovieDetail(
      apiKey: Constants.API_KEY,
      movieId: movieId,
    );
    setLoading(false);
    if (result is MovieDetail) {
      _movieDetail = result;
      update();
    } else {
      print('===================> error: $result');
    }
  }

  Future<void> getMovieScreenshots() async {
    setLoading(true);
    final result = await repository.getMovieImage(
      apiKey: Constants.API_KEY,
      movieId: movieId,
    );
    setLoading(false);
    if (result is MovieImage) {
      _movieDetail!.movieImage = result;
      update();
    } else {
      print('===================> error: $result');
    }
  }

  Future<void> getMovieTrailerId() async {
    setLoading(true);
    final result = await repository.getTrailerId(
      apiKey: Constants.API_KEY,
      movieId: movieId,
    );
    setLoading(false);
    if (result is TrailerResponse) {
      if (result.trailers!.isNotEmpty)
        _movieDetail!.trailerId = result.trailers![0].key;
      update();
    } else {
      print('===================> error: $result');
    }
  }

  Future<void> getMovieCastList() async {
    setLoading(true);
    final result = await repository.getCastList(
      apiKey: Constants.API_KEY,
      movieId: movieId,
    );
    setLoading(false);
    if (result is CastResponse) {
      _movieDetail!.castList = result.casts;
      update();
    } else {
      print('===================> error: $result');
    }
  }

  MovieDetail? get movieDetail => _movieDetail;
}
