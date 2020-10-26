import 'package:edqub/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import './name-generator.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Container(
        child: Image.asset(
          'assets/edqub_light_logo.png',
          fit: BoxFit.cover,
        ),
      ),
      splashTransition: SplashTransition.scaleTransition,
      pageTransitionType: PageTransitionType.leftToRight,
      backgroundColor: Colors.purple,
      duration: 3000,
      nextScreen: Login(),
    );
  }
}
