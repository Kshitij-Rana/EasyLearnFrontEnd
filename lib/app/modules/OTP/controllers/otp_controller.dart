import 'dart:convert';

import 'package:e_learn/app/routes/app_pages.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OtpController extends GetxController {
  //TODO: Implement OtpController
  GlobalKey<FormState> otpformkey = GlobalKey<FormState>();
  TextEditingController otpcontroller = TextEditingController();
  SharedPreferences? prefs;
  final count = 0.obs;
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

  void onOTPClicked() async {
    if (otpformkey.currentState!.validate()) {
      var url = Uri.http(ipaddress, 'finalyearproject_api/otpVerify.php');
      var response = await http.post(url, body: {'otp': otpcontroller.text});
      if (response.body.isNotEmpty) {
        var result = jsonDecode(response.body);
        if (result['success']) {
          await prefs!.setString('token', result['token']);
          Get.showSnackbar(GetSnackBar(
            backgroundColor: Colors.green,
            message: result['message'],
            duration: const Duration(seconds: 3),
          ));
          Get.toNamed(Routes.NEW_PASSWORD);
        } else {
          Get.showSnackbar(GetSnackBar(
            backgroundColor: Colors.red,
            message: result['message'],
            duration: const Duration(seconds: 3),
          ));
        }
      }
    } else {
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Enter your OTP',
        duration: const Duration(seconds: 3),
      ));
    }
  }

  void increment() => count.value++;
}
