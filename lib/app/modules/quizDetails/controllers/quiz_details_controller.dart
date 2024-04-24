import 'dart:convert';

import 'package:e_learn/app/models/courses.dart';
import 'package:e_learn/app/models/quiz.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class QuizDetailsController extends GetxController {
  //TODO: Implement QuizDetailsController
  var course = Get.arguments as Courses;
  final count = 0.obs;
  RxList<Quiz>? quizz = RxList<Quiz>([]);
  SharedPreferences? prefs;

  @override
  Future<void> onInit() async {
    prefs = await SharedPreferences.getInstance();
    await getQuiz(course.courseId ?? "1");
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> getQuiz(String courseId) async {
    try {
      var url = Uri.http(ipaddress, 'finalyearproject_api/getQuiz.php');
      var response = await http.post(url,
          body: {'token': prefs!.getString('token'), 'course_id': courseId});
      var result = jsonDecode(response.body);
      if (result['success']) {
        // Get.showSnackbar(GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: result['message'],
        //     duration: const Duration(seconds: 3)));
        quizz?.value = quizFromJson(jsonEncode(result['data']));
        print(quizz?.value);
        update();
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: "hya Bigriyo hai",
        duration: Duration(seconds: 3),
      ));
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
