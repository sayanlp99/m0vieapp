import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:m0vieapp/models/coming_soon.dart';
import 'package:m0vieapp/models/popular_movies.dart';
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
  List<PopularMoviesItem>? popularItem;
  bool comingSoonLoaded = true;
  bool popularMoviesLoaded = true;

  @override
  void initState() {
    super.initState();
    getComingSoonItems();
    getPopularMovies();
  }

  getPopularMovies() async {
    popularItem = await RemoteService().getPopularMovies();
    if (popularItem != null) {
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
                      itemCount: popularItem!.length,
                      itemBuilder: (context, index) {
                        return PopularCards(
                          title: popularItem![index].title,
                          year: popularItem![index].year,
                          img: popularItem![index].image,
                          crew: popularItem![index].crew,
                          rating: popularItem![index].imDbRating,
                          id: popularItem![index].id,
                        );
                      },
                    ),
                  ),
//
//
//
//
//

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
                      itemCount: popularItem!.length,
                      itemBuilder: (context, index) {
                        return PopularCards(
                          title: popularItem![index].title,
                          year: popularItem![index].year,
                          img: popularItem![index].image,
                          crew: popularItem![index].crew,
                          rating: popularItem![index].imDbRating,
                          id: popularItem![index].id,
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
