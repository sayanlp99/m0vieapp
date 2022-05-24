import 'package:flutter/material.dart';
import 'package:m0vieapp/models/movie.dart';
import 'package:m0vieapp/utils/remote_service.dart';
import 'package:skeletons/skeletons.dart';

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
        leading: const CloseButton(
          color: Colors.black,
        ),
        title: loading
            ? const SkeletonLine()
            : Text(
                movie!.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  loading
                      ? SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.width * 0.3,
                          ),
                        )
                      : Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.width * 0.3,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  movie!.image,
                                ),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        loading
                            ? const SkeletonLine()
                            : Text('Directors: ${movie!.directors}'),
                        const Divider(),
                        loading
                            ? const SkeletonLine()
                            : Text('Writers: ${movie!.writers}'),
                        const Divider(),
                        loading
                            ? const SkeletonLine()
                            : Text('Stars: ${movie!.stars}'),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(),
              loading
                  ? const SkeletonLine()
                  : Text(
                      'Plot',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.textScaleFactorOf(context) * 20,
                      ),
                    ),
              loading ? SkeletonParagraph() : Text(movie!.plot),
            ],
          ),
        ),
      ),
    );
  }
}
