import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:netflix/constants/Api/http.dart';
import 'package:netflix/constants/models/movie_recommendation_mode.dart';
import 'package:netflix/modules/Register/widget/custom_text.dart';
import '../../../constants/models/search_model.dart';
import '../../../constants/utils/app_assets.dart';
import '../../../constants/utils/const.dart';
import '../../DetailsScreen/screen/MovieDetailScreen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}
class _SearchScreenState extends State<SearchScreen> {
  ApiServices apiServices = ApiServices();
  TextEditingController searchController = TextEditingController();
  SearchModel? searchedMovie;
  late Future<MovieRecommendationsModel> popularMovies;
  Map<String, SearchModel> searchCache = {};
  Timer? _debounce;
  final ScrollController _scrollController = ScrollController();
  bool isLoadingMore = false;
  bool hasInternet = true;

  Future<void> checkInternetConnection() async {
    await Future.delayed(const Duration(seconds: 2));
    final connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      hasInternet = connectivityResult != ConnectivityResult.none;
    });
  }

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) search(query);
    });
  }

  void search(String query) {
    if (searchCache.containsKey(query)) {
      setState(() {
        searchedMovie = searchCache[query];
      });
    } else {
      apiServices.getSearchMovies(query).then((results) {
        setState(() {
          searchedMovie = results;
          searchCache[query] = results;
        });
      });
    }
  }

  void loadMorePopularMovies() {
    if (!isLoadingMore) {
      setState(() {
        isLoadingMore = true;
      });
      apiServices.getPopularMovies().then((newMovies) {
        popularMovies.then((currentMovies) {
          setState(() {
            popularMovies = Future.value(MovieRecommendationsModel(
              page: currentMovies.page + 1,
              totalPages: currentMovies.totalPages,
              totalResults: currentMovies.totalResults,
              results: [...currentMovies.results, ...newMovies.results],
            ));
            isLoadingMore = false;
          });
        });
      });
    }
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
    checkInternetConnection();
    monitorInternetConnection();
    popularMovies = apiServices.getPopularMovies();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMorePopularMovies();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    _debounce?.cancel();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: hasInternet?  SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Padding(
                padding: const EdgeInsets.only(right: 12.0, left: 12.0).r,
                child: CupertinoSearchTextField(
                  controller: searchController,
                  padding: const EdgeInsets.all(12.0).w,
                  prefixIcon: const Icon(
                    CupertinoIcons.search,
                    color: Colors.grey,
                  ),
                  suffixIcon: const Icon(
                    Icons.cancel,
                    color: Colors.grey,
                  ),
                  style: const TextStyle(color: Colors.white),
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  onChanged: onSearchChanged,
                  onSuffixTap: () {
                    setState(() {
                      searchController.clear();
                      searchedMovie = null;
                    });
                  },
                ),
              ),
              searchController.text.isEmpty
                  ? FutureBuilder<MovieRecommendationsModel>(
                future: popularMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data?.results;
                    return Padding(
                      padding: EdgeInsets.only(left: 5.0.r),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 18.h,
                          ),
                          CustomText(
                            text: "Top Searches",
                            color: Colors.white,
                            fontSize: 18.sp,
                            bold: FontWeight.bold,
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0).w,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MovieDetailScreen(
                                              movieId: data[index].id,
                                            ),
                                      ),
                                    );
                                  },
                                  child: SizedBox(
                                    height: 170.h,
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(20),
                                          child: Image.network(
                                            '$imageUrl${data[index].posterPath}',
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 18.w,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                maxLines: 2,
                                                text: data[index].title,
                                                color: Colors.white,
                                                fontSize: 16.sp,
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color:
                                                    Colors.yellow[700],
                                                  ),
                                                  SizedBox(
                                                    width: 8.w,
                                                  ),
                                                  CustomText(
                                                    text: data[index]
                                                        .voteAverage
                                                        .toString(),
                                                    color: Colors.white,
                                                    fontSize: 16.sp,
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    );
                  } else {
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
                  }
                },
              )
                  : searchedMovie == null
                  ? const SizedBox.shrink()
                  : GridView.builder(
                padding: const EdgeInsets.all(8),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: searchedMovie?.results.length,
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 10.w,
                  childAspectRatio: 2.1 / 1.9,
                ),
                itemBuilder: (context, index) {
                  return searchedMovie!.results[index].backdropPath ==
                      null
                      ? Column(
                    children: [
                      Lottie.asset(AppLottieAssets.animation,
                          height: 100.h),
                      CustomText(
                        text:
                        searchedMovie!.results[index].title,
                        fontSize: 14.sp,
                        color: Colors.white,
                      )
                    ],
                  )
                      : Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MovieDetailScreen(
                                      movieId: searchedMovie!
                                          .results[index].id),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 12.0.r),
                          child: ClipRRect(
                            borderRadius:
                            BorderRadius.circular(20),
                            child: Image.network(
                              '$imageUrl${searchedMovie?.results[index].backdropPath}',
                              fit: BoxFit.fitHeight,
                              height: 100.h,
                            ),
                          ),
                        ),
                        // child: CachedNetworkImage(
                        //   imageUrl:
                        //   '$imageUrl${searchedMovie?.results[index].backdropPath}',
                        //   height: 140.h,
                        // ),
                      ),
                      CustomText(
                        text:
                        searchedMovie!.results[index].title,
                        fontSize: 14.sp,
                        color: Colors.white,
                      )
                    ],
                  );
                },
              )
            ],
          ),
        )
            :Column(

          children: [
            Lottie.asset(AppLottieAssets.lost,
                height: 300.h,
                width: 280.w
            ),            CustomText(
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
