// To parse this JSON data, do
//
//     final courseContent = courseContentFromJson(jsonString);

import 'dart:convert';

List<CourseContent> courseContentFromJson(String str) =>
    List<CourseContent>.from(
        json.decode(str).map((x) => CourseContent.fromJson(x)));

String courseContentToJson(List<CourseContent> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CourseContent {
  final String? contentId;
  final String? contentName;
  final String? contentDescription;
  final String? courseId;
  final String? contentVideo;
  final String? contentDuration;
  final DateTime? contentUploadDate;

  CourseContent({
    this.contentId,
    this.contentName,
    this.contentDescription,
    this.courseId,
    this.contentVideo,
    this.contentDuration,
    this.contentUploadDate,
  });

  factory CourseContent.fromJson(Map<String, dynamic> json) => CourseContent(
        contentId: json["content_id"],
        contentName: json["content_name"],
        contentDescription: json["content_description"],
        courseId: json["course_id"],
        contentVideo: json["content_video"],
        contentDuration: json["content_duration"],
        contentUploadDate: json["content_upload_date"] == null
            ? null
            : DateTime.parse(json["content_upload_date"]),
      );

  Map<String, dynamic> toJson() => {
        "content_id": contentId,
        "content_name": contentName,
        "content_description": contentDescription,
        "course_id": courseId,
        "content_video": contentVideo,
        "content_duration": contentDuration,
        "content_upload_date": contentUploadDate?.toIso8601String(),
      };
}
