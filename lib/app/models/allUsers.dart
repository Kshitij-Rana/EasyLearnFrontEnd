// To parse this JSON data, do
//
//     final allusers = allusersFromJson(jsonString);

import 'dart:convert';

List<Allusers> allusersFromJson(String str) =>
    List<Allusers>.from(json.decode(str).map((x) => Allusers.fromJson(x)));

String allusersToJson(List<Allusers> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Allusers {
  final String? userID;
  final String? fullName;
  final String? email;
  final String? userRole;
  final String? address;
  final String? bio;
  final String? otp;
  final String? profileImg;
  final String? isBlocked;

  Allusers({
    this.userID,
    this.fullName,
    this.email,
    this.userRole,
    this.address,
    this.bio,
    this.otp,
    this.profileImg,
    this.isBlocked,
  });

  factory Allusers.fromJson(Map<String, dynamic> json) => Allusers(
        userID: json["user_id"],
        fullName: json["full_name"],
        email: json["email"],
        userRole: json["role"],
        address: json["address"],
        bio: json["bio"],
        otp: json["otp"],
        isBlocked: json["isBlocked"],
        profileImg: json["profile_img"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userID,
        "full_name": fullName,
        "email": email,
        "role": userRole,
        "address": address,
        "bio": bio,
        "otp": otp,
        "profile_img": profileImg,
        "isBlocked": isBlocked
      };
}
