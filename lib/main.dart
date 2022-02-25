import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/constants/version_enum.dart';
import 'core/constants/constants.dart';
import 'data/network/api_client.dart';
import 'binding/home_binding.dart';
import 'ui/home/home_screen.dart';
import 'routes/app_routes.dart';
import 'routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Constants.running == Version.wait) await HomeBinding().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initial,
      navigatorKey: ApiClient.alice.getNavigatorKey(),
      getPages: AppPages.pages,
      defaultTransition: Transition.zoom,
      transitionDuration: const Duration(milliseconds: 300),
      home: const HomePage(),
    );
  }
}
