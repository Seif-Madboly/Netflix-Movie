import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/utils/const.dart';

class LandingCard extends StatelessWidget {
  const LandingCard({super.key, required this.image,   this.name});
  final ImageProvider image;
  final String? name;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height:  size.height * 0.46,
      width: size.width,
      child: Stack(
        children: [
          Container(
            width: size.width,
            height:  size.height * 0.45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30).w,
                image: DecorationImage(fit: BoxFit.cover, image: image)),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),

              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    backgroundPrimary.withOpacity(0.10),
                    backgroundPrimary.withOpacity(0.20),
                    backgroundPrimary.withOpacity(0.30),
                  ]),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30).w,

              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                  colors: [
                    backgroundPrimary.withOpacity(0.30),
                    backgroundPrimary.withOpacity(0.20),
                    backgroundPrimary.withOpacity(0.10),
                    Colors.transparent
                  ]),
            ),
          ),

        ],
      ),
    );
  }
}
