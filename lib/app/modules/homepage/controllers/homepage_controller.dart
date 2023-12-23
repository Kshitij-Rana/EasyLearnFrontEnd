import 'dart:convert';

import 'package:e_learn/app/models/category.dart';
import 'package:e_learn/app/models/courses.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomepageController extends GetxController {
  List<Categories>? category = [];
  List<Courses>? courses = [];
  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    getCourses();
    getCategory();
    update();
  }

  void getCategory() async {
    try {
      var url = Uri.http(ipaddress, 'finalyearproject_api/getCategory.php');
      var response = await http.get(url);
      var result = jsonDecode(response.body);
      if (result['success']) {
        // Get.showSnackbar(GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: result['message'],
        //     duration: const Duration(seconds: 3)));
        category = categoryFromJson(jsonEncode(result['data']));
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
        message: "Bigriyo hai",
        duration: Duration(seconds: 3),
      ));
    }
  }

  void getCourses() async {
    try {
      var url = Uri.http(ipaddress, 'finalyearproject_api/getCourses.php');
      var response = await http.get(url);
      var result = jsonDecode(response.body);
      if (result['success']) {
        // Get.showSnackbar(GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: result['message'],
        //     duration: const Duration(seconds: 3)));
        courses = coursesFromJson(jsonEncode(result['data']));
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
        message: "Bigriyo hai",
        duration: Duration(seconds: 3),
      ));
    }
  }

  void increment() => count.value++;
}
