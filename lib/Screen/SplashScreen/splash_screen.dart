// import 'dart:async';
//
// import '/utils/image.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../Controllers/auth-controller.dart';
// import '../../Controllers/global-controller.dart';
// import '../Authentication/sign_in.dart';
// import '../Widgets/constant.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//
//   final AuthController _authController = AuthController();
//
//   @override
//   void initState() {
//     // FirebaseMessaging.instance
//     //     .getInitialMessage()
//     //     .then((RemoteMessage? message) {});
//     // FirebaseMessaging.onMessage.listen((RemoteMessage message) {});
//     // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
//     // FirebaseMessaging.instance.getToken().then((token) {
//     //   update(token!);
//     // });
//     Timer(
//       const Duration(seconds: 2),
//           () => {
//         logInCheck(),
//       },
//     );
//     super.initState();
//   }
//
//   update(String token) async {
//     SharedPreferences storage = await SharedPreferences.getInstance();
//     await storage.setString('deviceToken', token);
//     print('fcm token===========>');
//     print(token);
//   }
//
//
//
//   logInCheck() async {
//     if (Get.find<GlobalController>().isUser) {
//        _authController.refreshToken();
//     } else {
//       Get.off(() => const SignIn());
//     }
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kMainColor,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children:  [
//           Center(
//             child: Image(
//               image: AssetImage(Images.appLogo),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'dart:async';

import '/utils/image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Controllers/auth-controller.dart';
import '../../Controllers/global-controller.dart';
import '../Authentication/sign_in.dart';
import '../Widgets/constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final AuthController _authController = AuthController();
  late AnimationController _bounceController;

  @override
  void initState() {
    super.initState();

    // Bounce animation controller
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    // Firebase messaging token (as before)
    // FirebaseMessaging.instance.getToken().then((token) {
    //   update(token!);
    // });

    Timer(const Duration(seconds: 2), () => logInCheck());
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  update(String token) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('deviceToken', token);
    print('fcm token===========> $token');
  }

  logInCheck() async {
    if (Get.find<GlobalController>().isUser) {
      _authController.refreshToken();
    } else {
      Get.off(() => const SignIn());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor, // fallback
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              kMainColor,      // #7E0095
              kSecondaryColor, // #D84474
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated truck image with bounce
            AnimatedBuilder(
              animation: _bounceController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _bounceController.value * -15),
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        // Replace with your real truck image asset
                        Images.truck, // Make sure you add this asset
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            // App Name
            const Text(
              'We Courier',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.5,
                shadows: [
                  Shadow(
                    blurRadius: 10,
                    color: Colors.black26,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Tagline
            const Text(
              'Fast. Reliable. Smart Delivery',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 40),
            // Loading dots (pulse animation)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDot(delay: 0),
                const SizedBox(width: 12),
                _buildDot(delay: 0.2),
                const SizedBox(width: 12),
                _buildDot(delay: 0.4),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot({required double delay}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.4, end: 1.0),
        duration: const Duration(milliseconds: 800),
        builder: (context, opacity, child) {
          return Opacity(
            opacity: opacity,
            child: child,
          );
        },
        child: Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}