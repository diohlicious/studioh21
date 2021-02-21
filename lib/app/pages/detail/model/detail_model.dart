// To parse this JSON data, do
//
//     final detailModel = detailModelFromJson(jsonString);

import 'dart:convert';

DetailModel detailModelFromJson(String str) => DetailModel.fromJson(json.decode(str));

String detailModelToJson(DetailModel data) => json.encode(data.toJson());

class DetailModel {
  DetailModel({
    this.genres,
    this.backdropPath,
    this.homepage,
    this.overview,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.runtime,
    this.tagline,
    this.title,
    this.voteAverage,
    this.voteCount,
  });

  String genres;
  String backdropPath;
  String homepage;
  String overview;
  String productionCompanies;
  String productionCountries;
  DateTime releaseDate;
  int runtime;
  String tagline;
  String title;
  double voteAverage;
  int voteCount;

  factory DetailModel.fromJson(Map<String, dynamic> json) => DetailModel(
    genres: json["genres"],
    backdropPath: json["backdrop_path"],
    homepage: json["homepage"],
    overview: json["overview"],
    productionCompanies: json["production_companies"],
    productionCountries: json["production_countries"],
    releaseDate: DateTime.parse(json["release_date"]),
    runtime: json["runtime"],
    tagline: json["tagline"],
    title: json["title"],
    voteAverage: json["vote_average"].toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "genres": genres,
    "backdrop_path": backdropPath,
    "homepage": homepage,
    "overview": overview,
    "production_companies": productionCompanies,
    "production_countries": productionCountries,
    "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    "runtime": runtime,
    "tagline": tagline,
    "title": title,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}
