import 'package:flutter/material.dart';

class DetailsHeadlineText extends StatelessWidget {
  final String text;
  double getResponsiveFontSize(BuildContext context, double baseFontSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    return baseFontSize * (screenWidth / 375.0); // 375 is a base screen width
  }
  const DetailsHeadlineText({super.key, required this.text, required this.baseFontSize});

  final double baseFontSize;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.all(size.width / 50),
      child: Text(
        text,
        style:    TextStyle(
          letterSpacing: 1.9,
          fontSize: getResponsiveFontSize(context, baseFontSize),
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      ),
    );
  }
}
