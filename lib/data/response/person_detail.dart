class PersonDetail {
  final int? id;
  final bool? adult;
  final List<String>? knownAs;
  final String? biography;
  final String? birthday;
  final String? knownForDepartment;
  final String? name;
  final String? placeOfBirth;
  final String? profilePath;

  PersonDetail({
    this.adult,
    this.knownAs,
    this.biography,
    this.birthday,
    this.knownForDepartment,
    this.name,
    this.placeOfBirth,
    this.profilePath,
    this.id,
  });

  factory PersonDetail.fromJson(dynamic json) {
    if (json == null) {
      return PersonDetail();
    }

    return PersonDetail(
      id: json['id'],
      adult: json['adult'],
      knownAs: json['also_known_as'].cast<String>(),
      biography: json['biography'],
      birthday: json['birthday'],
      knownForDepartment: json['known_for_department'],
      name: json['name'],
      placeOfBirth: json['place_of_birth'],
      profilePath: json['profile_path'],
    );
  }
}
