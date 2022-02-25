import 'version_enum.dart';

class Constants {
  static const baseUrl = 'https://api.themoviedb.org/3/';
  static const apiKey = 'YOUR_API_KEY';
  static const version = String.fromEnvironment('VERSION');
  static const Version running =
      version == 'lazy' ? Version.lazy : Version.wait;
  static const bigImageBaseUrl = 'https://image.tmdb.org/t/p/w780/';
  static const smallImageBaseUrl = 'https://image.tmdb.org/t/p/w200';
  static const originalImageBaseUrl = 'https://image.tmdb.org/t/p/original/';
  static const mediumImageBaseUrl = 'https://image.tmdb.org/t/p/w500';
}
