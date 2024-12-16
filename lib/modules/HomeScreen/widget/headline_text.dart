import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeadlineText extends StatelessWidget {
  final String text;

  const HeadlineText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.all(size.width / 50),
      child: Text(
        text,
        style:  TextStyle(
          letterSpacing: 0.1,
          fontSize: 20.sp,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      ),
    );
  }
}
