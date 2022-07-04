import 'package:flutter/material.dart';
import 'package:m0vieapp/models/coming_soon.dart';
import 'package:m0vieapp/utils/remote_service.dart';
import 'package:skeletons/skeletons.dart';

class ComingSoonMoviesScreen extends StatefulWidget {
  const ComingSoonMoviesScreen({Key? key}) : super(key: key);

  @override
  State<ComingSoonMoviesScreen> createState() => _ComingSoonMoviesScreenState();
}

class _ComingSoonMoviesScreenState extends State<ComingSoonMoviesScreen> {
  List<Item>? comingSoonItem;
  bool comingSoonLoaded = true;

  @override
  void initState() {
    super.initState();
    getComingSoonItems();
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text(
          'Coming Soon',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: const EdgeInsets.all(16),
          child: comingSoonLoaded
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Skeleton(
                    isLoading: comingSoonLoaded,
                    skeleton: SkeletonListView(),
                    child: SkeletonListView(),
                  ),
                )
              : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: comingSoonItem!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          comingSoonItem![index].title,
                        ),
                        leading: Image.network(
                          comingSoonItem![index].image,
                        ),
                        dense: false,
                        isThreeLine: true,
                        subtitle: Text(
                          comingSoonItem![index].releaseState +
                              ',' +
                              comingSoonItem![index].year +
                              '\n' +
                              comingSoonItem![index].stars,
                        ),
                        trailing: const Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Navigator.of(context).pushNamed('/movieInfo',
                                arguments: comingSoonItem![index].id);
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
