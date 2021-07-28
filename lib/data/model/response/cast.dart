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
