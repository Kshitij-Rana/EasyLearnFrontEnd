import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:e_learn/app/controller/user_detail_controller.dart';
import 'package:e_learn/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:e_learn/components/addCategoryPopup.dart';
import 'package:e_learn/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHomeController extends GetxController {
  late final SharedPreferences prefs;
  var isAdded = false.obs;

  //for adding category
  GlobalKey<FormState> categoryFormKey = GlobalKey<FormState>();
  TextEditingController categoryController = TextEditingController();
  //for adding product
  GlobalKey<FormState> productFormKey = GlobalKey<FormState>();
  TextEditingController courseNameController = TextEditingController();
  TextEditingController coursePriceController = TextEditingController();
  TextEditingController courseDescriptionController = TextEditingController();
  var selectedCategory = "".obs;
  var picker = ImagePicker();
  final RxInt val = 1.obs; // Define RxInt for the selected value

//Image picking
  var imagebytes = Uint8List(0);
  XFile? image;
  var task;
  String urls = '';
  final count = 0.obs;
  var addingCategoryLoading = false.obs;
  var stats;
  @override
  void onInit() async {
    Get.find<HomepageController>().getCategory();
    prefs = await SharedPreferences.getInstance();
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

  void getStats() async {
    try {
      var url = Uri.http(ipaddress, 'finalyearproject_api/getStats.php');
      var response =
          await http.post(url, body: {'token': prefs.getString('token')});
      var result = jsonDecode(response.body);

      if (result['success']) {}
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: Duration(seconds: 3),
      ));
    }
  }

  void onAddCategory() {
    showDialog(
      context: Get.context!,
      builder: (context) => const AddCategoryPopup(),
    );
  }

  void addCategory() async {
    addingCategoryLoading.value = true;
    try {
      // if (imageUrl == null) {
      //   var userDetails = Get.find<UserDetailControllerController>().userInfo;
      //   imageUrl = userDetails.image;
      // }

      if (categoryFormKey.currentState!.validate()) {
        String? imageUrl;

        if (image != null) {
          // FirebaseStorage.instance.ref(url).delete();
          // debugPrint("previous URL:$url");
          final storageRef = FirebaseStorage.instance.ref();
          final imageRef =
              storageRef.child(DateTime.now().toString() + image!.name);
          task = await imageRef.putFile(File(image!.path),
              SettableMetadata(contentType: "image/${image!.mimeType}"));
          urls = await imageRef.getDownloadURL();
          imageUrl = urls;
          debugPrint("New URL:$urls");
        }
        var url = Uri.http(ipaddress, "finalyearproject_api/addCategory.php");
        var response = await http.post(url, body: {
          'token': prefs.getString('token'),
          'category_name': categoryController.text,
          'category_image': imageUrl ?? "",
        });
        var result = jsonDecode(response.body);
        if (result['success']) {
          categoryController.clear();
          image = null;
          imagebytes = Uint8List(0);
          await Get.find<UserDetailController>().getCategory();
          Get.back();
          update();
          Get.showSnackbar(GetSnackBar(
            backgroundColor: Colors.green,
            message: result['message'],
            duration: const Duration(seconds: 3),
          ));
        } else {
          Get.showSnackbar(GetSnackBar(
            backgroundColor: Colors.red,
            message: result['message'],
            duration: const Duration(seconds: 3),
          ));
        }
      } else {
        Get.showSnackbar(const GetSnackBar(
          backgroundColor: Colors.red,
          message: "Enter Category Title",
          duration: Duration(seconds: 3),
        ));
      }
    } catch (e) {
      addingCategoryLoading.value = false;
    } finally {
      addingCategoryLoading.value = false;
    }
  }

  void addProduct() async {
    try {
      if (productFormKey.currentState!.validate()) {
        var url = Uri.http(ipaddress, "finalyearproject_api/addCourses.php");
        var form = http.MultipartRequest('POST', url);

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
          isAdded.value = true;
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

  void increment() => count.value++;
}
