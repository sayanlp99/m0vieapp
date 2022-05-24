import 'package:m0vieapp/models/coming_soon.dart';
import 'package:m0vieapp/models/movie.dart';

import 'package:http/http.dart' as http;
import 'package:m0vieapp/models/popular_movies.dart';
import 'package:m0vieapp/models/popular_tv.dart';
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

  Future<List<PopularMoviesItem>?> getPopularMovies() async {
    var client = http.Client();
    var response = await client.get(Uri.parse(ApiUrl.getPopularMovies()));
    if (response.statusCode == 200) {
      var json = response.body;
      return popularMoviesFromJson(json).items;
    } else {
      return null;
    }
  }

  Future<List<PopularTvItem>?> getPopularTvs() async {
    var client = http.Client();
    var response = await client.get(Uri.parse(ApiUrl.getPopularTv()));
    if (response.statusCode == 200) {
      var json = response.body;
      return popularTvFromJson(json).items;
    } else {
      return null;
    }
  }
}
