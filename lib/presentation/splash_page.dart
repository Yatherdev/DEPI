import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../Widgets/gradiant_scaffold.dart';
import 'home_page.dart';
import 'login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: Center(
        child: Lottie.asset(
          'Assets/animation/splash.json',
          width: 250,
          height: 250,
          fit: BoxFit.contain,
          onLoaded: (composition) {
            Future.delayed(composition.duration, () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            });
          },
        ),
      ),
    );
  }
}
