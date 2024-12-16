import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:netflix/constants/Api/http.dart';
import 'package:netflix/constants/utils/app_assets.dart';
import 'package:netflix/modules/HomeScreen/widget/CustomCarouselSlider.dart';
import 'package:netflix/modules/HomeScreen/widget/UpcomingMovieCard.dart';
import '../../../constants/models/movie_model.dart';
import '../../../constants/models/tob_Rated_Model.dart';
import '../../Register/widget/custom_text.dart';
import '../widget/tobRatedCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  ApiServices apiServices = ApiServices();
  bool hasInternet = true;

  late Future<TopRatedModel> tobRated;
  late Future<MovieModel> upcomingFuture;
  late Future<MovieModel> nowPlaying;

  @override
  void initState() {
    upcomingFuture = apiServices.getUpcomingMovies();
    tobRated = apiServices.getTopRatedMovies();
    nowPlaying = apiServices.getNowPlayingMovie();
    checkInternetConnection();
    monitorInternetConnection();
    super.initState();
  }

  Future<void> checkInternetConnection() async {
    await Future.delayed(const Duration(seconds: 2));
    final connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      hasInternet = connectivityResult != ConnectivityResult.none;
    });
  }

  void monitorInternetConnection() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        hasInternet = result != ConnectivityResult.none;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: CustomText(
          bold: FontWeight.bold,
          letterSpacing: 1.0.w,
          text: "Netflix".toUpperCase(),
          color: Colors.red[900],
          fontSize: 24.sp,
          // fontSize: size.width * 0.06,
        ),
      ),
      body: SingleChildScrollView(
        child: hasInternet
            ? Column(
          children: [
            FutureBuilder<MovieModel>(
                future: nowPlaying,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CustomCarouselSlider(future: snapshot.data!);
                  }
                  return SizedBox(
                    height: 570.h,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            SizedBox(
              height: 190.h,
              child: tobRatedCard(
                future: tobRated,
                headlineText: 'Top Rated',
              ),
            ),
            SizedBox(
              height: 190.h,
              // height: size.height * 0.29,
              child: UpcomingMovieCard(
                future: upcomingFuture,
                headlineText: 'Upcoming Movies',
              ),
            ),
          ],
        )
            : Column(
          children: [
            Lottie.asset(AppLottieAssets.lost,
            height: 300.h,
              width: 280.w
            ),
            CustomText(
              alignment: Alignment.center,
              text: "Check Your Internet",
              fontSize: 20.sp,
              bold: FontWeight.bold,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}


