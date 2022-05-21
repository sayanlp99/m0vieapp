import 'package:flutter/material.dart';
import 'package:m0vieapp/models/coming_soon.dart';
import 'package:m0vieapp/models/movie.dart';

import 'package:http/http.dart' as http;
import 'package:m0vieapp/utils/api_url.dart';

class RemoteService {
  Future<Movie?> getMoviesInfo(id) async {
    var client = http.Client();
    var response = await client.get(Uri.parse(ApiUrl.getMovieInfo(id)));
    // return movieFromJson(response.body);
    if (response.statusCode == 200) {
      var json = response.body;
      debugPrint(json);
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
}
