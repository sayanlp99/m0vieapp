// To parse this JSON data, do
//
//     final popularTv = popularTvFromJson(jsonString);

import 'dart:convert';

PopularTv popularTvFromJson(String str) => PopularTv.fromJson(json.decode(str));

String popularTvToJson(PopularTv data) => json.encode(data.toJson());

class PopularTv {
  PopularTv({
    required this.items,
    required this.errorMessage,
  });

  List<PopularTvItem> items;
  String errorMessage;

  factory PopularTv.fromJson(Map<String, dynamic> json) => PopularTv(
        items: List<PopularTvItem>.from(
            json["items"].map((x) => PopularTvItem.fromJson(x))),
        errorMessage: json["errorMessage"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "errorMessage": errorMessage,
      };
}

class PopularTvItem {
  PopularTvItem({
    required this.id,
    required this.rank,
    required this.rankUpDown,
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
  String rankUpDown;
  String title;
  String fullTitle;
  String year;
  String image;
  String crew;
  String imDbRating;
  String imDbRatingCount;

  factory PopularTvItem.fromJson(Map<String, dynamic> json) => PopularTvItem(
        id: json["id"],
        rank: json["rank"],
        rankUpDown: json["rankUpDown"],
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
        "rankUpDown": rankUpDown,
        "title": title,
        "fullTitle": fullTitle,
        "year": year,
        "image": image,
        "crew": crew,
        "imDbRating": imDbRating,
        "imDbRatingCount": imDbRatingCount,
      };
}
