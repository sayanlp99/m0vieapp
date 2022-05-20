// To parse this JSON data, do
//
//     final movieInfo = movieInfoFromJson(jsonString);

import 'dart:convert';

MovieInfo movieInfoFromJson(String str) => MovieInfo.fromJson(json.decode(str));

String movieInfoToJson(MovieInfo data) => json.encode(data.toJson());

class MovieInfo {
  MovieInfo({
    required this.items,
    required this.errorMessage,
  });

  List<Item> items;
  String errorMessage;

  factory MovieInfo.fromJson(Map<String, dynamic> json) => MovieInfo(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        errorMessage: json["errorMessage"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "errorMessage": errorMessage,
      };
}

class Item {
  Item({
    required this.id,
    required this.rank,
    required this.title,
    required this.fullTitle,
    required this.year,
    required this.image,
    required this.crew,
    required this.imDbRating,
    required this.imDbRatingCount,
  });

  String id;
  String rank;
  String title;
  String fullTitle;
  String year;
  String image;
  String crew;
  String imDbRating;
  String imDbRatingCount;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        rank: json["rank"],
        title: json["title"],
        fullTitle: json["fullTitle"],
        year: json["year"],
        image: json["image"],
        crew: json["crew"],
        imDbRating: json["imDbRating"],
        imDbRatingCount: json["imDbRatingCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rank": rank,
        "title": title,
        "fullTitle": fullTitle,
        "year": year,
        "image": image,
        "crew": crew,
        "imDbRating": imDbRating,
        "imDbRatingCount": imDbRatingCount,
      };
}
