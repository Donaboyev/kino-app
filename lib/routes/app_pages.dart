import 'package:get/get.dart';
import 'package:kino_app/binding/home_binding.dart';
import 'package:kino_app/routes/app_routes.dart';
import 'package:kino_app/ui/home/home_screen.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
