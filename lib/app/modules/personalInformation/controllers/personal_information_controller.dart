import 'dart:convert';
import 'dart:typed_data';

import 'package:e_learn/app/controller/user_detail_controller.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInformationController extends GetxController {
  //TODO: Implement PersonalInformationController
  GlobalKey<FormState> personalInformationKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  XFile? image;
  final ImagePicker picker = ImagePicker();
  var imagebytes = Uint8List(0).obs;
  RxBool isFetched = false.obs;
  RxString url = ''.obs;
  //for sharedPreferences
  late final SharedPreferences prefs;

  final count = 0.obs;
  @override
  void onInit() async {
    prefs = await SharedPreferences.getInstance();
    try {
      var userController = Get.find<UserDetailController>();
      nameController.text = userController.userInfo?.fullName ?? '';
      emailController.text = userController.userInfo?.email ?? '';
      addressController.text = userController.userInfo?.address ?? '';
      bioController.text = userController.userInfo?.bio ?? '';
      url.value = userController.userInfo?.profileImg ?? '';
    } catch (e) {
      debugPrint("Error:$e");
    }

    super.onInit();
  }

  void pickImage() async {
    try {
      image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        Get.back();
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

  void pickImageCamera() async {
    try {
      image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        imagebytes.value = await image!.readAsBytes();
        update();
        Get.back();
      }
    } catch (e) {
      Get.showSnackbar(
        const GetSnackBar(
          message: "Image upload failed",
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void onSaveInformation() async {
    try {
      if (personalInformationKey.currentState!.validate()) {
        var url =
            Uri.http(ipaddress, "finalyearproject_api/updateuserInfo.php");
        var form = http.MultipartRequest('POST', url);

        form.fields['token'] = prefs.getString('token')!;
        form.fields['fullName'] = nameController.text;
        form.fields['email'] = emailController.text;
        form.fields['address'] = addressController.text;
        form.fields['bio'] = bioController.text;

        form.files.add(http.MultipartFile.fromBytes('image', imagebytes.value,
            filename: image!.name));
        var response = await http.Response.fromStream(await form.send());
        var result = jsonDecode(response.body);

        if (result['success']) {
          Get.find<UserDetailController>().getUserInfo();
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
          message: 'Enter all the fields!',
          duration: Duration(seconds: 3),
        ));
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: Duration(seconds: 3),
      ));
    }
  }

  void increment() => count.value++;
}
