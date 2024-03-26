import 'dart:convert';

import 'package:e_learn/app/controller/user_detail_controller.dart';
import 'package:e_learn/app/models/category.dart';
import 'package:e_learn/app/models/course_content.dart';
import 'package:e_learn/app/models/courses.dart';
import 'package:e_learn/app/models/paid_courses.dart';
import 'package:e_learn/app/models/ratings.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomepageController extends GetxController {
  var testController = TextEditingController();
  TextEditingController ratingDescriptionController = TextEditingController();
  RxList<Categories>? category = RxList<Categories>([]);
  RxList<Ratings> rating = RxList<Ratings>([]);

  RxList<Courses>? courses = RxList<Courses>([]);
  RxList<Paidcourse>? paidCourses = RxList<Paidcourse>([]);

  RxList<Courses>? coursesAddedByInstructor = RxList<Courses>([]);
  RxList<CourseContent>? courseContent = RxList<CourseContent>([]);
  RxDouble ratingNumber = 2.5.obs;
  SharedPreferences? prefs;
  var givenuserId;
  var role;
  RxBool isRated = false.obs;
  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    givenuserId = prefs!.getString('userId');
    role = prefs!.getString('role');
    await getCourses();
    await getCategory();
    await getCourseContent();
    paidCourses = Get.find<UserDetailController>().paidCourses;
    update();
  }

  Future<void> ratingCourses(String courseid) async {
    var url = Uri.http(ipaddress, "finalyearproject_api/addRating.php");
    var response = await http.post(url, body: {
      'token': prefs!.getString('token')!,
      'rating_number': ratingNumber.value.toString(),
      'course_id': courseid,
      'rating_description': ratingDescriptionController.text
    });
    print(response.body);
    var data = jsonDecode(response.body);
    if (data['success']) {
      isRated.value = true;
      getRatingofUser(courseid);
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
  }

  Future<void> getRatingofUser(String courseId) async {
    try {
      var url =
          Uri.http(ipaddress, 'finalyearproject_api/getRatingByUserid.php');
      var response = await http.post(url,
          body: {'token': prefs!.getString('token'), 'course_id': courseId});
      var result = jsonDecode(response.body);
      if (result['success']) {
        // Get.showSnackbar(GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: result['message'],
        //     duration: const Duration(seconds: 3)));
        rating.value = ratingsFromJson(jsonEncode(result['data']));
        if (rating.isEmpty) {
          isRated.value = false;
        } else {
          isRated.value = true;
        }
        update();
      } else {
        isRated.value = false;

        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {}
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
        category?.value = categoryFromJson(jsonEncode(result['data']));
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

  Future<void> getCourses() async {
    try {
      coursesAddedByInstructor == [];
      var url = Uri.http(ipaddress, 'finalyearproject_api/getCourses.php');
      var response = await http.get(url);
      var result = jsonDecode(response.body);
      if (result['success']) {
        // Get.showSnackbar(GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: result['message'],
        //     duration: const Duration(seconds: 3)));
        courses?.value = coursesFromJson(jsonEncode(result['data']));
        List<Courses> matchingCourses =
            courses!.where((course) => course.userId == givenuserId).toList();
        coursesAddedByInstructor!.addAll(matchingCourses);
        print(coursesAddedByInstructor?.length);
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

  Future<void> getCourseContent() async {
    try {
      var url =
          Uri.http(ipaddress, 'finalyearproject_api/getCourseContent.php');
      var response = await http
          .post(url, body: {'token': prefs?.getString("token") ?? ''});
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
        message: "Bigriyo hai courseCOntent",
        duration: Duration(seconds: 3),
      ));
    }
  }

  Future<void> deleteCourse(int courseId) async {
    try {
      coursesAddedByInstructor?.value = [];

      var uRL = Uri.http(ipaddress, "finalyearproject_api/deleteCourse.php");
      var response = await http.post(uRL, body: {
        'token': prefs?.getString('token'),
        'course_id': courseId.toString(),
      });
      var result = jsonDecode(response.body);
      if (result['success']) {
        await getCourses();

        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.green,
          message: result['message'],
          duration: Duration(seconds: 3),
        ));
        update();
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: Duration(seconds: 3),
        ));
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong hai',
        duration: Duration(seconds: 3),
      ));
    }
  }

  void increment() => count.value++;
}
