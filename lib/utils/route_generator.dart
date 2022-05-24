import 'package:flutter/material.dart';
import 'package:m0vieapp/screens/coming_soon_movies_screen.dart';
import 'package:m0vieapp/screens/login_screen.dart';
import 'package:m0vieapp/screens/movie_info_screen.dart';
import 'package:m0vieapp/screens/popular_tvs_screen.dart';
import 'package:m0vieapp/screens/tab_activity.dart';
import 'package:m0vieapp/screens/popular_movies_screen.dart';
import 'package:m0vieapp/utils/check_user_logged_in.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const CheckUserLoggedIn(),
        );
      case '/login':
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case '/dashboard':
        return MaterialPageRoute(
          builder: (_) => const TabActivity(),
        );
      case '/comingSoon':
        return MaterialPageRoute(
          builder: (_) => const ComingSoonMoviesScreen(),
        );
      case '/popularMovies':
        return MaterialPageRoute(
          builder: (_) => const PopularMoviesScreen(),
        );
      case '/popularTvs':
        return MaterialPageRoute(
          builder: (_) => const PopularTvsScreen(),
        );
      case '/movieInfo':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => MovieInfoScreen(
              id: args,
            ),
          );
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
