// To parse this JSON data, do
//
//     final quiz = quizFromJson(jsonString);

import 'dart:convert';

List<Quiz> quizFromJson(String str) =>
    List<Quiz>.from(json.decode(str).map((x) => Quiz.fromJson(x)));

String quizToJson(List<Quiz> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Quiz {
  final String? quizId;
  final String? courseId;
  final String? questionText;
  final String? correctOption;
  final String? option1;
  final String? option2;
  final String? option3;
  final String? option4;

  Quiz({
    this.quizId,
    this.courseId,
    this.questionText,
    this.correctOption,
    this.option1,
    this.option2,
    this.option3,
    this.option4,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        quizId: json["quiz_id"],
        courseId: json["course_id"],
        questionText: json["question_text"],
        correctOption: json["correct_option"],
        option1: json["option1"],
        option2: json["option2"],
        option3: json["option3"],
        option4: json["option4"],
      );

  Map<String, dynamic> toJson() => {
        "quiz_id": quizId,
        "course_id": courseId,
        "question_text": questionText,
        "correct_option": correctOption,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4,
      };
}
