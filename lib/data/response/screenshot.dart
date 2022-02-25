import 'package:equatable/equatable.dart';

class Screenshot extends Equatable {
  final int? width;
  final int? height;
  final int? voteCount;
  final String? aspect;
  final String? imagePath;
  final String? countryCode;
  final double? voteAverage;

  const Screenshot({
    this.width,
    this.aspect,
    this.height,
    this.imagePath,
    this.voteCount,
    this.countryCode,
    this.voteAverage,
  });

  factory Screenshot.fromJson(Map<String, dynamic> json) {
    return Screenshot(
      width: json['width'],
      height: json['height'],
      imagePath: json['file_path'],
      voteCount: json['vote_count'],
      countryCode: json['iso_639_1'],
      voteAverage: json['vote_average'],
      aspect: json['aspect_ratio'].toString(),
    );
  }

  @override
  List<Object?> get props => [
        width,
        aspect,
        height,
        imagePath,
        voteCount,
        countryCode,
        voteAverage,
      ];
}
