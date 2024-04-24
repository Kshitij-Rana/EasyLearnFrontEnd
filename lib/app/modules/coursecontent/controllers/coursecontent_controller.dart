import 'dart:convert';

import 'package:e_learn/app/models/course_content.dart';
import 'package:e_learn/app/models/courses.dart';
import 'package:e_learn/app/models/ratings.dart';
import 'package:e_learn/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:http/http.dart' as http;

class CoursecontentController extends GetxController {
  SharedPreferences? prefs;
  final count = 0.obs;
  RxBool isPaid = true.obs;
  var courses = Get.arguments as Courses;
  var contactNo = "";
  var length = 0;
  var homecontroller = Get.find<HomepageController>();
  RxList<Ratings>? courseRatings = RxList<Ratings>([]);

  RxList<CourseContent>? courseContentCourseId = RxList<CourseContent>([]);

  late List<RxBool> isClicked;
  void increment() => count.value++;
  void initializeIsClicked(int length) {
    isClicked = List.generate(length, (index) => RxBool(false));
  }

  void openPhoneCall() async {
    // const phoneNumber = "9825149182";
    String dialerUri = "tel:$contactNo";
    if (dialerUri != " ") {
      await launchUrlString(dialerUri);
    } else {
      throw 'Could not launch $dialerUri';
    }
  }

  void addCourseContent() {
    courseContentCourseId?.value = homecontroller.courseContent!
        .where((courseContent) => courseContent.courseId == courses.courseId)
        .toList();
    length = courseContentCourseId?.length ?? 0;
  }

  @override
  Future<void> onInit() async {
    addCourseContent();
    initializeIsClicked(length);

    contactNo = courses.ConactNo ?? '';

    prefs = await SharedPreferences.getInstance();
    getCourseRating();
    super.onInit();
  }

  Future<void> getCourseRating() async {
    try {
      print(courses.courseId);
      courseRatings?.value =
          []; // Ensure coursesAddedByInstructor is empty before adding new courses
      var url = Uri.http(ipaddress, 'finalyearproject_api/getCourseRating.php');
      var response = await http.post(url, body: {
        'token': prefs!.getString('token'),
        'course_id': courses.courseId
      });
      var result = jsonDecode(response.body);
      if (result['success']) {
        courseRatings?.value = ratingsFromJson(jsonEncode(result['data']));
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

  Future<void> deleteCourseContent(int courseId, int contentId) async {
    try {
      var uRL =
          Uri.http(ipaddress, "finalyearproject_api/deleteCourseContent.php");
      var response = await http.post(uRL, body: {
        'token': prefs?.getString('token'),
        'course_id': courseId.toString(),
        'content_id': contentId.toString()
      });
      var result = jsonDecode(response.body);
      if (result['success']) {
        await Get.find<HomepageController>().getCourseContent();
        addCourseContent();
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.green,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
        update();
      } else {
        print(result['message']);
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: const Duration(seconds: 3),
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
}
