import 'dart:convert';
import 'dart:typed_data';

import 'package:e_learn/app/controller/user_detail_controller.dart';
import 'package:e_learn/app/models/courses.dart';
import 'package:e_learn/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditCoursesAdminController extends GetxController {
  var course = Get.arguments as Courses;
  //TODO: Implement EditCoursesAdminController
  GlobalKey<FormState> productFormKey = GlobalKey<FormState>();
  TextEditingController courseNameController = TextEditingController();
  TextEditingController coursePriceController = TextEditingController();
  TextEditingController courseDescriptionController = TextEditingController();
  XFile? image;
  RxBool isLoading = false.obs;
  RxString url = ''.obs;
  late final SharedPreferences prefs;

  final count = 0.obs;
  final RxInt val = 1.obs; // Define RxInt for the selected value

  var picker = ImagePicker();
  var imagebytes = Uint8List(0);
  var selectedCategory = "".obs;
  var selectedcategoryName = "";

  @override
  Future<void> onInit() async {
    prefs = await SharedPreferences.getInstance();
    Get.find<HomepageController>().getCategory();
    courseNameController.text = course.courseName ?? 'No course name';
    coursePriceController.text = course.price ?? '0';
    courseDescriptionController.text = course.description ?? 'No description';
    url.value = course.image ?? '';
    selectedCategory.value = course.categoryId ?? '';
    print(course.categoryName);
    selectedcategoryName = course.categoryName ?? '';
    update();
    super.onInit();
  }

  void pickImage() async {
    try {
      image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        imagebytes = await image!.readAsBytes();
      }
      update();
    } catch (e) {
      Get.showSnackbar(
        const GetSnackBar(
          message: "Image upload failed",
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> onEditButtonCLicked() async {
    isLoading.value = true;
    try {
      if (productFormKey.currentState!.validate()) {
        var url =
            Uri.http(ipaddress, "finalyearproject_api/edit/editCourses.php");
        var form = http.MultipartRequest('POST', url);
        form.fields['course_id'] = course.categoryId ?? '';
        form.fields['token'] = prefs.getString('token')!;
        form.fields['is_online'] = val.value.toString();
        form.fields['course_name'] = courseNameController.text;
        form.fields['description'] = courseDescriptionController.text;
        form.fields['price'] = coursePriceController.text;
        form.fields['category_id'] = selectedCategory.value;

        form.files.add(http.MultipartFile.fromBytes('image', imagebytes,
            filename: image!.name));
        var response = await http.Response.fromStream(await form.send());

        var data = jsonDecode(response.body);
        if (data['success']) {
          Get.showSnackbar(GetSnackBar(
            message: data['message'],
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ));
          var userController = Get.find<UserDetailController>();
          userController.getCourses();
          update();
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
    isLoading.value = false;
  }

  Future<void> oncontentEdit() async {
    isLoading.value = true;
    try {
      if (productFormKey.currentState!.validate()) {
        var url = Uri.http(
            ipaddress, "finalyearproject_api/edit/editCourseContent.php");
        var form = http.MultipartRequest('POST', url);
        form.fields['content_id'] = course.categoryId ?? '';
        form.fields['token'] = prefs.getString('token')!;
        form.fields['content_name'] = val.value.toString();
        form.fields['content_description'] = courseNameController.text;
        form.fields['course_id'] = courseDescriptionController.text;
        form.fields['content_video'] = coursePriceController.text;
        form.fields['content_duration'] = selectedCategory.value;

        form.files.add(http.MultipartFile.fromBytes('image', imagebytes,
            filename: image!.name));
        var response = await http.Response.fromStream(await form.send());

        var data = jsonDecode(response.body);
        if (data['success']) {
          Get.showSnackbar(GetSnackBar(
            message: data['message'],
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ));
          var userController = Get.find<UserDetailController>();
          userController.getCourses();
          update();
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
    isLoading.value = false;
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
