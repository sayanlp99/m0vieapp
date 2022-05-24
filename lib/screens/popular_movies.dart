import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class PopularMovies extends StatefulWidget {
  const PopularMovies({Key? key}) : super(key: key);

  @override
  State<PopularMovies> createState() => _PopularMoviesState();
}

class _PopularMoviesState extends State<PopularMovies> {
  bool popularMoviesLoaded = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text(
          'Popular Movies',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: const EdgeInsets.all(16),
          child: popularMoviesLoaded
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Skeleton(
                    isLoading: popularMoviesLoaded,
                    skeleton: SkeletonListView(),
                    child: SkeletonListView(),
                  ),
                )
              : Container(),
        ),
      ),
    );
  }
}
