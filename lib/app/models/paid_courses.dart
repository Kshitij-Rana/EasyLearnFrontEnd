// To parse this JSON data, do
//
//     final paidcourse = paidcourseFromJson(jsonString);

import 'dart:convert';

List<Paidcourse> paidcourseFromJson(String str) =>
    List<Paidcourse>.from(json.decode(str).map((x) => Paidcourse.fromJson(x)));

String paidcourseToJson(List<Paidcourse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Paidcourse {
  final String? orderId;
  final String? total;
  final DateTime? orderDate;
  final String? status;
  final String? lineTotal;
  final String? courseId;
  final String? courseName;
  final String? categoryId;
  final String? price;
  final String? image;
  final String? isOnline;
  final String? description;
  final String? fullName;
  final String? numberOfContent;

  Paidcourse({
    this.numberOfContent,
    this.fullName,
    this.orderId,
    this.total,
    this.orderDate,
    this.status,
    this.lineTotal,
    this.courseId,
    this.courseName,
    this.categoryId,
    this.price,
    this.image,
    this.isOnline,
    this.description,
  });

  factory Paidcourse.fromJson(Map<String, dynamic> json) => Paidcourse(
      orderId: json["order_id"],
      total: json["total"],
      orderDate: json["order_date"] == null
          ? null
          : DateTime.parse(json["order_date"]),
      status: json["status"],
      lineTotal: json["line_total"],
      courseId: json["course_id"],
      courseName: json["course_name"],
      categoryId: json["category_id"],
      price: json["price"],
      image: json["image"],
      isOnline: json["is_online"],
      description: json["description"],
      fullName: json["full_name"],
      numberOfContent: json["number_of_courses"]);

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "total": total,
        "order_date": orderDate?.toIso8601String(),
        "status": status,
        "line_total": lineTotal,
        "course_id": courseId,
        "course_name": courseName,
        "category_id": categoryId,
        "price": price,
        "image": image,
        "is_online": isOnline,
        "description": description,
        "full_name": fullName,
        "number_of_courses": numberOfContent
      };
}
