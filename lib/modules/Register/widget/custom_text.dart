import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final double ?letterSpacing;
  final Color? color;
  final FontWeight? bold;
  final Alignment? alignment;
final int? maxLines;

    const CustomText({super.key, this.text = "", this.color , this.alignment = Alignment.topLeft, this.bold,   this.letterSpacing, this.maxLines,  this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        text,
        maxLines:maxLines,
        style: TextStyle(
          overflow: TextOverflow.ellipsis,
          letterSpacing:letterSpacing ,
          color: color,
          fontSize: fontSize,
          fontWeight: bold
        ),
      ),
    );
  }
}
