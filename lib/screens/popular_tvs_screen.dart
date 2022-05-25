import 'package:flutter/material.dart';
import 'package:m0vieapp/models/popular_top.dart';
import 'package:m0vieapp/utils/remote_service.dart';
import 'package:skeletons/skeletons.dart';

class PopularTvsScreen extends StatefulWidget {
  const PopularTvsScreen({Key? key}) : super(key: key);

  @override
  State<PopularTvsScreen> createState() => _PopularTvsScreenState();
}

class _PopularTvsScreenState extends State<PopularTvsScreen> {
  bool popularTvsLoaded = true;
  List<PopularTopItem>? popularTvItem;

  @override
  void initState() {
    super.initState();
    getPopularMoviesScreen();
  }

  getPopularMoviesScreen() async {
    popularTvItem = await RemoteService().getPopularTvs();
    if (popularTvItem != null) {
      setState(() {
        popularTvsLoaded = false;
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
          'Popular Tv Shows',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: const EdgeInsets.all(16),
          child: popularTvsLoaded
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Skeleton(
                    isLoading: popularTvsLoaded,
                    skeleton: SkeletonListView(),
                    child: SkeletonListView(),
                  ),
                )
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: popularTvItem!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          popularTvItem![index].title,
                        ),
                        leading: Image.network(
                          popularTvItem![index].image,
                        ),
                        dense: false,
                        subtitle: Text(popularTvItem![index].year),
                        trailing: FittedBox(
                          fit: BoxFit.fill,
                          child: Row(
                            children: [
                              Icon(
                                Icons.star_half,
                                color: Colors.yellow.shade800,
                              ),
                              Text(
                                popularTvItem![index].imDbRating,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.of(context).pushNamed('/movieInfo',
                                arguments: popularTvItem![index].id);
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
