// To parse this JSON data, do
//
//     final courses = coursesFromJson(jsonString);

import 'dart:convert';

List<Courses> coursesFromJson(String str) =>
    List<Courses>.from(json.decode(str).map((x) => Courses.fromJson(x)));

String coursesToJson(List<Courses> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Courses {
  final String? fullName;
  final String? courseName;
  final String? price;
  final String? image;
  final String? description;
  final String? isOnline;
  final String? categoryName;

  Courses({
    this.fullName,
    this.courseName,
    this.price,
    this.image,
    this.description,
    this.isOnline,
    this.categoryName,
  });

  factory Courses.fromJson(Map<String, dynamic> json) => Courses(
        fullName: json["full_name"],
        courseName: json["course_name"],
        price: json["price"],
        image: json["image"],
        description: json["description"],
        isOnline: json["is_online"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "course_name": courseName,
        "price": price,
        "image": image,
        "description": description,
        "is_online": isOnline,
        "category_name": categoryName,
      };
}
