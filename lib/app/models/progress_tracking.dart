// To parse this JSON data, do
//
//     final progressTracking = progressTrackingFromJson(jsonString);

import 'dart:convert';

List<ProgressTracking> progressTrackingFromJson(String str) =>
    List<ProgressTracking>.from(
        json.decode(str).map((x) => ProgressTracking.fromJson(x)));

String progressTrackingToJson(List<ProgressTracking> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProgressTracking {
  final String? progressTrackingId;
  final String? progressNumber;
  final String? lessonId;
  final String? userId;

  ProgressTracking({
    this.progressTrackingId,
    this.progressNumber,
    this.lessonId,
    this.userId,
  });

  factory ProgressTracking.fromJson(Map<String, dynamic> json) =>
      ProgressTracking(
        progressTrackingId: json["progress_tracking_id"],
        progressNumber: json["progress_number"],
        lessonId: json["lesson_id"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "progress_tracking_id": progressTrackingId,
        "progress_number": progressNumber,
        "lesson_id": lessonId,
        "user_id": userId,
      };
}
