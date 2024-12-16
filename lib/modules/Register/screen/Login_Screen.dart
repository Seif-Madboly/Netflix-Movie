// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netflix/modules/Register/widget/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/routes/app_router.dart';
import '../../../constants/utils/app_assets.dart';
import '../../../constants/utils/color.dart';
import '../widget/Custom_TextFormField.dart';
import '../widget/Reusable_Background.dart';
import '../widget/custom_Button.dart';
import '../widget/login_password_widget.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  void loginUser() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("isLoggedIn" , true);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Login Successful")));
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.bottomNavBar,
        (route) => false,
      );
    } catch (e) {
      if (e is FirebaseAuthException){
        final errorMessage = e.message ?? "An Unknown error occurred";
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            errorMessage,
            style: TextStyle(
              fontSize: 15.sp
            ),
          ),

        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackGround,
      body: ReusableBackground(
        backgorundImage: AppImageAssets.backGround,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CustomText(
                  text: 'Enter Phone Number to Continue',
                  fontSize: 18.sp,
                  bold: FontWeight.bold,
                  color: Colors.white,
                  alignment: Alignment.centerLeft,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomTextField(
                controller: emailController,
                labelText: 'Email Address',
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Email';
                  } else if (!value.contains("@gmail.com")) {
                    return 'Incorrect email format';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                type: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 8.h,
              ),
              LoginPasswordWidget(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                controller: passwordController,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(
                height: 18.h,
              ),
              CustomButton(
                text: "Login",
                fontSize: 16.sp,
                onPress: () {
                  if(formKey.currentState!.validate()){
                    loginUser();
                  }
                },
                backgroundColor: Colors.red[800],
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    fontSize: 14.sp,
                    text: 'Don\'n have an account? ',
                    color: Colors.white,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        Routes.registerScreen,
                      );
                    },
                    child: CustomText(
                      text: "Register Now",
                      fontSize: 14.sp,
                      color: Colors.red[800],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
