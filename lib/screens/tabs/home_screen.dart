import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m0vieapp/models/coming_soon.dart';
import 'package:m0vieapp/models/popular_top.dart';
import 'package:m0vieapp/utils/remote_service.dart';
import 'package:m0vieapp/widgets/coming_soon_cards.dart';
import 'package:m0vieapp/widgets/popular_cards.dart';
import 'package:skeletons/skeletons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final profilePicRef = FirebaseFirestore.instance.collection('movie');

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Item>? comingSoonItem;
  List<PopularTopItem>? popularMoviesItem;
  List<PopularTopItem>? popularTvItem;
  List<PopularTopItem>? topMoviesItem;
  List<PopularTopItem>? topTvItem;
  bool comingSoonLoaded = true;
  bool popularMoviesLoaded = true;
  bool popularTvsLoaded = true;
  bool topMoviesLoaded = true;
  bool topTvsLoaded = true;
  File? _pickedImage;
  Uint8List webImage = Uint8List(8);
  UploadTask? task;
  bool loadFirebaseStoragePic = false;
  String? firebaseProfilePic;

  @override
  void initState() {
    super.initState();
    getCustomProfilePic();
    getComingSoonItems();
    getPopularMovies();
    getPopularTvs();
    getTopMovies();
    getTopTvs();
  }

  getCustomProfilePic() async {
    var storageFile = FirebaseStorage.instance
        .ref('profile_pic/${FirebaseAuth.instance.currentUser?.uid}.jpg');
    storageFile.getDownloadURL().then((value) {
      debugPrint(value.toString());
      if (value.isNotEmpty) {
        setState(() {
          loadFirebaseStoragePic = true;
          firebaseProfilePic = value.toString();
        });
      } else {
        loadFirebaseStoragePic = false;
      }
    });
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

  Future<String> uploadFile() async {
    if (!kIsWeb) {
      if (_pickedImage == null) return "Empty";
      final destination =
          'profile_pic/${FirebaseAuth.instance.currentUser?.uid}.jpg';
      task = uploadImg(destination, _pickedImage!);
      if (task == null) return "Empty";
      final snapshot = await task!.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      debugPrint('Download-Link: $urlDownload');
      EasyLoading.dismiss();
      Navigator.pop(context);
      return urlDownload;
    } else {
      if (webImage == null) return "Empty";
      final destination =
          'profile_pic/${FirebaseAuth.instance.currentUser?.uid}.jpg';
      task = uploadWebImg(destination, webImage);
      if (task == null) return "Empty";
      final snapshot = await task!.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      debugPrint('Download-Link: $urlDownload');
      EasyLoading.dismiss();
      Navigator.pop(context);
      return urlDownload;
    }
  }

  uploadWebImg(String destination, Uint8List webImage) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(webImage);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  uploadImg(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  Future<void> _getPic(ImageSource imgSrc) async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: imgSrc);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _pickedImage = selected;
        });
        uploadFile();
      } else {
        debugPrint("No Image has been picked");
        EasyLoading.dismiss();
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No Image has been picked'),
          ),
        );
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: imgSrc);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          _pickedImage = File('a');
        });
      } else {
        debugPrint("No Image has been picked");
        EasyLoading.dismiss();
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No Image has been picked'),
          ),
        );
      }
      uploadFile();
    } else {
      debugPrint("Wrong");
    }
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
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext buildContext) {
                          return SimpleDialog(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: GestureDetector(
                                  onTap: () {
                                    EasyLoading.show(
                                      status: '',
                                      dismissOnTap: false,
                                    );
                                    _getPic(ImageSource.camera);
                                  },
                                  child: Row(
                                    children: const [
                                      Spacer(),
                                      Icon(Icons.camera_alt_outlined),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Camera"),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: GestureDetector(
                                  onTap: () {
                                    EasyLoading.show(
                                      status: '',
                                      dismissOnTap: false,
                                    );
                                    _getPic(ImageSource.gallery);
                                  },
                                  child: Row(
                                    children: const [
                                      Spacer(),
                                      Icon(Icons.photo_album_outlined),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Gallery"),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(300.0),
                    child: _pickedImage == null
                        ? loadFirebaseStoragePic == false
                            ? CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                  FirebaseAuth.instance.currentUser!.photoURL
                                      .toString(),
                                ),
                              )
                            : CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                  firebaseProfilePic!,
                                ),
                              )
                        : kIsWeb
                            ? Image.memory(
                                webImage,
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                _pickedImage!,
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
            // _pickedImage == null
            //     ? Container()
            //     : kIsWeb
            //         ? Image.memory(webImage, fit: BoxFit.fill)
            //         : Image.file(
            //             _pickedImage!,
            //             fit: BoxFit.fill,
            //           ),
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
