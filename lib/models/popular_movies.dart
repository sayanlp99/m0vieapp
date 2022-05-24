// To parse this JSON data, do
//
//     final popular = popularFromJson(jsonString);

import 'dart:convert';

PopularMovies popularFromJson(String str) =>
    PopularMovies.fromJson(json.decode(str));

String popularToJson(PopularMovies data) => json.encode(data.toJson());

class PopularMovies {
  PopularMovies({
    required this.items,
    required this.errorMessage,
  });

  List<PopularMoviesItem> items;
  String errorMessage;

  factory PopularMovies.fromJson(Map<String, dynamic> json) => PopularMovies(
        items: List<PopularMoviesItem>.from(
            json["items"].map((x) => PopularMoviesItem.fromJson(x))),
        errorMessage: json["errorMessage"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "errorMessage": errorMessage,
      };
}

class PopularMoviesItem {
  PopularMoviesItem({
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

  factory PopularMoviesItem.fromJson(Map<String, dynamic> json) =>
      PopularMoviesItem(
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
