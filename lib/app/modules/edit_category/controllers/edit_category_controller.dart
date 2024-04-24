import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:e_learn/app/controller/user_detail_controller.dart';
import 'package:e_learn/app/models/category.dart';
import 'package:e_learn/app/routes/app_pages.dart';
import 'package:e_learn/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditCategoryController extends GetxController {
  //TODO: Implement EditCategoryController
  GlobalKey<FormState> categoryFormKey = GlobalKey<FormState>();
  TextEditingController categoryController = TextEditingController();
  var imagebytes = Uint8List(0).obs;
  late final SharedPreferences prefs;

  XFile? image;
  var picker = ImagePicker();
  RxBool addingCategoryLoading = false.obs;
  final count = 0.obs;
  var selectedCategory = Get.arguments as Categories;
  var url = ''.obs;
  var categoryId = "".obs;
  var task;
  RxBool isLoading = false.obs;
  @override
  Future<void> onInit() async {
    prefs = await SharedPreferences.getInstance();
    categoryController.text = selectedCategory.categoryName ?? '';
    url.value = selectedCategory.categoryImage ?? '';
    categoryId.value = selectedCategory.categoryId ?? '';

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void pickImage() async {
    try {
      image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        imagebytes.value = await image!.readAsBytes();
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

  Future<void> editCategory() async {
    isLoading.value = true;
    try {
      if (categoryFormKey.currentState!.validate()) {
        if (image != null) {
          final storageref = FirebaseStorage.instance.ref();
          final imageRef =
              storageref.child(DateTime.now().toString() + image!.name);
          task = await imageRef.putFile(File(image!.path),
              SettableMetadata(contentType: "image/${image!.mimeType}"));
          url.value = await imageRef.getDownloadURL();
          // debugPrint("New URL:$url");
        }
        var uRL =
            Uri.http(ipaddress, "finalyearproject_api/edit/editCategory.php");
        var response = await http.post(uRL, body: {
          'token': prefs.getString('token'),
          'category_id': categoryId.value,
          'category_name': categoryController.text,
          'category_image': url.value,
        });
        var result = jsonDecode(response.body);
        if (result['success']) {
          Get.find<UserDetailController>().getCategory();
          Get.showSnackbar(const GetSnackBar(
            backgroundColor: Colors.green,
            message: 'Category updated',
            duration: Duration(seconds: 3),
          ));
          Get.offAllNamed(Routes.ADMIN_MAIN);
          update();
        } else {
          Get.showSnackbar(GetSnackBar(
            backgroundColor: Colors.red,
            message: result['message'],
            duration: Duration(seconds: 3),
          ));
        }
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: Duration(seconds: 3),
      ));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteCategory() async {
    try {
      var uRL = Uri.http(ipaddress, "finalyearproject_api/deleteCategory.php");
      var response = await http.post(uRL, body: {
        'token': prefs.getString('token'),
        'category_id': categoryId.value,
      });
      print(response.body);
      var result = jsonDecode(response.body);
      if (result['success']) {
        Get.find<UserDetailController>().getCategory();
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.green,
          message: result['message'],
          duration: Duration(seconds: 3),
        ));
        Get.offAllNamed(Routes.ADMIN_MAIN);
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
