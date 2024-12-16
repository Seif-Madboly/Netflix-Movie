import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/routes/app_router.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs= await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
  runApp( MyApp(isLoggedIn : isLoggedIn));
}

Color myColor = const Color(0xFF252525);

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isLoggedIn});

  final bool isLoggedIn;


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          theme: ThemeData(scaffoldBackgroundColor: myColor),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRoutes.generateRoute,
          initialRoute: isLoggedIn?Routes.bottomNavBar: Routes.splash
        );
      },
    );
  }
}
