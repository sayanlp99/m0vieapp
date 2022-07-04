import 'dart:convert';

ComingSoonItem comingSoonItemFromJson(String str) =>
    ComingSoonItem.fromJson(json.decode(str));

String comingSoonItemToJson(ComingSoonItem data) => json.encode(data.toJson());

class ComingSoonItem {
  ComingSoonItem({
    required this.items,
    required this.errorMessage,
  });

  List<Item> items;
  String errorMessage;

  factory ComingSoonItem.fromJson(Map<String, dynamic> json) => ComingSoonItem(
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        errorMessage:
            json["errorMessage"] == null ? null : json["errorMessage"],
      );

  Map<String, dynamic> toJson() => {
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x.toJson())),
        "errorMessage": errorMessage == null ? null : errorMessage,
      };
}

class Item {
  Item({
    required this.id,
    required this.title,
    required this.fullTitle,
    required this.year,
    required this.releaseState,
    required this.image,
    this.runtimeMins,
    this.runtimeStr,
    this.plot,
    this.contentRating,
    this.imDbRating,
    this.imDbRatingCount,
    this.metacriticRating,
    this.genres,
    required this.genreList,
    this.directors,
    required this.directorList,
    this.stars,
    required this.starList,
  });

  String id;
  String title;
  String fullTitle;
  String year;
  String releaseState;
  String image;
  dynamic runtimeMins;
  dynamic runtimeStr;
  dynamic plot;
  dynamic contentRating;
  dynamic imDbRating;
  dynamic imDbRatingCount;
  dynamic metacriticRating;
  dynamic genres;
  List<dynamic> genreList;
  dynamic directors;
  List<dynamic> directorList;
  dynamic stars;
  List<dynamic> starList;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        fullTitle: json["fullTitle"] == null ? null : json["fullTitle"],
        year: json["year"] == null ? null : json["year"],
        releaseState:
            json["releaseState"] == null ? null : json["releaseState"],
        image: json["image"] == null ? null : json["image"],
        runtimeMins: json["runtimeMins"],
        runtimeStr: json["runtimeStr"],
        plot: json["plot"],
        contentRating: json["contentRating"],
        imDbRating: json["imDbRating"],
        imDbRatingCount: json["imDbRatingCount"],
        metacriticRating: json["metacriticRating"],
        genres: json["genres"],
        genreList: json["genreList"] == null
            ? []
            : List<dynamic>.from(json["genreList"].map((x) => x)),
        directors: json["directors"],
        directorList: json["directorList"] == null
            ? []
            : List<dynamic>.from(json["directorList"].map((x) => x)),
        stars: json["stars"] == null ? " " : json["stars"],
        starList: json["starList"] == null
            ? []
            : List<dynamic>.from(json["starList"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "fullTitle": fullTitle == null ? null : fullTitle,
        "year": year == null ? null : year,
        "releaseState": releaseState == null ? null : releaseState,
        "image": image == null ? null : image,
        "runtimeMins": runtimeMins,
        "runtimeStr": runtimeStr,
        "plot": plot,
        "contentRating": contentRating,
        "imDbRating": imDbRating,
        "imDbRatingCount": imDbRatingCount,
        "metacriticRating": metacriticRating,
        "genres": genres,
        "genreList": genreList == null
            ? null
            : List<dynamic>.from(genreList.map((x) => x)),
        "directors": directors,
        "directorList": directorList == null
            ? null
            : List<dynamic>.from(directorList.map((x) => x)),
        "stars": stars,
        "starList": starList == null
            ? null
            : List<dynamic>.from(starList.map((x) => x)),
      };
}
