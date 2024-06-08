import 'package:flutter/material.dart';
import 'package:remote_collab_tool/features/home/home_page.dart';
import 'package:remote_collab_tool/features/onboarding_screens/onboarding_screen.dart';
import 'package:remote_collab_tool/features/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
