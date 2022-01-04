import 'cast_response.dart';
import 'movie_image.dart';

class MovieDetail {
  final String? id;
  String? trailerId;
  final int? budget;
  final int? runtime;
  final String? title;
  List<Cast>? castList;
  final String? homePage;
  final String? overview;
  final String? voteCount;
  final String? voteAverage;
  final String? releaseDate;
  final String? backdropPath;
  final String? originalTitle;
  late MovieImage movieImage;

  MovieDetail({
    this.id,
    this.title,
    this.budget,
    this.runtime,
    this.homePage,
    this.overview,
    this.voteCount,
    this.releaseDate,
    this.voteAverage,
    this.backdropPath,
    this.originalTitle,
  });

  factory MovieDetail.fromJson(dynamic json) {
    if (json == null) {
      return MovieDetail();
    }

    return MovieDetail(
      title: json['title'],
      budget: json['budget'],
      runtime: json['runtime'],
      id: json['id'].toString(),
      overview: json['overview'],
      homePage: json['home_page'],
      releaseDate: json['release_date'],
      backdropPath: json['backdrop_path'],
      originalTitle: json['original_title'],
      voteCount: json['vote_count'].toString(),
      voteAverage: json['vote_average'].toString(),
    );
  }
}
