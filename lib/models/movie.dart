// To parse this JSON data, do
//
//     final movie = movieFromJson(jsonString);

import 'dart:convert';

Movie movieFromJson(String str) => Movie.fromJson(json.decode(str));

String movieToJson(Movie data) => json.encode(data.toJson());

class Movie {
  Movie({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.fullTitle,
    required this.type,
    required this.year,
    required this.image,
    required this.releaseDate,
    required this.runtimeMins,
    required this.runtimeStr,
    required this.plot,
    required this.plotLocal,
    required this.plotLocalIsRtl,
    required this.awards,
    required this.directors,
    required this.directorList,
    required this.writers,
    required this.writerList,
    required this.stars,
    required this.starList,
    required this.actorList,
    required this.fullCast,
    required this.genres,
    required this.genreList,
    required this.companies,
    required this.companyList,
    required this.countries,
    required this.countryList,
    required this.languages,
    required this.languageList,
    required this.contentRating,
    required this.imDbRating,
    required this.imDbRatingVotes,
    required this.metacriticRating,
    required this.ratings,
    required this.wikipedia,
    required this.posters,
    required this.images,
    required this.trailer,
    required this.boxOffice,
    required this.tagline,
    required this.keywords,
    required this.keywordList,
    required this.similars,
    required this.tvSeriesInfo,
    required this.tvEpisodeInfo,
    required this.errorMessage,
  });

  String id;
  String title;
  String originalTitle;
  String fullTitle;
  String type;
  String year;
  String image;
  DateTime releaseDate;
  String runtimeMins;
  String runtimeStr;
  String plot;
  String plotLocal;
  bool plotLocalIsRtl;
  String awards;
  String directors;
  List<CompanyListElement> directorList;
  String writers;
  List<CompanyListElement> writerList;
  String stars;
  List<CompanyListElement> starList;
  List<ActorList> actorList;
  dynamic fullCast;
  String genres;
  List<CountryListElement> genreList;
  String companies;
  List<CompanyListElement> companyList;
  String countries;
  List<CountryListElement> countryList;
  String languages;
  List<CountryListElement> languageList;
  String contentRating;
  String imDbRating;
  String imDbRatingVotes;
  String metacriticRating;
  dynamic ratings;
  dynamic wikipedia;
  dynamic posters;
  dynamic images;
  dynamic trailer;
  BoxOffice boxOffice;
  String tagline;
  String keywords;
  List<String> keywordList;
  List<Similar> similars;
  dynamic tvSeriesInfo;
  dynamic tvEpisodeInfo;
  dynamic errorMessage;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json["id"],
        title: json["title"],
        originalTitle: json["originalTitle"],
        fullTitle: json["fullTitle"],
        type: json["type"],
        year: json["year"],
        image: json["image"],
        releaseDate: DateTime.parse(json["releaseDate"]),
        runtimeMins: json["runtimeMins"],
        runtimeStr: json["runtimeStr"],
        plot: json["plot"],
        plotLocal: json["plotLocal"],
        plotLocalIsRtl: json["plotLocalIsRtl"],
        awards: json["awards"],
        directors: json["directors"],
        directorList: List<CompanyListElement>.from(
            json["directorList"].map((x) => CompanyListElement.fromJson(x))),
        writers: json["writers"],
        writerList: List<CompanyListElement>.from(
            json["writerList"].map((x) => CompanyListElement.fromJson(x))),
        stars: json["stars"],
        starList: List<CompanyListElement>.from(
            json["starList"].map((x) => CompanyListElement.fromJson(x))),
        actorList: List<ActorList>.from(
            json["actorList"].map((x) => ActorList.fromJson(x))),
        fullCast: json["fullCast"],
        genres: json["genres"],
        genreList: List<CountryListElement>.from(
            json["genreList"].map((x) => CountryListElement.fromJson(x))),
        companies: json["companies"],
        companyList: List<CompanyListElement>.from(
            json["companyList"].map((x) => CompanyListElement.fromJson(x))),
        countries: json["countries"],
        countryList: List<CountryListElement>.from(
            json["countryList"].map((x) => CountryListElement.fromJson(x))),
        languages: json["languages"],
        languageList: List<CountryListElement>.from(
            json["languageList"].map((x) => CountryListElement.fromJson(x))),
        contentRating: json["contentRating"],
        imDbRating: json["imDbRating"],
        imDbRatingVotes: json["imDbRatingVotes"],
        metacriticRating: json["metacriticRating"],
        ratings: json["ratings"],
        wikipedia: json["wikipedia"],
        posters: json["posters"],
        images: json["images"],
        trailer: json["trailer"],
        boxOffice: BoxOffice.fromJson(json["boxOffice"]),
        tagline: json["tagline"],
        keywords: json["keywords"],
        keywordList: List<String>.from(json["keywordList"].map((x) => x)),
        similars: List<Similar>.from(
            json["similars"].map((x) => Similar.fromJson(x))),
        tvSeriesInfo: json["tvSeriesInfo"],
        tvEpisodeInfo: json["tvEpisodeInfo"],
        errorMessage: json["errorMessage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "originalTitle": originalTitle,
        "fullTitle": fullTitle,
        "type": type,
        "year": year,
        "image": image,
        "releaseDate":
            "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "runtimeMins": runtimeMins,
        "runtimeStr": runtimeStr,
        "plot": plot,
        "plotLocal": plotLocal,
        "plotLocalIsRtl": plotLocalIsRtl,
        "awards": awards,
        "directors": directors,
        "directorList": List<dynamic>.from(directorList.map((x) => x.toJson())),
        "writers": writers,
        "writerList": List<dynamic>.from(writerList.map((x) => x.toJson())),
        "stars": stars,
        "starList": List<dynamic>.from(starList.map((x) => x.toJson())),
        "actorList": List<dynamic>.from(actorList.map((x) => x.toJson())),
        "fullCast": fullCast,
        "genres": genres,
        "genreList": List<dynamic>.from(genreList.map((x) => x.toJson())),
        "companies": companies,
        "companyList": List<dynamic>.from(companyList.map((x) => x.toJson())),
        "countries": countries,
        "countryList": List<dynamic>.from(countryList.map((x) => x.toJson())),
        "languages": languages,
        "languageList": List<dynamic>.from(languageList.map((x) => x.toJson())),
        "contentRating": contentRating,
        "imDbRating": imDbRating,
        "imDbRatingVotes": imDbRatingVotes,
        "metacriticRating": metacriticRating,
        "ratings": ratings,
        "wikipedia": wikipedia,
        "posters": posters,
        "images": images,
        "trailer": trailer,
        "boxOffice": boxOffice.toJson(),
        "tagline": tagline,
        "keywords": keywords,
        "keywordList": List<dynamic>.from(keywordList.map((x) => x)),
        "similars": List<dynamic>.from(similars.map((x) => x.toJson())),
        "tvSeriesInfo": tvSeriesInfo,
        "tvEpisodeInfo": tvEpisodeInfo,
        "errorMessage": errorMessage,
      };
}

class ActorList {
  ActorList({
    required this.id,
    required this.image,
    required this.name,
    required this.asCharacter,
  });

  String id;
  String image;
  String name;
  String asCharacter;

  factory ActorList.fromJson(Map<String, dynamic> json) => ActorList(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        asCharacter: json["asCharacter"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "asCharacter": asCharacter,
      };
}

class BoxOffice {
  BoxOffice({
    required this.budget,
    required this.openingWeekendUsa,
    required this.grossUsa,
    required this.cumulativeWorldwideGross,
  });

  String budget;
  String openingWeekendUsa;
  String grossUsa;
  String cumulativeWorldwideGross;

  factory BoxOffice.fromJson(Map<String, dynamic> json) => BoxOffice(
        budget: json["budget"],
        openingWeekendUsa: json["openingWeekendUSA"],
        grossUsa: json["grossUSA"],
        cumulativeWorldwideGross: json["cumulativeWorldwideGross"],
      );

  Map<String, dynamic> toJson() => {
        "budget": budget,
        "openingWeekendUSA": openingWeekendUsa,
        "grossUSA": grossUsa,
        "cumulativeWorldwideGross": cumulativeWorldwideGross,
      };
}

class CompanyListElement {
  CompanyListElement({
    required this.id,
    required this.name,
  });

  String id;
  String name;

  factory CompanyListElement.fromJson(Map<String, dynamic> json) =>
      CompanyListElement(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class CountryListElement {
  CountryListElement({
    required this.key,
    required this.value,
  });

  String key;
  String value;

  factory CountryListElement.fromJson(Map<String, dynamic> json) =>
      CountryListElement(
        key: json["key"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
      };
}

class Similar {
  Similar({
    required this.id,
    required this.title,
    required this.image,
    required this.imDbRating,
  });

  String id;
  String title;
  String image;
  String imDbRating;

  factory Similar.fromJson(Map<String, dynamic> json) => Similar(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        imDbRating: json["imDbRating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "imDbRating": imDbRating,
      };
}
