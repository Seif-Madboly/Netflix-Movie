import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? type;
  final String? labelText;
  final String? initialValue;
  final String? hintText;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final FormFieldSetter<String>? onChanged;
  final FormFieldSetter<String>? onSubmitted;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputAction? textInputAction;
  final FontWeight? fontWeight;
  final int? maxline;
  final TextStyle? textStyle;

  const CustomTextField({super.key,
    this.prefixIcon,
    required this.controller,
     this.labelText,
    this.hintText,
    this.obscureText = false,
    required  this.validator,
    this.onSaved,
    this.suffixIcon,
    this.type,
    required this.textInputAction,
    this.fontWeight,
    this.maxline,
    this.textStyle,
    this.onSubmitted, this.onChanged, this.initialValue
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double baseFontSize = screenSize.width * 0.05;
    return TextFormField(

      initialValue: initialValue,
      onChanged: onChanged,
      maxLines: maxline,
      controller: controller,
      textInputAction:textInputAction ,
      decoration: InputDecoration(
         enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
      ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),

          fillColor: Colors.white ,
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: baseFontSize * 0.9,
            fontWeight: fontWeight,
              color: Colors.white
          ),
          hintText: hintText,
          hintStyle: textStyle ?? TextStyle(
            fontSize: baseFontSize * 0.8,
            fontWeight: FontWeight.normal,
            color: Colors.white
          ),
          suffixIcon: suffixIcon
      ),
      obscureText: obscureText,
      validator: validator,
      onFieldSubmitted:onSubmitted ,
      onSaved: onSaved,
      style: TextStyle(
          fontSize: baseFontSize,
          color: Colors.white
      ),
      keyboardType: type,
    );
  }
}
