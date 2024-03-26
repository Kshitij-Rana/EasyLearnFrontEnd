// To parse this JSON data, do
//
//     final courses = coursesFromJson(jsonString);

import 'dart:convert';

List<Courses> coursesFromJson(String str) =>
    List<Courses>.from(json.decode(str).map((x) => Courses.fromJson(x)));

String coursesToJson(List<Courses> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Courses {
  final String? courseId;
  final String? categoryId;
  final String? averageRating;
  final String? fullName;
  final String? courseName;
  final String? price;
  final String? image;
  final String? description;
  final String? isOnline;
  final String? categoryName;
  final String? userId;
  final String? numberOfContents;
  final String? totalDuration;

  Courses(
      {this.courseId,
      this.categoryId,
      this.fullName,
      this.courseName,
      this.price,
      this.image,
      this.description,
      this.isOnline,
      this.categoryName,
      this.numberOfContents,
      this.totalDuration,
      this.averageRating,
      this.userId});

  factory Courses.fromJson(Map<String, dynamic> json) => Courses(
      courseId: json["course_id"],
      categoryId: json["category_id"],
      fullName: json["full_name"],
      courseName: json["course_name"],
      price: json["price"],
      image: json["image"],
      description: json["description"],
      isOnline: json["is_online"],
      categoryName: json["category_name"],
      userId: json["user_id"],
      numberOfContents: json["number_of_contents"],
      averageRating: json["avg_rating"],
      totalDuration: json["total_duration"]);

  Map<String, dynamic> toJson() => {
        "course_id": courseId,
        "category_id": categoryId,
        "full_name": fullName,
        "course_name": courseName,
        "price": price,
        "image": image,
        "description": description,
        "is_online": isOnline,
        "category_name": categoryName,
        "user_id": userId,
        "number_of_contents": numberOfContents,
        "total_duration": totalDuration,
        "avg_rating": averageRating
      };
}
