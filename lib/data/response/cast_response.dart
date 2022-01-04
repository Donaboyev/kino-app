class CastResponse {
  List<Cast>? casts;

  CastResponse({this.casts});

  CastResponse.fromJson(Map<String, dynamic> json) {
    if (json['cast'] != null) {
      casts = <Cast>[];
      json['cast'].forEach((v) {
        casts!.add(new Cast.fromJson(v));
      });
    } else {
      casts = [];
    }
  }
}

class Cast {
  final int? id;
  final String? name;
  final String? character;
  final String? profilePath;

  Cast({
    this.id,
    this.name,
    this.character,
    this.profilePath,
  });

  factory Cast.fromJson(dynamic json) {
    return Cast(
      id: json['id'],
      name: json['name'],
      character: json['character'],
      profilePath: json['profile_path'],
    );
  }
}
