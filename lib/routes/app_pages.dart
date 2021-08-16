import 'package:get/get.dart';
import 'package:kino_app/binding/discover_more_binding.dart';
import 'package:kino_app/binding/home_binding.dart';
import 'package:kino_app/binding/movie_detail_binding.dart';
import 'package:kino_app/binding/now_playing_more_binding.dart';
import 'package:kino_app/binding/people_more_binding.dart';
import 'package:kino_app/binding/person_detail_binding.dart';
import 'package:kino_app/binding/popular_more_binding.dart';
import 'package:kino_app/binding/top_rated_more_binding.dart';
import 'package:kino_app/routes/app_routes.dart';
import 'package:kino_app/ui/discover_more/discover_more_screen.dart';
import 'package:kino_app/ui/home/home_screen.dart';
import 'package:kino_app/ui/movie_detail/movie_detail_screen.dart';
import 'package:kino_app/ui/now_playing_more/now_playing_more_screen.dart';
import 'package:kino_app/ui/people_more/people_more_screen.dart';
import 'package:kino_app/ui/person_detail/person_detail_screen.dart';
import 'package:kino_app/ui/popular_more/popular_more_screen.dart';
import 'package:kino_app/ui/top_rated_more/top_rated_more_screen.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.MOVIE_DETAIL,
      page: () => MovieDetailPage(),
      binding: MovieDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.PERSON_DETAIL,
      page: () => PersonDetailPage(),
      binding: PersonDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.DISCOVER_MORE,
      page: () => DiscoverMorePage(),
      binding: DiscoverMoreBinding(),
    ),
    GetPage(
      name: AppRoutes.NOW_PLAYING_MORE,
      page: () => NowPlayingMorePage(),
      binding: NowPlayingMoreBinding(),
    ),
    GetPage(
      name: AppRoutes.POPULAR_MORE,
      page: () => PopularMorePage(),
      binding: PopularMoreBinding(),
    ),
    GetPage(
      name: AppRoutes.TOP_RATED_MORE,
      page: () => TopRatedMorePage(),
      binding: TopRatedMoreBinding(),
    ),
    GetPage(
      name: AppRoutes.PEOPLE_MORE,
      page: () => PeopleMorePage(),
      binding: PeopleMoreBinding(),
    ),
  ];
}
