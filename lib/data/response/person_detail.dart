class PersonDetail {
  final int? id;
  final bool? adult;
  final String? name;
  final String? birthday;
  final String? biography;
  final String? profilePath;
  final String? placeOfBirth;
  final List<String>? knownAs;
  final String? knownForDepartment;

  PersonDetail({
    this.id,
    this.name,
    this.adult,
    this.knownAs,
    this.birthday,
    this.biography,
    this.profilePath,
    this.placeOfBirth,
    this.knownForDepartment,
  });

  factory PersonDetail.fromJson(dynamic json) {
    if (json == null) {
      return PersonDetail();
    }
    return PersonDetail(
      id: json['id'],
      name: json['name'],
      adult: json['adult'],
      birthday: json['birthday'],
      biography: json['biography'],
      profilePath: json['profile_path'],
      placeOfBirth: json['place_of_birth'],
      knownAs: json['also_known_as'].cast<String>(),
      knownForDepartment: json['known_for_department'],
    );
  }
}
