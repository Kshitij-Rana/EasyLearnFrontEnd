// To parse this JSON data, do
//
//     final ratings = ratingsFromJson(jsonString);

import 'dart:convert';

List<Ratings> ratingsFromJson(String str) =>
    List<Ratings>.from(json.decode(str).map((x) => Ratings.fromJson(x)));

String ratingsToJson(List<Ratings> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ratings {
  final String? username;
  final String? ratingId;
  final String? courseId;
  final String? ratingNumber;
  final String? ratingDescription;
  final DateTime? ratingDate;
  final String? userId;

  Ratings({
    this.username,
    this.ratingId,
    this.courseId,
    this.ratingNumber,
    this.ratingDescription,
    this.ratingDate,
    this.userId,
  });

  factory Ratings.fromJson(Map<String, dynamic> json) => Ratings(
      ratingId: json["rating_id"],
      courseId: json["course_id"],
      ratingNumber: json["rating_number"],
      ratingDescription: json["rating_description"],
      ratingDate: json["rating_date"] == null
          ? null
          : DateTime.parse(json["rating_date"]),
      userId: json["user_id"],
      username: json["full_name"]);

  Map<String, dynamic> toJson() => {
        "full_name": username,
        "rating_id": ratingId,
        "course_id": courseId,
        "rating_number": ratingNumber,
        "rating_description": ratingDescription,
        "rating_date": ratingDate?.toIso8601String(),
        "user_id": userId,
      };
}
