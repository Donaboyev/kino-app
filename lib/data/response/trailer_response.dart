class TrailerResponse {
  int? id;
  List<Trailer>? trailers;

  TrailerResponse({this.trailers, this.id});

  TrailerResponse.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      trailers = <Trailer>[];
      json['results'].forEach((v) {
        trailers!.add(new Trailer.fromJson(v));
      });
    } else {
      trailers = [];
    }
    id = json['id'];
  }
}

class Trailer {
  final int? size;
  final String? id;
  final String? key;
  final String? name;
  final String? site;
  final String? type;
  final bool? official;
  final String? iso6391;
  final String? iso31661;
  final String? publishedAt;

  Trailer({
    this.id,
    this.key,
    this.site,
    this.size,
    this.type,
    this.name,
    this.iso6391,
    this.iso31661,
    this.official,
    this.publishedAt,
  });

  factory Trailer.fromJson(dynamic json) {
    return Trailer(
      size: json['size'],
      id: json['id'].toString(),
      official: json['official'],
      key: json['key'].toString(),
      site: json['site'].toString(),
      type: json['type'].toString(),
      name: json['name'].toString(),
      iso6391: json['iso_639_1'].toString(),
      iso31661: json['iso_3166_1'].toString(),
      publishedAt: json['published_at'].toString(),
    );
  }
}
