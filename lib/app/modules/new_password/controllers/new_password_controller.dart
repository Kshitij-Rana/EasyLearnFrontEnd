import 'dart:convert';

import 'package:e_learn/app/routes/app_pages.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NewPasswordController extends GetxController {
  //TODO: Implement NewPasswordController
  GlobalKey<FormState> newpasswordFormKey = GlobalKey<FormState>();
  TextEditingController newpasswordController = TextEditingController();

  final count = 0.obs;
  SharedPreferences? prefs;
  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
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
  void onNewPasswordclicked() async {
    if (newpasswordFormKey.currentState!.validate()) {
      var url = Uri.http(ipaddress, 'finalyearproject_api/resetPassword.php');
      var response = await http.post(url, body: {
        'new_password': newpasswordController.text,
        'token': prefs!.getString('token'),
      });
      if (response.body.isNotEmpty) {
        var result = jsonDecode(response.body);
        if (result['success']) {
          Get.showSnackbar(GetSnackBar(
            backgroundColor: Colors.green,
            message: result['message'],
            duration: const Duration(seconds: 3),
          ));
          Get.toNamed(Routes.LOGIN);
        } else {
          Get.showSnackbar(GetSnackBar(
            backgroundColor: Colors.red,
            message: result['message'],
            duration: const Duration(seconds: 3),
          ));
        }
      }
    }
  }
}
