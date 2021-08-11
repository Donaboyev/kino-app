class GenreResponse {
  List<Genre> genres;

  GenreResponse({this.genres});

  GenreResponse.fromJson(Map<String, dynamic> json) {
    if (json['genres'] != null) {
      genres = <Genre>[];
      json['genres'].forEach((v) {
        genres.add(new Genre.fromJson(v));
      });
    } else {
      genres = [];
    }
  }
}

class Genre {
  final int id;
  final String name;

  Genre({
    this.id,
    this.name,
  });

  factory Genre.fromJson(dynamic json) {
    if (json == null) {
      return Genre();
    }
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }
}
