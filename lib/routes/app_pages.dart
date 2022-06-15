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
      name: AppRoutes.initial,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.movieDetail,
      page: () => const MovieDetailPage(),
      binding: MovieDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.personDetail,
      page: () => const PersonDetailPage(),
      binding: PersonDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.discoverMore,
      page: () => const DiscoverMorePage(),
      binding: DiscoverMoreBinding(),
    ),
    GetPage(
      name: AppRoutes.nowPlayingMore,
      page: () => const NowPlayingMorePage(),
      binding: NowPlayingMoreBinding(),
    ),
    GetPage(
      name: AppRoutes.popularMore,
      page: () => const PopularMorePage(),
      binding: PopularMoreBinding(),
    ),
    GetPage(
      name: AppRoutes.topRatedMore,
      page: () => const TopRatedMorePage(),
      binding: TopRatedMoreBinding(),
    ),
    GetPage(
      name: AppRoutes.peopleMore,
      page: () => const PeopleMorePage(),
      binding: PeopleMoreBinding(),
    ),
  ];
}
