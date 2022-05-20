import 'package:m0vieapp/utils/constants.dart';

class ApiUrl {
  static String getTopMovies() {
    return 'https://imdb-api.com/en/API/Top250Movies/$apiKey';
  }
}
