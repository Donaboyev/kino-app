import 'package:equatable/equatable.dart';
import 'package:kino_app/data/response/screenshot.dart';

class MovieImage extends Equatable {
  final List<Screenshot> backdrops;
  final List<Screenshot> posters;

  const MovieImage({this.backdrops, this.posters});

  factory MovieImage.fromJson(Map<String, dynamic> result) {
    if (result == null) {
      return MovieImage();
    }

    return MovieImage(
      backdrops: (result['backdrops'] as List)
              ?.map((b) => Screenshot.fromJson(b))
              ?.toList() ??
          List.empty(),
      posters: (result['posters'] as List)
              ?.map((b) => Screenshot.fromJson(b))
              ?.toList() ??
          List.empty(),
    );
  }

  @override
  List<Object> get props => [backdrops, posters];
}
