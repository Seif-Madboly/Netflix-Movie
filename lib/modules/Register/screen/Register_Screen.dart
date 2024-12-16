import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/routes/app_router.dart';
import '../widget/Custom_TextFormField.dart';
import '../widget/Reusable_Background.dart';
import '../widget/custom_Button.dart';
import '../widget/custom_text.dart';
import '../widget/login_password_widget.dart';

class Register_Screen extends StatefulWidget {
  Register_Screen({super.key});

  @override
  State<Register_Screen> createState() => _Register_ScreenState();
}

class _Register_ScreenState extends State<Register_Screen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  TextEditingController fullNameController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void registerUser() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("isLoggedIn", true);
      await prefs.setString('fullName', fullNameController.text.trim());

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration Successful')));
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.bottomNavBar,
        (route) => false,
      );
    } catch (e) {
      if (e is FirebaseAuthException) {
        final errorMessage = e.message ?? "An Unknown error occurred";
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            errorMessage,
            style: TextStyle(fontSize: 15.sp),
          ),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Register',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0.w,
          ),
        ),
      ),
      body: ReusableBackground(
          child: Form(
        key: formKey,
        child: Column(
          children: [
            CustomTextField(
              controller: fullNameController,
              labelText: 'Full Name',
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Your Name';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              type: TextInputType.name,
            ),
            SizedBox(
              height: 8.h,
            ),
            CustomTextField(
              controller: emailController,
              labelText: 'Email Address',
              validator: (value) {
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
              height: 15.h,
            ),
            CustomButton(
              text: "Sign up",
              fontSize: 16.sp,
              onPress: () {
                if (formKey.currentState!.validate()) {
                  registerUser();
                }
              },
              backgroundColor: Colors.red[800],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: 'Already have an account? ',
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      Routes.loginScreen,
                    );
                  },
                  child: CustomText(
                    text: "Login Now",
                    color: Colors.red[800],
                    fontSize: 14.sp,
                  ),
                )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
