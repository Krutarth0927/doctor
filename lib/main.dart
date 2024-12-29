import 'package:d2/onbording/onbording.dart';
import 'package:d2/user/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'menu/reminder.dart';

Future<void> main() async {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
    debugShowCheckedModeBanner: false,
  home: OnboardingScreen(),
    );
  }
}
