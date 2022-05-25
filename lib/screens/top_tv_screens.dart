import 'package:flutter/material.dart';
import 'package:m0vieapp/models/popular_top.dart';
import 'package:m0vieapp/utils/remote_service.dart';
import 'package:skeletons/skeletons.dart';

class TopTvsScreen extends StatefulWidget {
  const TopTvsScreen({Key? key}) : super(key: key);

  @override
  State<TopTvsScreen> createState() => _TopTvsScreenState();
}

class _TopTvsScreenState extends State<TopTvsScreen> {
  bool topTvsLoaded = true;
  List<PopularTopItem>? topTvItem;

  @override
  void initState() {
    super.initState();
    getTopMoviesScreen();
  }

  getTopMoviesScreen() async {
    topTvItem = await RemoteService().getTopTvs();
    if (topTvItem != null) {
      setState(() {
        topTvsLoaded = false;
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
          'Top Tv Shows',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: const EdgeInsets.all(16),
          child: topTvsLoaded
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Skeleton(
                    isLoading: topTvsLoaded,
                    skeleton: SkeletonListView(),
                    child: SkeletonListView(),
                  ),
                )
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: topTvItem!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          topTvItem![index].title,
                        ),
                        leading: Image.network(
                          topTvItem![index].image,
                        ),
                        dense: false,
                        subtitle: Text(topTvItem![index].year),
                        trailing: FittedBox(
                          fit: BoxFit.fill,
                          child: Row(
                            children: [
                              Icon(
                                Icons.star_half,
                                color: Colors.yellow.shade800,
                              ),
                              Text(
                                topTvItem![index].imDbRating,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.of(context).pushNamed('/movieInfo',
                                arguments: topTvItem![index].id);
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
