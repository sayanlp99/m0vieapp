import 'package:m0vieapp/utils/constants.dart';

class ApiUrl {
  static String getTopMovies() {
    return 'https://imdb-api.com/en/API/Top250Movies/$apiKey';
  }

  static String getTopTvs() {
    return 'https://imdb-api.com/en/API/Top250TVs/$apiKey';
  }

  static String getMovieInfo(id) {
    return 'https://imdb-api.com/en/API/Title/$apiKey/$id';
  }

  static String getCommingSoon() {
    return 'https://imdb-api.com/en/API/ComingSoon/$apiKey';
  }

  static String getPopularMovies() {
    return 'https://imdb-api.com/en/API/MostPopularMovies/$apiKey';
  }

  static String getPopularTv() {
    return 'https://imdb-api.com/en/API/MostPopularTVs/$apiKey';
  }
}
