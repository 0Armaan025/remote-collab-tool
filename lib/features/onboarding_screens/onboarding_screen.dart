import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/background_final_button.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:remote_collab_tool/constants/utils/utils.dart';
import 'package:remote_collab_tool/features/auth/screens/sign_in_page.dart';
import 'package:remote_collab_tool/features/auth/screens/sign_up_page.dart';

import '../../theme/pallete.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return OnBoardingSlider(
      finishButtonText: 'Register',
      onFinish: () {
        moveScreen(context: context, widget: SignUpPage());
      },
      finishButtonStyle: FinishButtonStyle(
        backgroundColor: Pallete.buttonColor,
      ),
      skipTextButton: Text(
        'Skip',
        style: TextStyle(
          fontSize: 16,
          color: Pallete.headlineTextColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Text(
        'Login',
        style: TextStyle(
          fontSize: 16,
          color: Pallete.buttonTextColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailingFunction: () {
        moveScreen(context: context, widget: SignInPage());
      },
      controllerColor: Pallete.headlineTextColor,
      totalPage: 3,
      headerBackgroundColor: Colors.white,
      pageBackgroundColor: Colors.white,
      background: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Image.network(
            'https://images.unsplash.com/photo-1614599238226-52da68de19ab?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8cHJvZHVjdGl2aXR5fGVufDB8MXwwfHx8MA%3D%3D',
            width: size.width * 0.9,
            height: size.height * 0.6,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Image.network(
            'https://plus.unsplash.com/premium_photo-1677109898965-7ae03cdbc4d4?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8cG9tb2Rvcm8lMjB0aW1lcnxlbnwwfDF8MHx8fDA%3D',
            width: size.width * 0.9,
            height: size.height * 0.6,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Image.network(
            'https://plus.unsplash.com/premium_photo-1672921845474-16c7fd5a7515?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8ZGFzaGJvYXJkfGVufDB8MXwwfHx8MA%3D%3D',
            width: size.width * 0.9,
            height: size.height * 0.6,
            fit: BoxFit.cover,
          ),
        ),
      ],
      speed: 1.8,
      pageBodies: [
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 480,
              ),
              Text(
                'Get stuff done.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Pallete.headlineTextColor,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'to rapidly finish tasks!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 480,
              ),
              Text(
                'Pomodoro timers',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Pallete.headlineTextColor,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Time to do work like you never did, super fast',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 480,
              ),
              Text(
                'Start now!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Pallete.headlineTextColor,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Where you get every task done with snaps, and you are productive like you never were with complete reports!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
