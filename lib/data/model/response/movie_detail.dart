import 'package:kino_app/data/model/response/cast_response.dart';
import 'package:kino_app/data/model/response/movie_image.dart';

class MovieDetail {
  final String id;
  final String title;
  final String backdropPath;
  final int budget;
  final String homePage;
  final String originalTitle;
  final String overview;
  final String releaseDate;
  final int runtime;
  final String voteAverage;
  final String voteCount;
  String trailerId;
  MovieImage movieImage;
  List<Cast> castList;

  MovieDetail({
    this.id,
    this.title,
    this.backdropPath,
    this.budget,
    this.homePage,
    this.originalTitle,
    this.overview,
    this.releaseDate,
    this.runtime,
    this.voteAverage,
    this.voteCount,
  });

  factory MovieDetail.fromJson(dynamic json) {
    if (json == null) {
      return MovieDetail();
    }

    return MovieDetail(
      id: json['id'].toString(),
      title: json['title'],
      backdropPath: json['backdrop_path'],
      budget: json['budget'],
      homePage: json['home_page'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      runtime: json['runtime'],
      voteAverage: json['vote_average'].toString(),
      voteCount: json['vote_count'].toString(),
    );
  }
}
