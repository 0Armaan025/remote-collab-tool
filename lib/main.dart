import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remote_collab_tool/employee/create_and_assign_task/create_and_assign_task_page.dart';
import 'package:remote_collab_tool/employee/home_screen/employee_home_screen.dart';
import 'package:remote_collab_tool/employer/employer_organization_view_screen/employer_organization_view_screen.dart';
import 'package:remote_collab_tool/employer/home_screen/employer_home_screen.dart';

import 'package:remote_collab_tool/features/auth/screens/sign_in_page.dart';
import 'package:remote_collab_tool/features/auth/screens/sign_up_page.dart';
import 'package:remote_collab_tool/employer/setup_screen/employer_setup.dart';
import 'package:remote_collab_tool/features/onboarding_screens/onboarding_screen.dart';
import 'package:remote_collab_tool/features/pomodoro_timer/pomodoro_timer_screen.dart';
import 'package:remote_collab_tool/employer/members_screen/employers_member_screen.dart';

import 'package:remote_collab_tool/features/share_files/share_files_screen.dart';

import 'package:remote_collab_tool/features/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // sharedPreferences = await SharedPreferences.getInstance();
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
          EmployerSetupPage(uid: FirebaseAuth.instance.currentUser?.uid ?? ''),
    );
  }
}
