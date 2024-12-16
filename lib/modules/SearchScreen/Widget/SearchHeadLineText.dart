// ignore_for_file: file_names

import 'package:flutter/material.dart';

class SearchHeadlineText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  double getResponsiveFontSize(BuildContext context, double baseFontSize) {
    double screenWidth = MediaQuery.of(context).size.width;
    return baseFontSize * (screenWidth / 375.0); // 375 is a base screen width
  }
  const SearchHeadlineText({super.key, required this.text, required this.baseFontSize,  this.fontWeight,this.maxLine});
final int ?maxLine ;
  final double baseFontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines:maxLine,
      style: TextStyle(
        letterSpacing: 1.9,
        fontSize: getResponsiveFontSize(context, baseFontSize),
        fontWeight: fontWeight,
        color: Colors.white,
      ),
    );
  }
}
