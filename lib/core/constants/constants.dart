import 'version_enum.dart';

class Constants {
  static const BASE_URL = 'https://api.themoviedb.org/3/';
  static const API_KEY = 'YOUR_API_KEY';
  static const VERSION = String.fromEnvironment('VERSION');
  static const Version RUNNING =
      VERSION == 'lazy' ? Version.LAZY : Version.WAIT;
  static const BIG_IMAGE_BASE_URL = 'https://image.tmdb.org/t/p/w780/';
  static const SMALL_IMAGE_BASE_URL = 'https://image.tmdb.org/t/p/w200';
  static const ORIGINAL_IMAGE_BASE_URL = 'https://image.tmdb.org/t/p/original/';
  static const MEDIUM_IMAGE_BASE_URL = 'https://image.tmdb.org/t/p/w500';
}
