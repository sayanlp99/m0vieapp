import 'dart:convert';

ComingSoon comingSoonFromJson(String str) =>
    ComingSoon.fromJson(json.decode(str));

String comingSoonToJson(ComingSoon data) => json.encode(data.toJson());

class ComingSoon {
  ComingSoon({
    required this.items,
    required this.errorMessage,
  });

  List<ComingSoonItem> items;
  String errorMessage;

  factory ComingSoon.fromJson(Map<String, dynamic> json) => ComingSoon(
        items: List<ComingSoonItem>.from(
            json["items"].map((x) => ComingSoonItem.fromJson(x))),
        errorMessage: json["errorMessage"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "errorMessage": errorMessage,
      };
}

class ComingSoonItem {
  ComingSoonItem({
    required this.id,
    required this.title,
    required this.fullTitle,
    required this.year,
    required this.releaseState,
    required this.image,
    required this.runtimeMins,
    required this.runtimeStr,
    required this.plot,
    required this.contentRating,
    required this.imDbRating,
    required this.imDbRatingCount,
    required this.metacriticRating,
    required this.genres,
    required this.genreList,
    required this.directors,
    required this.directorList,
    required this.stars,
    required this.starList,
  });

  String id;
  String title;
  String fullTitle;
  String year;
  String releaseState;
  String image;
  String runtimeMins;
  String runtimeStr;
  String plot;
  String contentRating;
  String imDbRating;
  String imDbRatingCount;
  String metacriticRating;
  String genres;
  List<GenreList> genreList;
  String directors;
  List<RList> directorList;
  String stars;
  List<RList> starList;

  factory ComingSoonItem.fromJson(Map<String, dynamic> json) => ComingSoonItem(
        id: json["id"],
        title: json["title"],
        fullTitle: json["fullTitle"],
        year: json["year"],
        releaseState: json["releaseState"],
        image: json["image"],
        runtimeMins: json["runtimeMins"],
        runtimeStr: json["runtimeStr"],
        plot: json["plot"],
        contentRating: json["contentRating"],
        imDbRating: json["imDbRating"],
        imDbRatingCount: json["imDbRatingCount"],
        metacriticRating: json["metacriticRating"],
        genres: json["genres"],
        genreList: List<GenreList>.from(
            json["genreList"].map((x) => GenreList.fromJson(x))),
        directors: json["directors"],
        directorList: List<RList>.from(
            json["directorList"].map((x) => RList.fromJson(x))),
        stars: json["stars"],
        starList:
            List<RList>.from(json["starList"].map((x) => RList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "fullTitle": fullTitle,
        "year": year,
        "releaseState": releaseState,
        "image": image,
        "runtimeMins": runtimeMins,
        "runtimeStr": runtimeStr,
        "plot": plot,
        "contentRating": contentRating,
        "imDbRating": imDbRating,
        "imDbRatingCount": imDbRatingCount,
        "metacriticRating": metacriticRating,
        "genres": genres,
        "genreList": List<dynamic>.from(genreList.map((x) => x.toJson())),
        "directors": directors,
        "directorList": List<dynamic>.from(directorList.map((x) => x.toJson())),
        "stars": stars,
        "starList": List<dynamic>.from(starList.map((x) => x.toJson())),
      };
}

class RList {
  RList({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory RList.fromJson(Map<String, dynamic> json) => RList(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class GenreList {
  GenreList({
    required this.key,
    required this.value,
  });

  String key;
  String value;

  factory GenreList.fromJson(Map<String, dynamic> json) => GenreList(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };
}
