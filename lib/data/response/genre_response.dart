class GenreResponse {
  List<Genre>? genres;

  GenreResponse({this.genres});

  GenreResponse.fromJson(Map<String, dynamic> json) {
    if (json['genres'] != null) {
      genres = <Genre>[];
      json['genres'].forEach((v) {
        genres!.add(Genre.fromJson(v));
      });
    } else {
      genres = [];
    }
  }
}

class Genre {
  final int? id;
  final String? name;

  Genre({this.id, this.name});

  factory Genre.fromJson(dynamic json) {
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }
}
