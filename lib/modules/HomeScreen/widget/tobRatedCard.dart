

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netflix/modules/DetailsScreen/screen/MovieDetailScreen.dart';
import 'package:netflix/modules/HomeScreen/widget/headline_text.dart';

import '../../../constants/models/tob_Rated_Model.dart';
import '../../../constants/utils/const.dart';



class tobRatedCard extends StatelessWidget {
  final Future<TopRatedModel> future;
  final String headlineText;
  final Duration transitionDuration;
  final double closedElevation;
  final Color closedColor;

  const tobRatedCard({
    super.key,
    this.transitionDuration = const Duration(milliseconds: 600),
    this.closedElevation = 5,
    this.closedColor = Colors.transparent,
    required this.future,
    required this.headlineText,
  });

  @override

  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<TopRatedModel>(
      future: future,
      builder: ( context, snapshot) {
        if(snapshot.hasData){
          var data = snapshot.data?.results;
          return  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeadlineText(text: headlineText),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0).w,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailScreen(
                                movieId: data[index].id,
                              ),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(22).w,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22).w),
                            child: CachedNetworkImage(
                              imageUrl: "$imageUrl${data[index].posterPath}",
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.red,
                                ),
                              ),
                              errorWidget: (context, url, error) =>  Icon(
                                Icons.error,
                                color: Colors.red,
                                size: 40.w,
                              ),
                              fit: BoxFit.cover, // Ensure the image fits properly
                              height: 200.h, // Set height
                            ),

                          ),
                        ),

                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }else {
          return const SizedBox.shrink();
        }
      },

    );
  }
}
