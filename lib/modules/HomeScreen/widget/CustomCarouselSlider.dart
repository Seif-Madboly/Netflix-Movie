
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflix/constants/models/movie_model.dart';
import 'package:netflix/constants/utils/const.dart';

import 'LandingCard.dart';

class CustomCarouselSlider extends StatelessWidget {
  final MovieModel future;

  const CustomCarouselSlider({
    super.key, required this.future,
  });

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    var carouselOptions = CarouselOptions(
      height:  size.height * 1.9,
      aspectRatio: 16 / 9,
      viewportFraction: 0.7,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 5),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      scrollDirection: Axis.horizontal,

    );
         return Padding(
           padding: const EdgeInsets.only(top: 13.0),
           child: SizedBox(
             width: size.width,
             height:  size.height * 0.4,
             child: CarouselSlider.builder(
               itemCount: future.results.length,
               itemBuilder: (BuildContext context, int index, int realIndex) {
                 // var swipModel = data.results[index];
                 var url = future.results[index].backdropPath.toString();
                 return GestureDetector(
                   onTap: () {},
                   child: LandingCard(
                     image: CachedNetworkImageProvider("$imageUrl$url"),
                     name: future.results[index].title.toString(),

                     // name: data.results[index].name.toString(),
                   ),
                 );
               },
               options: carouselOptions,
             ),
           ),
         );

  }
}
