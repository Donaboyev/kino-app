class TrailerResponse {
  List<Trailer> trailers;
  int id;

  TrailerResponse({this.trailers, this.id});

  TrailerResponse.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      trailers = <Trailer>[];
      json['results'].forEach((v) {
        trailers.add(new Trailer.fromJson(v));
      });
    } else {
      trailers = [];
    }
    id = json['id'];
  }
}

class Trailer {
  final String iso6391;
  final String iso31661;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  final String publishedAt;
  final String id;

  Trailer({
    this.iso6391,
    this.iso31661,
    this.key,
    this.site,
    this.size,
    this.type,
    this.official,
    this.publishedAt,
    this.id,
    this.name,
  });

  factory Trailer.fromJson(dynamic json) {
    if (json == null) {
      return Trailer();
    }

    return Trailer(
      id: json['id'].toString(),
      iso6391: json['iso_639_1'].toString(),
      name: json['name'].toString(),
      iso31661: json['iso_3166_1'].toString(),
      key: json['key'].toString(),
      site: json['site'].toString(),
      size: json['size'],
      type: json['type'].toString(),
      official: json['official'],
      publishedAt: json['published_at'].toString(),
    );
  }
}
