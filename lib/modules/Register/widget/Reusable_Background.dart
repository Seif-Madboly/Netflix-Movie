// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../../constants/utils/app_assets.dart';


class ReusableBackground extends StatelessWidget {
  final String? backgorundImage;
  final BoxFit fit;
  final Widget child;

   const ReusableBackground({
    super.key,
     this.backgorundImage,
     this.fit = BoxFit.fill,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
           backgorundImage??  AppImageAssets.backGround,
          fit:fit,
        ),
        Align(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black,
                ],
              ),
            ),
          ),
        ),
        Positioned(
            bottom: MediaQuery.of(context).size.height / 90,
            left: size.width * 0.05,
            right: size.width * 0.05,
            child: child
        ),
      ],
    );
  }
}
