class PersonResponse {
  List<Person>? people;
  int? totalPages;

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
  final String? gender;
  final String? name;
  final String? profilePath;
  final String? knowForDepartment;
  final String? popularity;

  Person({
    this.id,
    this.gender,
    this.name,
    this.profilePath,
    this.knowForDepartment,
    this.popularity,
  });

  factory Person.fromJson(dynamic json) {
    // if (json == null) {
    //   return Person();
    // }

    return Person(
      id: json['id'],
      gender: json['gender'].toString(),
      name: json['name'],
      profilePath: json['profile_path'],
      knowForDepartment: json['known_for_department'],
      popularity: json['popularity'].toString(),
    );
  }
}
