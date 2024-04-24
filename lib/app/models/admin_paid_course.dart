// To parse this JSON data, do
//
//     final adminpaidcourse = adminpaidcourseFromJson(jsonString);

import 'dart:convert';

List<Adminpaidcourse> adminpaidcourseFromJson(String str) =>
    List<Adminpaidcourse>.from(
        json.decode(str).map((x) => Adminpaidcourse.fromJson(x)));

String adminpaidcourseToJson(List<Adminpaidcourse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Adminpaidcourse {
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
  final String? fullName;
  final String? email;
  final String? address;
  final String? profileImg;

  Adminpaidcourse({
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
    this.fullName,
    this.email,
    this.address,
    this.profileImg,
  });

  factory Adminpaidcourse.fromJson(Map<String, dynamic> json) =>
      Adminpaidcourse(
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
        fullName: json["full_name"],
        email: json["email"],
        address: json["address"],
        profileImg: json["profile_img"],
      );

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
        "full_name": fullName,
        "email": email,
        "address": address,
        "profile_img": profileImg,
      };
}
