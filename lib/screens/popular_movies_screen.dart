import 'package:flutter/material.dart';
import 'package:m0vieapp/models/popular.dart';
import 'package:m0vieapp/utils/remote_service.dart';
import 'package:skeletons/skeletons.dart';

class PopularMoviesScreen extends StatefulWidget {
  const PopularMoviesScreen({Key? key}) : super(key: key);

  @override
  State<PopularMoviesScreen> createState() => _PopularMoviesScreenState();
}

class _PopularMoviesScreenState extends State<PopularMoviesScreen> {
  bool popularMoviesLoaded = true;
  List<PopularItem>? popularItem;

  @override
  void initState() {
    super.initState();
    getPopularMoviesScreen();
  }

  getPopularMoviesScreen() async {
    popularItem = await RemoteService().getPopularMovies();
    if (popularItem != null) {
      setState(() {
        popularMoviesLoaded = false;
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
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: popularItem!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          popularItem![index].title,
                        ),
                        leading: Image.network(
                          popularItem![index].image,
                        ),
                        dense: false,
                        subtitle: Text(popularItem![index].year),
                        trailing: FittedBox(
                          fit: BoxFit.fill,
                          child: Row(
                            children: [
                              Icon(
                                Icons.star_half,
                                color: Colors.yellow.shade800,
                              ),
                              Text(
                                popularItem![index].imDbRating,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.of(context).pushNamed('/movieInfo',
                                arguments: popularItem![index].id);
                          });
                        },
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
