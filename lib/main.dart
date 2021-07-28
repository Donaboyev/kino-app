import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:kino_app/binding/home_binding.dart';
import 'package:kino_app/core/constants/constants.dart';
import 'package:kino_app/core/constants/version_enum.dart';
import 'package:kino_app/core/notification_service.dart';
import 'package:kino_app/data/remote/api_client.dart';
import 'package:kino_app/routes/app_pages.dart';
import 'package:kino_app/routes/app_routes.dart';
import 'package:kino_app/ui/home/home_screen.dart';
import 'package:rxdart/rxdart.dart';

void main() async {
  if (Constants.RUNNING == Version.WAIT) {
    await HomeBinding().dependencies();
  }
  // await NotificationService().init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isBuild = true;

  bool _initialized = false;

  @override
  void initState() {
    init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.INITIAL,
      navigatorKey: ApiClient.alice.getNavigatorKey(),
      getPages: AppPages.pages,
      defaultTransition: Transition.zoom,
      home: HomePage(),
    );
  }

  Future<void> init(context) async {
    if (!_initialized) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      _initialized = true;
    }
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();
