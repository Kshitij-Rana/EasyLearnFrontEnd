import 'dart:convert';
import 'package:e_learn/app/models/category.dart';
import 'package:e_learn/app/models/paid_courses.dart';

import 'package:e_learn/app/models/course_content.dart';
import 'package:e_learn/app/models/courses.dart';
import 'package:http/http.dart' as http;
import 'package:e_learn/app/models/personalInfo.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetailController extends GetxController {
  Rx<UserPersonalInfo> userInfo = Rx<UserPersonalInfo>(UserPersonalInfo());
  RxBool isFetched = false.obs;
  late final SharedPreferences prefs;
  var profilePic = ''.obs;
  RxList<Paidcourse>? paidCourses = RxList<Paidcourse>([]);
  RxList<Categories> category = RxList<Categories>();
  RxList<CourseContent>? courseContent = RxList<CourseContent>([]);
  RxList<Courses>? courses = RxList<Courses>([]);

  @override
  void onInit() async {
    prefs = await SharedPreferences.getInstance();
    await getUserInfo();
    await getCategory();
    await getPaidCourses();
    await getCourses();
    super.onInit();
  }

  Future<void> getUserInfo() async {
    try {
      var url = Uri.http(ipaddress, 'finalyearproject_api/getUserInfo.php');
      var response =
          await http.post(url, body: {'token': prefs.getString('token')});
      var result = jsonDecode(response.body);

      if (result['success']) {
        // Get.showSnackbar(GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: result['message'],
        //     duration: const Duration(seconds: 3)));
        userInfo.value = userPersonalInfoFromJson(jsonEncode(result['data']));
        isFetched.value = true;
        profilePic.value = userInfo?.value.profileImg ?? '';
        update();
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong in userInfo fetch',
        duration: Duration(seconds: 3),
      ));
    }
  }

  Future<void> getCategory() async {
    try {
      var url = Uri.http(ipaddress, 'finalyearproject_api/getCategory.php');
      var response = await http.get(url);
      var result = jsonDecode(response.body);
      if (result['success']) {
        // Get.showSnackbar(GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: result['message'],
        //     duration: const Duration(seconds: 3)));
        category.value = categoryFromJson(jsonEncode(result['data']));
        update();
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      // print(e);
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: "Bigriyo hai",
        duration: Duration(seconds: 3),
      ));
    }
  }

  Future<void> getPaidCourses() async {
    try {
      var url = Uri.http(ipaddress, 'finalyearproject_api/getPaidCourses.php');
      var response = await http.post(url, body: {'token': prefs.get('token')});
      var result = jsonDecode(response.body);
      if (result['success']) {
        // Get.showSnackbar(GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: result['message'],
        //     duration: const Duration(seconds: 3)));
        paidCourses?.value = paidcourseFromJson(jsonEncode(result['data']));
        update();
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      print(e);
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: "Bigriyo hai paidCourse",
        duration: Duration(seconds: 3),
      ));
    }
  }

  Future<void> getCourses() async {
    try {
      var url = Uri.http(ipaddress, 'finalyearproject_api/getCourses.php');
      var response = await http.get(url);
      var result = jsonDecode(response.body);
      if (result['success']) {
        // Get.showSnackbar(GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: result['message'],
        //     duration: const Duration(seconds: 3)));
        courses?.value = coursesFromJson(jsonEncode(result['data']));
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
        message: "Bigriyo hai course",
        duration: Duration(seconds: 3),
      ));
    }
  }

  Future<void> getCourseContent() async {
    try {
      var url =
          Uri.http(ipaddress, 'finalyearproject_api/getCourseContent.php');
      var response =
          await http.post(url, body: {'token': prefs.getString("token") ?? ''});
      var result = jsonDecode(response.body);
      if (result['success']) {
        // Get.showSnackbar(GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: result['message'],
        //     duration: const Duration(seconds: 3)));
        courseContent?.value =
            courseContentFromJson(jsonEncode(result['data']));
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
        message: "Bigriyo hai courseContent",
        duration: Duration(seconds: 3),
      ));
    }
  }
}
