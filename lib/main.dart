import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minpro_gani/core/bloc/bloc.dart';
import 'package:minpro_gani/core/services/services.dart';

import 'dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        home: AnimatedSplashScreen(
            splash: const Text("Welcome Back Fellas",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            duration: 3000,
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Colors.white,
            nextScreen: const DashboardNavigation()));
  }
}
