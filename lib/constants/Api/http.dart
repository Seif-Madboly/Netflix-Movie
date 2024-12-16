import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:netflix/constants/models/movie_recommendation_mode.dart';
import '../models/movie_detail_model.dart';
import '../models/movie_model.dart';
import '../models/search_model.dart';
import '../models/tob_Rated_Model.dart';
import '../utils/const.dart';


const baseUrl = 'https://api.themoviedb.org/3/';
var key = '?api_key=$apiKey';
late String endPoint;

class ApiServices {
  Future<MovieModel> getUpcomingMovies() async {
    endPoint = 'movie/upcoming';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log('success');
      return MovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load upcoming movies');
  }



  Future<MovieModel> getNowPlayingMovie() async {
    endPoint = "movie/now_playing";
    final url = "$baseUrl$endPoint$key";
    print("----------------------------------------------------");
    if (kDebugMode) {
      print("Base URL: $baseUrl");
    }
    if (kDebugMode) {
      print("End Point: $endPoint");
    }
    print("Key: $key");

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Success");
      return MovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load Playing movies');
  }

  Future<TopRatedModel> getTopRatedMovies() async {
    endPoint = 'movie/top_rated';
    final url = "$baseUrl$endPoint$key";
      print("---------------------------------------------------");
      print("Base URL: $baseUrl");

      print("Now Playing End Point: $endPoint");
      print("Key: $key");

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Success");
      return TopRatedModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load now Top Rated movies');
  }

  Future<MovieRecommendationsModel> getPopularMovies() async {
    endPoint = 'movie/popular';
    final url = "$baseUrl$endPoint$key";

    print("----------------------------------------------------");
    print("Base URL: $baseUrl");
    print("Popular End Point: $endPoint");
    print("Key: $key");
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Success");
      return MovieRecommendationsModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load Popular Movies');
  }

  Future<SearchModel> getSearchMovies(String searchText) async {
    endPoint = "search/movie?query=$searchText";
    final url = "$baseUrl$endPoint";
    print(url);

    final response = await http.get(Uri.parse(url), headers: {
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1YTBiZDQzYmY1NDljN2ZmNjcxMzZhMjFkYTVhOTExOSIsIm5iZiI6MTcxNjY0ODM4Ni43MzcsInN1YiI6IjY2NTFmOWMyN2ZmODgwZThmZDU1YTU4ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Jgi5Q79-IxyHPS4jvDA1a88Qa0iTMWOT5J-r0V3PhKI"
    });
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      log("Search Success");
      return SearchModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load  search movie ');
  }

  Future<MovieRecommendationsModel> getMovieRecommendations(int movieId) async {
    endPoint = "movie/$movieId/recommendations";
    final url = "$baseUrl$endPoint$key";
    print("----------------------------------------------------");
    print("Base URL: $baseUrl");
    print("Recommendations End Point: $endPoint");
    print("Key: $key");

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("Success");
      return MovieRecommendationsModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to Recommendations movie details');
  }

  Future<MovieDetailModel> getMovieDetail(int movieId) async {
    endPoint = "movie/$movieId";
    final url = "$baseUrl$endPoint$key";
    print("----------------------------------------------------");
    print("Base URL: $baseUrl");
    print("Detail End Point: $endPoint");
    print("Key: $key");

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("Success");
      return MovieDetailModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load movie details');
  }
}
