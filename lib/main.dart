import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'Controllers/global-controller.dart';
import 'Locale/language.dart';
import 'Screen/SplashScreen/splash_screen.dart';
import 'Screen/Widgets/constant.dart';
import 'firebase_options.dart';
import 'services/notification_service.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   try {
//     await Firebase.initializeApp(
//       name: 'wecourier_bg',
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//   } catch (e) {
//     // Ignore "already initialized" error
//   }
//
//   print("Background Message: ${message.notification?.title}");
// }


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //
  // // Ensure permissions requested
  // await FirebaseMessaging.instance.requestPermission();

  // Local notification setup
  // await NotificationService().setupNotificationChannel();
  // await NotificationService().initLocalNotification();
  // NotificationService().listenFCMMessages();

  await GetStorage.init();
  final box = GetStorage();

  Locale lang = const Locale('en', 'US');
  if (box.read('lang') != null) {
    lang = Locale(box.read('lang'), box.read('langKey'));
  }

  runApp(MyApp(lang: lang));
}


class MyApp extends StatelessWidget {
  final Locale lang;
  const MyApp({super.key, required this.lang});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: kMainColor),
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    Get.put(GlobalController());

    return ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (_, __) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        translations: Languages(),
        locale: lang,
        title: 'Driver',
        theme: ThemeData(fontFamily: 'Display'),
        home: const SplashScreen(),
      ),
    );
  }
}
