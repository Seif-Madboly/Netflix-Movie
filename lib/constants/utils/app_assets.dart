const String imagePath = "assets/images";
const String lottiePath = 'assets/lottie';

class AppImageAssets {
  const AppImageAssets._();

  static const AppImageAssets _instance = AppImageAssets._();

  factory AppImageAssets() => _instance;

  // static const String splash = '$imagePath/netflix.png';
  static const String logo = '$imagePath/Netflix_Logo.png';
  static const String backGround = '$imagePath/background.png';
  static const String intro_1 = '$imagePath/intro_1.png';
  static const String intro_2 = '$imagePath/intro_2.png';
  static const String intro_3 = '$imagePath/intro_3.png';
  static const String facebook = '$imagePath/facebook-logo.png';
  static const String google = '$imagePath/google.png';
  static const String splash = '$imagePath/netflix.json';
}

class AppLottieAssets {
  const AppLottieAssets._();

  static const AppLottieAssets _instance = AppLottieAssets._();

  factory AppLottieAssets() => _instance;

  static const String waiting = '$lottiePath/waiting.json';
  static const String internet_lost = '$lottiePath/internet_lost.json';
  static const String animation = '$lottiePath/Animation.json';
  static const String lost = '$lottiePath/lost.json';
}
