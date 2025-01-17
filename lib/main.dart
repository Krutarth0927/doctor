import 'package:d2/onbording/onbording.dart';
import 'package:d2/user/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'menu/reminder.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
