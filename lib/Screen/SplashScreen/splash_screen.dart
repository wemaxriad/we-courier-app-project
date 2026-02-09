import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Controllers/auth-controller.dart';
import '../../Controllers/global-controller.dart';
import '../../utils/image.dart';
import '../Authentication/sign_in.dart';
import '../Widgets/constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController _authController = AuthController();

  @override
  void initState() {
    super.initState();

    /// On kill state → app opened from notification
    // FirebaseMessaging.instance.getInitialMessage().then((message) {
    //   if (message != null) {
    //     _handleNotificationNavigation(message);
    //   }
    // });
    //
    // /// App in foreground
    // FirebaseMessaging.onMessage.listen((message) {
    //   print("🔥 FCM onMessage: ${message.notification?.title}");
    //   // You already show via local notification → do nothing here
    // });
    //
    // /// App reopened from background
    // FirebaseMessaging.onMessageOpenedApp.listen((message) {
    //   print("📲 App opened from notification (background)");
    //   _handleNotificationNavigation(message);
    // });
    //
    // /// Get FCM token
    // FirebaseMessaging.instance.getToken().then((token) {
    //   if (token != null) {
    //     saveToken(token);
    //   }
    // });

    /// Continue splash logic
    Timer(
      const Duration(seconds: 2),
          () => { logInCheck() },
    );
  }

  /// 🔥 Navigate based on notification data
  void _handleNotificationNavigation(RemoteMessage message) {
    print("📨 Notification data: ${message.data}");

    if (message.data['screen'] == "parcelDetails") {
      String id = message.data['id'];
      Get.toNamed('/parcelDetails', arguments: id);
    } else {
      print("No navigation target in notification.");
    }
  }

  /// ✔ Save token to shared preferences
  Future<void> saveToken(String token) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('deviceToken', token);
    print('FCM Token: $token');
  }

  /// ✔ Auto login or go to SignIn
  logInCheck() {
    if (Get.find<GlobalController>().isUser) {
      _authController.refreshToken(context);
    } else {
      Get.off(() => const SignIn());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Center(child: Image(image: AssetImage(Images.appLogo))),
    );
  }
}
