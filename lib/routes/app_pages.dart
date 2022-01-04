import 'package:get/get.dart';

import '../ui/now_playing_more/now_playing_more_screen.dart';
import '../ui/top_rated_more/top_rated_more_screen.dart';
import '../ui/person_detail/person_detail_screen.dart';
import '../ui/discover_more/discover_more_screen.dart';
import '../ui/movie_detail/movie_detail_screen.dart';
import '../ui/popular_more/popular_more_screen.dart';
import '../ui/people_more/people_more_screen.dart';
import '../binding/now_playing_more_binding.dart';
import '../binding/top_rated_more_binding.dart';
import '../binding/person_detail_binding.dart';
import '../binding/discover_more_binding.dart';
import '../binding/popular_more_binding.dart';
import '../binding/movie_detail_binding.dart';
import '../binding/people_more_binding.dart';
import '../binding/home_binding.dart';
import '../ui/home/home_screen.dart';
import 'app_routes.dart';

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
