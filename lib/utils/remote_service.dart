import 'package:m0vieapp/models/coming_soon.dart';
import 'package:m0vieapp/models/movie.dart';

import 'package:http/http.dart' as http;
import 'package:m0vieapp/models/popular_top.dart';
import 'package:m0vieapp/utils/api_url.dart';

class RemoteService {
  Future<Movie?> getMoviesInfo(id) async {
    var client = http.Client();
    var response = await client.get(Uri.parse(ApiUrl.getMovieInfo(id)));
    if (response.statusCode == 200) {
      var json = response.body;
      return movieFromJson(json);
    } else {
      return null;
    }
  }

  Future<List<ComingSoonItem>?> getComingSoon() async {
    var client = http.Client();
    var response = await client.get(Uri.parse(ApiUrl.getCommingSoon()));
    if (response.statusCode == 200) {
      var json = response.body;
      return comingSoonFromJson(json).items;
    } else {
      return null;
    }
  }

  Future<List<PopularTopItem>?> getPopularMovies() async {
    var client = http.Client();
    var response = await client.get(Uri.parse(ApiUrl.getPopularMovies()));
    if (response.statusCode == 200) {
      var json = response.body;
      return popularTopFromJson(json).items;
    } else {
      return null;
    }
  }

  Future<List<PopularTopItem>?> getPopularTvs() async {
    var client = http.Client();
    var response = await client.get(Uri.parse(ApiUrl.getPopularTv()));
    if (response.statusCode == 200) {
      var json = response.body;
      return popularTopFromJson(json).items;
    } else {
      return null;
    }
  }

  Future<List<PopularTopItem>?> getTopMovies() async {
    var client = http.Client();
    var response = await client.get(Uri.parse(ApiUrl.getTopMovies()));
    if (response.statusCode == 200) {
      var json = response.body;
      return popularTopFromJson(json).items;
    } else {
      return null;
    }
  }

  Future<List<PopularTopItem>?> getTopTvs() async {
    var client = http.Client();
    var response = await client.get(Uri.parse(ApiUrl.getTopTvs()));
    if (response.statusCode == 200) {
      var json = response.body;
      return popularTopFromJson(json).items;
    } else {
      return null;
    }
  }
}
