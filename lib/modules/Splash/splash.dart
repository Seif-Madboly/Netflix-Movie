// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../config/routes/app_router.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override

  void initState() {
    super.initState();

    Timer(const Duration(seconds: 4), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.onBoardingScreen,
            (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        "assets/images/netflix.json",
      ),
    );
  }
}
