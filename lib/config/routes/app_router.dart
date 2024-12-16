import 'package:flutter/material.dart';
 import '../../modules/HomeScreen/screen/home_Screen.dart';
import '../../modules/Register/screen/Register_Screen.dart';
import '../../modules/bottomNavBar.dart';
import '../../modules/OnBoardingScreen/onBoarding_Screen.dart';
import '../../modules/Register/screen/Login_Screen.dart';
import '../../modules/SearchScreen/Screen/search_screen.dart';
import '../../modules/Splash/splash.dart';

class Routes {
  static const String splash = "/splash";
  static const String onBoardingScreen = '/onBoardingScreen';
   static const String loginScreen = "/login_screen";
   static const String registerScreen = "/register_Screen";
   static const String bottomNavBar = "/BottomNavBar";
   static const String homeScreen = "/home_Screen";
   static const String searchScreen = "/searchScreen";
   static const String movieDetailScreen = "/movieDetailScreen";
}

class AppRoutes {
  static MaterialPageRoute? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => const splashScreen(),
        );

      case Routes.onBoardingScreen:
        return MaterialPageRoute(
          builder: (_) => const BoardingScreen(),
        );
        case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => loginScreen(),
        );
        case Routes.registerScreen:
        return MaterialPageRoute(
          builder: (_) => Register_Screen(),
        );

        case Routes.bottomNavBar:
        return MaterialPageRoute(
          builder: (_) => const BottomNavBar(),
        );
        case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
        case Routes.searchScreen:
        return MaterialPageRoute(
          builder: (_) => const SearchScreen(),
        );


    }
    return null;
  }
}
