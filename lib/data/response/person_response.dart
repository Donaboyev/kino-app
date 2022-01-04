class PersonResponse {
  int? totalPages;
  List<Person>? people;

  PersonResponse({this.totalPages, this.people});

  PersonResponse.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      people = <Person>[];
      json['results'].forEach((v) {
        people!.add(new Person.fromJson(v));
      });
    } else {
      people = [];
    }
    totalPages = json['total_pages'];
  }
}

class Person {
  final int? id;
  final String? name;
  final String? gender;
  final String? popularity;
  final String? profilePath;
  final String? knowForDepartment;

  Person({
    this.id,
    this.name,
    this.gender,
    this.popularity,
    this.profilePath,
    this.knowForDepartment,
  });

  factory Person.fromJson(dynamic json) {
    return Person(
      id: json['id'],
      name: json['name'],
      gender: json['gender'].toString(),
      profilePath: json['profile_path'],
      popularity: json['popularity'].toString(),
      knowForDepartment: json['known_for_department'],
    );
  }
}
