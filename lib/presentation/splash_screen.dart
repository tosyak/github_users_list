import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import 'package:github_test_app/app/app_router.dart';
import 'package:github_test_app/bloc/splash_bloc/splash_bloc_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  void navigateUsersListScreen() {
    context.goNamed(PAGES.usersList.screenName);
  }

  void navigateNoNetworkScreen() {
    context.goNamed(PAGES.noNetwork.screenName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashNetworkConnected) {
            Timer(const Duration(seconds: 3), navigateUsersListScreen);
          } else if (state is SplashNetworkNotConnected) {
            Timer(const Duration(seconds: 3), navigateNoNetworkScreen);
          }
        },
        child: Center(
          child: Lottie.asset('assets/animations/splash_animation.json'),
        ),
      ),
    );
  }
}
