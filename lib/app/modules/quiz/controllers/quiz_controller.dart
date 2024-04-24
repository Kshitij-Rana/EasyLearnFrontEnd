import 'dart:convert';

import 'package:e_learn/app/controller/user_detail_controller.dart';
import 'package:e_learn/app/models/quiz.dart';
import 'package:e_learn/app/modules/quizDetails/controllers/quiz_details_controller.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class QuizController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController questionTextController = TextEditingController();
  final TextEditingController correctOptionController = TextEditingController();
  final TextEditingController option1Controller = TextEditingController();
  final TextEditingController option2Controller = TextEditingController();
  final TextEditingController option3Controller = TextEditingController();
  final TextEditingController option4Controller = TextEditingController();
  var quiz = Get.arguments as Quiz;
  SharedPreferences? prefs;
  final count = 0.obs;
  @override
  Future<void> onInit() async {
    questionTextController.text = quiz.questionText.toString();
    if (quiz.correctOption == quiz.option1) {
      correctOptionController.text = "1";
    } else if (quiz.correctOption == quiz.option2) {
      correctOptionController.text = "2";
    } else if (quiz.correctOption == quiz.option3) {
      correctOptionController.text = "3";
    } else if (quiz.correctOption == quiz.option4) {
      correctOptionController.text = "4";
    }
    option1Controller.text = quiz.option1.toString();
    option2Controller.text = quiz.option2.toString();
    option3Controller.text = quiz.option3.toString();
    option4Controller.text = quiz.option4.toString();

    prefs = await SharedPreferences.getInstance();
    super.onInit();
  }

  // void addQuiz() async {
  //   try {
  //     if (correctOptionController.text == "1") {
  //       correctOptionController.text = option1Controller.text;
  //     } else if (correctOptionController.text == "2") {
  //       correctOptionController.text = option2Controller.text;
  //     } else if (correctOptionController.text == "3") {
  //       correctOptionController.text = option3Controller.text;
  //     } else if (correctOptionController.text == "4") {
  //       correctOptionController.text = option4Controller.text;
  //     } else {
  //       Get.showSnackbar(GetSnackBar(
  //         message: "Error",
  //         backgroundColor: Colors.red,
  //         duration: const Duration(seconds: 3),
  //       ));
  //       return;
  //     }
  //     if (formKey.currentState!.validate()) {
  //       var url = Uri.http(ipaddress, "finalyearproject_api/addQuiz.php");
  //       var response = await http.post(url, body: {
  //         'token': prefs!.getString('token'),
  //         'course_id': quiz.courseId,
  //         'question_text': questionTextController.text,
  //         'correct_option': correctOptionController.text,
  //         'option1': option1Controller.text,
  //         'option2': option2Controller.text,
  //         'option3': option3Controller.text,
  //         'option4': option4Controller.text,
  //       });

  //       var data = jsonDecode(response.body);
  //       if (data['success']) {
  //         Get.showSnackbar(GetSnackBar(
  //           message: data['message'],
  //           backgroundColor: Colors.green,
  //           duration: const Duration(seconds: 3),
  //         ));
  //       } else {
  //         Get.showSnackbar(GetSnackBar(
  //           message: data['message'],
  //           backgroundColor: Colors.red,
  //           duration: const Duration(seconds: 3),
  //         ));
  //       }
  //     } else {
  //       Get.showSnackbar(const GetSnackBar(
  //         message: "Fill all the fields",
  //         backgroundColor: Colors.red,
  //         duration: Duration(seconds: 3),
  //       ));
  //     }
  //   } catch (e) {
  //     print(e);

  //     Get.showSnackbar(GetSnackBar(
  //       message: "Something went wrong hai:$e",
  //       backgroundColor: Colors.red,
  //       duration: Duration(seconds: 3),
  //     ));
  //   }
  // }

  void updateQuiz() async {
    try {
      if (correctOptionController.text == "1") {
        correctOptionController.text = option1Controller.text;
      } else if (correctOptionController.text == "2") {
        correctOptionController.text = option2Controller.text;
      } else if (correctOptionController.text == "3") {
        correctOptionController.text = option3Controller.text;
      } else if (correctOptionController.text == "4") {
        correctOptionController.text = option4Controller.text;
      } else {
        Get.showSnackbar(GetSnackBar(
          message: "Error",
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ));
        return;
      }
      if (formKey.currentState!.validate()) {
        var url = Uri.http(ipaddress, "finalyearproject_api/updateQuiz.php");
        var response = await http.post(url, body: {
          'token': prefs!.getString('token'),
          'quiz_id': quiz.quizId,
          'question_text': questionTextController.text,
          'correct_option': correctOptionController.text,
          'option1': option1Controller.text,
          'option2': option2Controller.text,
          'option3': option3Controller.text,
          'option4': option4Controller.text,
        });

        var data = jsonDecode(response.body);
        if (data['success']) {
          Get.find<QuizDetailsController>().getQuiz(quiz.courseId ?? '');
          Get.back();
          Get.showSnackbar(GetSnackBar(
            message: data['message'],
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ));
        } else {
          Get.showSnackbar(GetSnackBar(
            message: data['message'],
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ));
        }
      } else {
        Get.showSnackbar(const GetSnackBar(
          message: "Fill all the fields",
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ));
      }
    } catch (e) {
      print(e);

      Get.showSnackbar(GetSnackBar(
        message: "Something went wrong hai:$e",
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ));
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
