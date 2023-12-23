// To parse this JSON data, do
//
//     final myUser = myUserFromJson(jsonString);

import 'dart:convert';

List<Categories> categoryFromJson(String str) =>
    List<Categories>.from(json.decode(str).map((x) => Categories.fromJson(x)));

String categoryToJson(List<Categories> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categories {
  final String? categoryId;
  final String? categoryName;

  Categories({
    this.categoryId,
    this.categoryName,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
      };
}
