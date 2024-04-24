// To parse this JSON data, do
//
//     final quizMarks = quizMarksFromJson(jsonString);

import 'dart:convert';

List<QuizMarks> quizMarksFromJson(String str) =>
    List<QuizMarks>.from(json.decode(str).map((x) => QuizMarks.fromJson(x)));

String quizMarksToJson(List<QuizMarks> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuizMarks {
  final String? quizMarksid;
  final String? courseId;
  final String? obtainedMarks;
  final String? fullMarks;
  final String? userId;

  QuizMarks({
    this.quizMarksid,
    this.courseId,
    this.obtainedMarks,
    this.fullMarks,
    this.userId,
  });

  factory QuizMarks.fromJson(Map<String, dynamic> json) => QuizMarks(
        quizMarksid: json["quizMarksid"],
        courseId: json["course_id"],
        obtainedMarks: json["obtainedMarks"],
        fullMarks: json["fullMarks"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "quizMarksid": quizMarksid,
        "course_id": courseId,
        "obtainedMarks": obtainedMarks,
        "fullMarks": fullMarks,
        "user_id": userId,
      };
}
