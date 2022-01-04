class MovieResponse {
  int? totalPages;
  List<Movie>? movies;

  MovieResponse({this.movies});

  MovieResponse.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      movies = <Movie>[];
      json['results'].forEach((v) {
        movies!.add(new Movie.fromJson(v));
      });
    } else {
      movies = [];
    }
    totalPages = json['total_pages'];
  }
}

class Movie {
  final int? id;
  final bool? video;
  final String? title;
  final int? voteCount;
  final num? popularity;
  final String? overview;
  final String? posterPath;
  final String? voteAverage;
  final String? releaseDate;
  final String? backdropPath;
  final String? originalTitle;
  final String? originalLanguage;

  Movie({
    this.id,
    this.title,
    this.video,
    this.overview,
    this.voteCount,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.voteAverage,
    this.backdropPath,
    this.originalTitle,
    this.originalLanguage,
  });

  factory Movie.fromJson(dynamic json) {
    return Movie(
      id: json['id'],
      video: json['video'],
      title: json['title'],
      overview: json['overview'],
      voteCount: json['vote_count'],
      popularity: json['popularity'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      backdropPath: json['backdrop_path'],
      originalTitle: json['original_title'],
      originalLanguage: json['original_language'],
      voteAverage: json['vote_average'].toString(),
    );
  }
}
