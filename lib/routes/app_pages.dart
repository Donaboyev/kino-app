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
      name: AppRoutes.initial,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.movieDetail,
      page: () => MovieDetailPage(),
      binding: MovieDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.personDetail,
      page: () => PersonDetailPage(),
      binding: PersonDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.discoverMore,
      page: () => DiscoverMorePage(),
      binding: DiscoverMoreBinding(),
    ),
    GetPage(
      name: AppRoutes.nowPlayingMore,
      page: () => NowPlayingMorePage(),
      binding: NowPlayingMoreBinding(),
    ),
    GetPage(
      name: AppRoutes.popularMore,
      page: () => PopularMorePage(),
      binding: PopularMoreBinding(),
    ),
    GetPage(
      name: AppRoutes.topRatedMore,
      page: () => TopRatedMorePage(),
      binding: TopRatedMoreBinding(),
    ),
    GetPage(
      name: AppRoutes.peopleMore,
      page: () => PeopleMorePage(),
      binding: PeopleMoreBinding(),
    ),
  ];
}
