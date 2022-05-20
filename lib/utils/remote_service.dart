import 'package:m0vieapp/models/coming_soon.dart';
import 'package:m0vieapp/models/movie_info.dart';

import 'package:http/http.dart' as http;
import 'package:m0vieapp/utils/api_url.dart';

class RemoteService {
  Future<List<MovieInfoItem>?> getTopMovies() async {
    var client = http.Client();
    var response = await client.get(Uri.parse(ApiUrl.getTopMovies()));
    if (response.statusCode == 200) {
      var json = response.body;
      return movieInfoFromJson(json).items;
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
