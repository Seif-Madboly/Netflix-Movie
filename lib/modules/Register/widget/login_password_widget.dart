import 'dart:developer';

import 'package:flutter/material.dart';


class LoginPasswordWidget extends StatefulWidget {
  const LoginPasswordWidget({super.key, required this.controller, this.validator, this.fontWeight, this.textStyle, this.textInputAction});
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final FontWeight? fontWeight;
  final TextStyle? textStyle;
  final TextInputAction? textInputAction;

  @override
  State<LoginPasswordWidget> createState() => _LoginPasswordWidgetState();
}

class _LoginPasswordWidgetState extends State<LoginPasswordWidget> {
  bool isPasswordHidden = true;


  void _changePasswordVisibility() {
    setState(() {
      isPasswordHidden = !isPasswordHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double baseFontSize = screenSize.width * 0.05;
    return TextFormField(
      validator: widget.validator,
      controller:widget. controller,
      textInputAction:widget.textInputAction ,
      keyboardType: TextInputType.visiblePassword,
      obscureText: isPasswordHidden,
      onFieldSubmitted: (value) {
        log(value);
      },
      decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          labelStyle: TextStyle(
            fontSize:  baseFontSize * 0.9,
            fontWeight: widget.fontWeight,
              color: Colors.white
          ),
        hintStyle:widget.textStyle ?? TextStyle(
            fontSize: baseFontSize * 0.8,
            fontWeight: FontWeight.normal,
            color: Colors.white
        ),
         suffixIcon: IconButton(
          onPressed: _changePasswordVisibility,
          icon: Icon(
            isPasswordHidden
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: Colors.grey,
          ),
        ),
        hintText:"Password",

      ),
      style: TextStyle(
          fontSize: baseFontSize,
          color: Colors.white
      ),
    );
  }
}
