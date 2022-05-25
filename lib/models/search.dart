// To parse this JSON data, do
//
//     final search = searchFromJson(jsonString);

import 'dart:convert';

Search searchFromJson(String str) => Search.fromJson(json.decode(str));

String searchToJson(Search data) => json.encode(data.toJson());

class Search {
  Search({
    required this.searchType,
    required this.expression,
    required this.results,
    required this.errorMessage,
  });

  String searchType;
  String expression;
  List<SearchResult> results;
  String errorMessage;

  factory Search.fromJson(Map<String, dynamic> json) => Search(
        searchType: json["searchType"],
        expression: json["expression"],
        results: List<SearchResult>.from(
            json["results"].map((x) => SearchResult.fromJson(x))),
        errorMessage: json["errorMessage"],
      );

  Map<String, dynamic> toJson() => {
        "searchType": searchType,
        "expression": expression,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "errorMessage": errorMessage,
      };
}

class SearchResult {
  SearchResult({
    required this.id,
    required this.resultType,
    required this.image,
    required this.title,
    required this.description,
  });

  String id;
  String resultType;
  String image;
  String title;
  String description;

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        id: json["id"],
        resultType: json["resultType"],
        image: json["image"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "resultType": resultType,
        "image": image,
        "title": title,
        "description": description,
      };
}
