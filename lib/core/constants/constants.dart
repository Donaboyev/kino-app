import 'package:kino_app/core/constants/version_enum.dart';

class Constants {
  static const BASE_URL = 'https://api.themoviedb.org/3/';
  static const API_KEY = 'YOUR_API_KEY';
  static const VERSION = String.fromEnvironment('VERSION');
  static const Version RUNNING =
      VERSION == 'lazy' ? Version.LAZY : Version.WAIT;
}
