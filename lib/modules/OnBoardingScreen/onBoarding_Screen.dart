// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:netflix/config/routes/app_router.dart';

import '../../constants/utils/app_assets.dart';
import '../../constants/utils/color.dart';
import '../Register/widget/custom_text.dart';

class BoardingModel {
  final String? image;
  final String? body;
  final String? title;

  BoardingModel({required this.image, required this.body, required this.title});
}

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  var boardingController = PageController();
  List<BoardingModel> boarding = [
    BoardingModel(
        image: AppImageAssets.intro_1,
        title: "Watch",
        body:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "),
    BoardingModel(
        image: AppImageAssets.intro_2,
        title: "No Pesky Contracts",
        body:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. sed do eiusmod tempor incididunt ut labore et dolore magna aliqua "),
    BoardingModel(
        image: AppImageAssets.intro_3,
        title: "Watch on any Device",
        body:
            "Lorem ipsum dolor sit amet, consectetur adipiscing lit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua"),
  ];
  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGround,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.loginScreen,
                (route) => false,
              );
              // Get.offAllNamed(Routes.loginScreen);
            },
            child: CustomText(
              text: "SKIP",
              letterSpacing: 1.2.w,
              color: Colors.white,
              fontSize: 16.sp,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0).w,
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardingController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    isLast = true;
                  } else {
                    isLast = false;
                  }
                },
                itemBuilder: (context, index) =>
                    onBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
              SizedBox(height: 30.h),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey.shade600,
                    activeDotColor: Colors.red.shade800,
                    dotHeight: 10.h,
                    dotWidth: 7.w,
                    expansionFactor: 4,
                    spacing: 5.0.w,
                  ),
                  count: boarding.length,
                ),
                const Spacer(),
                FloatingActionButton(
                  backgroundColor: Colors.red[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0).w,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (isLast) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.loginScreen,
                        (route) => false,
                      );
                    } else {
                      boardingController.nextPage(
                        duration: const Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget onBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset("${model.image}"),
          ),
            SizedBox(height: 25.h),
          Center(
            child: CustomText(
              alignment: Alignment.center,
              text:"${model.title}",
                  color: Colors.white,
                  fontSize: 23.sp,
              letterSpacing: 1.2.w,
              bold: FontWeight.bold,
             ),

          ),
          SizedBox(height: 10.h),
          Center(
            child: CustomText(
              text:"${model.body}",
                fontSize: 20.sp,
                color: Colors.white,
              maxLines:9,
            ),
          ),
            SizedBox(height: 15.h),
        ],
      );
}

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );
