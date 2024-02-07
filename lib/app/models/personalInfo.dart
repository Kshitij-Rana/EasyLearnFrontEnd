// To parse this JSON data, do
//
//     final userPersonalInfo = userPersonalInfoFromJson(jsonString);

import 'dart:convert';

UserPersonalInfo userPersonalInfoFromJson(String str) =>
    UserPersonalInfo.fromJson(json.decode(str));

String userPersonalInfoToJson(UserPersonalInfo data) =>
    json.encode(data.toJson());

class UserPersonalInfo {
  final String? fullName;
  final String? email;
  final String? role;
  final String? address;
  final String? bio;
  final String? otp;
  final String? profileImg;

  UserPersonalInfo({
    this.fullName,
    this.email,
    this.role,
    this.address,
    this.bio,
    this.otp,
    this.profileImg,
  });

  factory UserPersonalInfo.fromJson(Map<String, dynamic> json) =>
      UserPersonalInfo(
        fullName: json["full_name"],
        email: json["email"],
        role: json["role"],
        address: json["address"],
        bio: json["bio"],
        otp: json["otp"],
        profileImg: json["profile_img"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "email": email,
        "role": role,
        "address": address,
        "bio": bio,
        "otp": otp,
        "profile_img": profileImg,
      };
}
