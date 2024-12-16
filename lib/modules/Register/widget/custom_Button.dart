// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPress,
    this.color,
    this.icon,
    this.backgroundColor,
    this.fontSize,
  });
  final Color? backgroundColor;
  final Widget? icon;
  final String text;
  final Color? color;
  final double? fontSize;

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10).r,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          elevation: 20,
          foregroundColor: const Color(0xff01BAEF),
          backgroundColor:backgroundColor ,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10).w,
          ),
          animationDuration: const Duration(milliseconds: 500),
          minimumSize:
          Size(
            0.4.sw, // 40% of screen width
            0.06.sh, // 6% of screen height
          ),

          // Size(
          //   MediaQuery.of(context).size.width *
          //       0.4, // set width to 40% of screen width
          //   MediaQuery.of(context).size.height *
          //       0.06, // set height to 7% of screen height
          // ),
        ),
        icon: icon?? const SizedBox(),
        onPressed: onPress,
        label: CustomText(
          fontSize: fontSize,
          text: text,
          alignment: Alignment.center,
          color: Colors.white,
          bold: FontWeight.normal,
        ),
      ),
    );
  }
}

/* MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(18),
          color: primaryColor,
          onPressed: onPress(),
          child: CustomText(
            text: text,
            alignment: Alignment.center,
            color: Colors.white,
          )),*/

/*ElevatedButton(
      style: ElevatedButton.styleFrom(
        //change the button's background color
        primary: primary,
        //colors of text,icon,hover,focus,pressed
        onPrimary: const Color(0xff01BAEF),
        elevation: 10,
        //gives padding to the button
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        //set minimum size for the button of (width, height)
        minimumSize: const Size(270, 56),
        //shape of the button
        shape: const StadiumBorder(),
        //the speed of the hover animation
        animationDuration: const Duration(milliseconds: 500),
        // textStyle: TextStyle(
        //   //this color will not overwrite the onPrimary text color
        //   color: Colors.green,
        //   fontSize: 20,
        //   fontWeight: FontWeight.bold,
        // ),
      ),
      child: Text(text, style: style),
      onPressed: onTap,
    );*/
