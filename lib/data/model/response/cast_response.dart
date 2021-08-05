class CastResponse {
  List<Cast> casts;

  CastResponse({this.casts});

  CastResponse.fromJson(Map<String, dynamic> json) {
    if (json['cast'] != null) {
      casts = <Cast>[];
      json['cast'].forEach((v) {
        casts.add(new Cast.fromJson(v));
      });
    } else {
      casts = [];
    }
  }
}

class Cast {
  final String name;
  final String profilePath;
  final String character;

  Cast({
    this.name,
    this.profilePath,
    this.character,
  });

  factory Cast.fromJson(dynamic json) {
    if (json == null) {
      return Cast();
    }

    return Cast(
      name: json['name'],
      profilePath: json['profile_path'],
      character: json['character'],
    );
  }
}
