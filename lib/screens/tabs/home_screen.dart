import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:m0vieapp/models/coming_soon.dart';
import 'package:m0vieapp/utils/remote_service.dart';
import 'package:m0vieapp/widgets/coming_soon_cards.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ComingSoonItem>? comingSoonItem;
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
                      'Hi,',
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
            Row(children: [
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
              IconButton(
                onPressed: () {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pushNamed('/comingSoon');
                  });
                },
                icon: const Icon(Icons.chevron_right_sharp),
              ),
              const SizedBox(
                width: 16,
              ),
            ]),
            comingSoonLoaded
                ? const CircularProgressIndicator()
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
          ],
        ),
      ),
    );
  }
}
