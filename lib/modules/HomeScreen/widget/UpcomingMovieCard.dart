import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netflix/constants/models/movie_model.dart';
import 'package:netflix/constants/utils/const.dart';
import '../../DetailsScreen/screen/MovieDetailScreen.dart';
import 'headline_text.dart';

class UpcomingMovieCard extends StatelessWidget {
  final Future<MovieModel> future;
  final String headlineText;
  final Duration transitionDuration;
  final double closedElevation;
  final Color closedColor;

  const UpcomingMovieCard({
    super.key,
    this.transitionDuration = const Duration(milliseconds: 600),
    this.closedElevation = 5,
    this.closedColor = Colors.transparent,
   required this.future,
    required this.headlineText,
  });

  @override

  Widget build(BuildContext context) {
    return FutureBuilder<MovieModel>(
      future: future,
      builder: ( context, snapshot) {
        if(snapshot.hasData){
          var data = snapshot.data?.results;
          return  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeadlineText(text: headlineText),
              Expanded(
                // height: size.height * 0.23, // Assuming a fixed height for the list
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
                               borderRadius: BorderRadius.circular(22).w
                           ),
                           child: CachedNetworkImage(
                             imageUrl: "$imageUrl${data[index].posterPath}",
                             placeholder: (context, url) => const Center(
                               child: CircularProgressIndicator(
                                 color: Colors.red,
                               ),
                             ),
                             errorWidget: (context, url, error) => const Icon(
                               Icons.error,
                               color: Colors.red,
                               size: 40,
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


