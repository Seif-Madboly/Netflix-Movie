import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:netflix/constants/Api/http.dart';
import 'package:netflix/modules/Register/widget/custom_text.dart';
import '../../../constants/models/movie_detail_model.dart';
import '../../../constants/models/movie_recommendation_mode.dart';
import '../../../constants/utils/app_assets.dart';
import '../../../constants/utils/const.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailScreen({super.key, required this.movieId});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  ApiServices apiServices = ApiServices();
  bool hasInternet = true;

  late Future<MovieRecommendationsModel> movieRecommendationModel;
  late Future<MovieDetailModel> movieDetail;

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
  void initState() {
    fetchInitialData();
    checkInternetConnection();
    monitorInternetConnection();
    super.initState();
  }

  fetchInitialData() {
    movieDetail = apiServices.getMovieDetail(widget.movieId);
    movieRecommendationModel =
        apiServices.getMovieRecommendations(widget.movieId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(widget.movieId);
    return Scaffold(
      body: hasInternet
          ? FutureBuilder(
              future: movieDetail,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final movie = snapshot.data;
                  String genresText =
                      movie!.genres.map((genre) => genre.name).join(' , ');
                  return CustomScrollView(
                    slivers: [
                      SliverAppBar.large(
                        leading: Container(
                          height: 170.h,
                          width: 170.w,
                          margin: const EdgeInsets.only(top: 16, left: 16).r,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(18).w),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        backgroundColor: Colors.transparent,
                        expandedHeight: 350.h,
                        floating: true,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          // title: CustomText(
                          //  text: movie.title,
                          //   color: Colors.white,
                          // ),
                          background: ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: const Radius.circular(24).w,
                                bottomRight: const Radius.circular(24).w),
                            child: Image.network(
                              "$imageUrl${movie.posterPath}",
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              CustomText(
                                text: movie.title,
                                color: Colors.white,
                                fontSize: 20.sp,
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  CustomText(
                                    text: movie.releaseDate.year.toString(),
                                    color: Colors.grey,
                                    fontSize: 18.sp,
                                  ),
                                  SizedBox(
                                    width: 13.w,
                                  ),
                                  Expanded(
                                    child: CustomText(
                                      maxLines: 2,
                                      text: genresText,
                                      color: Colors.grey,
                                      fontSize: 17.sp,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              CustomText(
                                letterSpacing: .5.w,
                                text: movie.overview,
                                maxLines: 5,
                                color: Colors.white,
                                fontSize: 15.sp,
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              FutureBuilder(
                                future: movieRecommendationModel,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final movie = snapshot.data;
                                    return movie!.results.isEmpty
                                        ? const SizedBox()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                letterSpacing: 0.9.w,
                                                text: "Recommendations",
                                                color: Colors.white,
                                                bold: FontWeight.bold,
                                                fontSize: 18.sp,
                                              ),
                                              SizedBox(height: 10.h),
                                              GridView.builder(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                padding: EdgeInsets.zero,
                                                scrollDirection: Axis.vertical,
                                                itemCount: movie.results.length,
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  crossAxisSpacing: 17,
                                                  mainAxisSpacing: 19,
                                                  childAspectRatio: 1.1 / 1.5,
                                                ),
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              MovieDetailScreen(
                                                                  movieId: movie
                                                                      .results[
                                                                          index]
                                                                      .id),
                                                        ),
                                                      );
                                                    },
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      child: Image.network(
                                                        "$imageUrl${movie.results[index].posterPath}",
                                                        filterQuality:
                                                            FilterQuality.high,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    // CachedNetworkImage(
                                                    //   imageUrl:
                                                    //   "$imageUrl${movie.results[index].posterPath}",
                                                    //
                                                    // ),
                                                  );
                                                },
                                              ),
                                            ],
                                          );
                                  }
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }
                return const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    ),
                  ],
                );

              },
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
    );
  }
}

