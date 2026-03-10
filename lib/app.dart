import 'package:flutter/material.dart';
import 'package:itecotesttask/features/splash/splash_screen.dart';

import 'core/constants.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Iteco Test',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Green.c800),
      ),
      home: const SplashScreen(),
    );
  }
}