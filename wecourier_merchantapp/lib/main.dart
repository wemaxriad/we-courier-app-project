import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wecourier_merchantapp/services/notification_service.dart';

import 'Controllers/global-controller.dart';
import 'Locale/language.dart';
import 'Screen/SplashScreen/splash_screen.dart';
import 'Screen/Widgets/constant.dart';


Future<void> main() async {
  final box = GetStorage();
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService notificationService = NotificationService();
  await notificationService.initialize();

  await GetStorage.init();
  dynamic langValue = const Locale('en', 'US');
  if (box.read('lang') != null) {
    langValue = Locale(box.read('lang'), box.read('langKey'));
  } else {
    langValue = const Locale('en', 'US');
  }

  runApp( MyApp(lang: langValue,));
}

class MyApp extends StatelessWidget {
  final Locale lang;
  MyApp({Key? key, required this.lang}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: kMainColor
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Get.put(GlobalController()).onInit();

    return  ScreenUtilInit(
        designSize: Size(360, 800),
        builder: ((context, child) =>
            GetMaterialApp(
              debugShowCheckedModeBanner: false,
              translations: Languages(),
              locale: lang,
              title: 'Merchant',
              theme: ThemeData(fontFamily: 'Display'),
              home: const SplashScreen(),
            )));
  }
}

