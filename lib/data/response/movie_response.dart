class MovieResponse {
  List<Movie> movies;
  int totalPages;

  MovieResponse({this.movies});

  MovieResponse.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      movies = <Movie>[];
      json['results'].forEach((v) {
        movies.add(new Movie.fromJson(v));
      });
    } else {
      movies = [];
    }
    totalPages = json['total_pages'];
  }
}

class Movie {
  final String backdropPath;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final num popularity;
  final String posterPath;
  final String releaseDate;
  final String title;
  final bool video;
  final int voteCount;
  final String voteAverage;

  Movie({
    this.backdropPath,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteCount,
    this.voteAverage,
  });

  factory Movie.fromJson(dynamic json) {
    if (json == null) {
      return Movie();
    }

    return Movie(
      backdropPath: json['backdrop_path'],
      id: json['id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      title: json['title'],
      video: json['video'],
      voteCount: json['vote_count'],
      voteAverage: json['vote_average'].toString(),
    );
  }
}
