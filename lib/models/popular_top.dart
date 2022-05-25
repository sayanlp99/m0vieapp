// To parse this JSON data, do
//
//     final popularTop = popularTopFromJson(jsonString);

import 'dart:convert';

PopularTop popularTopFromJson(String str) =>
    PopularTop.fromJson(json.decode(str));

String popularTopToJson(PopularTop data) => json.encode(data.toJson());

class PopularTop {
  PopularTop({
    required this.items,
    required this.errorMessage,
  });

  List<PopularTopItem> items;
  String errorMessage;

  factory PopularTop.fromJson(Map<String, dynamic> json) => PopularTop(
        items: List<PopularTopItem>.from(
            json["items"].map((x) => PopularTopItem.fromJson(x))),
        errorMessage: json["errorMessage"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "errorMessage": errorMessage,
      };
}

class PopularTopItem {
  PopularTopItem({
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

  factory PopularTopItem.fromJson(Map<String, dynamic> json) => PopularTopItem(
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
