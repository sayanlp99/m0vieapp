import 'package:flutter/material.dart';
import 'package:m0vieapp/models/movie.dart';
import 'package:m0vieapp/utils/remote_service.dart';

class MovieInfo extends StatefulWidget {
  final String id;
  const MovieInfo({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<MovieInfo> createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  Movie? movie;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getMovieInfo();
  }

  getMovieInfo() async {
    movie = await RemoteService().getMoviesInfo(widget.id);
    if (movie != null) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: loading
            ? const CircularProgressIndicator()
            : Text(
                movie!.title,
                style: const TextStyle(color: Colors.black),
              ),
      ),
    );
  }
}
