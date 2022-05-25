import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:m0vieapp/models/coming_soon.dart';
import 'package:m0vieapp/models/popular_top.dart';
import 'package:m0vieapp/utils/remote_service.dart';
import 'package:m0vieapp/widgets/coming_soon_cards.dart';
import 'package:m0vieapp/widgets/popular_cards.dart';
import 'package:skeletons/skeletons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ComingSoonItem>? comingSoonItem;
  List<PopularTopItem>? popularMoviesItem;
  List<PopularTopItem>? popularTvItem;
  List<PopularTopItem>? topMoviesItem;
  List<PopularTopItem>? topTvItem;
  bool comingSoonLoaded = true;
  bool popularMoviesLoaded = true;
  bool popularTvsLoaded = true;
  bool topMoviesLoaded = true;
  bool topTvsLoaded = true;

  @override
  void initState() {
    super.initState();
    getComingSoonItems();
    getPopularMovies();
    getPopularTvs();
    getTopMovies();
    getTopTvs();
  }

  getTopTvs() async {
    topTvItem = await RemoteService().getTopTvs();
    if (topTvItem != null) {
      setState(() {
        topTvsLoaded = false;
      });
    }
  }

  getTopMovies() async {
    topMoviesItem = await RemoteService().getTopMovies();
    if (topMoviesItem != null) {
      setState(() {
        topMoviesLoaded = false;
      });
    }
  }

  getPopularTvs() async {
    popularTvItem = await RemoteService().getPopularTvs();
    if (popularTvItem != null) {
      setState(() {
        popularTvsLoaded = false;
      });
    }
  }

  getPopularMovies() async {
    popularMoviesItem = await RemoteService().getPopularMovies();
    if (popularMoviesItem != null) {
      setState(() {
        popularMoviesLoaded = false;
      });
    }
  }

  getComingSoonItems() async {
    comingSoonItem = await RemoteService().getComingSoon();
    if (comingSoonItem != null) {
      setState(() {
        comingSoonLoaded = false;
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, ${FirebaseAuth.instance.currentUser?.displayName!.split(' ')[0]}',
                      style: TextStyle(
                        fontSize: MediaQuery.textScaleFactorOf(context) * 35,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(
                    FirebaseAuth.instance.currentUser!.photoURL.toString(),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                Text(
                  'Coming Soon',
                  style: TextStyle(
                    fontSize: MediaQuery.textScaleFactorOf(context) * 20,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).pushNamed('/comingSoon');
                    });
                  },
                  child: const Text('View all'),
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
            comingSoonLoaded
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 200,
                            padding: const EdgeInsets.only(left: 16),
                          ),
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 200,
                            padding: const EdgeInsets.only(left: 16),
                          ),
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 200,
                            padding: const EdgeInsets.only(left: 16),
                          ),
                        )
                      ],
                    ),
                  )
                : SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: comingSoonItem!.length,
                      itemBuilder: (context, index) {
                        return ComingSoonCards(
                          title: comingSoonItem![index].title,
                          img: comingSoonItem![index].image,
                          releaseDate: comingSoonItem![index].releaseState +
                              ',' +
                              comingSoonItem![index].year,
                          stars: comingSoonItem![index].stars,
                          id: comingSoonItem![index].id,
                        );
                      },
                    ),
                  ),
            const Divider(),
            Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                Text(
                  'Popular Movies',
                  style: TextStyle(
                    fontSize: MediaQuery.textScaleFactorOf(context) * 20,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).pushNamed('/popularMovies');
                    });
                  },
                  child: const Text('View all'),
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
            popularMoviesLoaded
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 210,
                            padding: const EdgeInsets.only(left: 7),
                          ),
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 210,
                            padding: const EdgeInsets.only(left: 7),
                          ),
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 210,
                            padding: const EdgeInsets.only(left: 7),
                          ),
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 210,
                            padding: const EdgeInsets.only(left: 7),
                          ),
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 210,
                            padding: const EdgeInsets.only(left: 7),
                          ),
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 210,
                            padding: const EdgeInsets.only(left: 7),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    height: 210,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: popularMoviesItem!.length,
                      itemBuilder: (context, index) {
                        return PopularCards(
                          title: popularMoviesItem![index].title,
                          year: popularMoviesItem![index].year,
                          img: popularMoviesItem![index].image,
                          crew: popularMoviesItem![index].crew,
                          rating: popularMoviesItem![index].imDbRating,
                          id: popularMoviesItem![index].id,
                        );
                      },
                    ),
                  ),
            const Divider(),
            Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                Text(
                  'Popular TV Shows',
                  style: TextStyle(
                    fontSize: MediaQuery.textScaleFactorOf(context) * 20,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).pushNamed('/popularTvs');
                    });
                  },
                  child: const Text('View all'),
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
            popularTvsLoaded
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 210,
                            padding: const EdgeInsets.only(left: 7),
                          ),
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 210,
                            padding: const EdgeInsets.only(left: 7),
                          ),
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 210,
                            padding: const EdgeInsets.only(left: 7),
                          ),
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 210,
                            padding: const EdgeInsets.only(left: 7),
                          ),
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 210,
                            padding: const EdgeInsets.only(left: 7),
                          ),
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 210,
                            padding: const EdgeInsets.only(left: 7),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    height: 210,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: popularTvItem!.length,
                      itemBuilder: (context, index) {
                        return PopularCards(
                          title: popularTvItem![index].title,
                          year: popularTvItem![index].year,
                          img: popularTvItem![index].image,
                          crew: popularTvItem![index].crew,
                          rating: popularTvItem![index].imDbRating,
                          id: popularTvItem![index].id,
                        );
                      },
                    ),
                  ),
            const Divider(),
            Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                Text(
                  'Top Movies',
                  style: TextStyle(
                    fontSize: MediaQuery.textScaleFactorOf(context) * 20,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).pushNamed('/topMovies');
                    });
                  },
                  child: const Text('View all'),
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
            topMoviesLoaded
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 210,
                            padding: const EdgeInsets.only(left: 7),
                          ),
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 210,
                            padding: const EdgeInsets.only(left: 7),
                          ),
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 210,
                            padding: const EdgeInsets.only(left: 7),
                          ),
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 210,
                            padding: const EdgeInsets.only(left: 7),
                          ),
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 210,
                            padding: const EdgeInsets.only(left: 7),
                          ),
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 210,
                            padding: const EdgeInsets.only(left: 7),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    height: 210,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: topMoviesItem!.length,
                      itemBuilder: (context, index) {
                        return PopularCards(
                          title: topMoviesItem![index].title,
                          year: topMoviesItem![index].year,
                          img: topMoviesItem![index].image,
                          crew: topMoviesItem![index].crew,
                          rating: topMoviesItem![index].imDbRating,
                          id: topMoviesItem![index].id,
                        );
                      },
                    ),
                  ),
            const Divider(),
            Row(
              children: [
                const SizedBox(
                  width: 16,
                ),
                Text(
                  'Top TV Shows',
                  style: TextStyle(
                    fontSize: MediaQuery.textScaleFactorOf(context) * 20,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).pushNamed('/topTvs');
                    });
                  },
                  child: const Text('View all'),
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
            topTvsLoaded
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 210,
                            padding: const EdgeInsets.only(left: 7),
                          ),
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 210,
                            padding: const EdgeInsets.only(left: 7),
                          ),
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 210,
                            padding: const EdgeInsets.only(left: 7),
                          ),
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 210,
                            padding: const EdgeInsets.only(left: 7),
                          ),
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 210,
                            padding: const EdgeInsets.only(left: 7),
                          ),
                        ),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 210,
                            padding: const EdgeInsets.only(left: 7),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    height: 210,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: topTvItem!.length,
                      itemBuilder: (context, index) {
                        return PopularCards(
                          title: topTvItem![index].title,
                          year: topTvItem![index].year,
                          img: topTvItem![index].image,
                          crew: topTvItem![index].crew,
                          rating: topTvItem![index].imDbRating,
                          id: topTvItem![index].id,
                        );
                      },
                    ),
                  ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
