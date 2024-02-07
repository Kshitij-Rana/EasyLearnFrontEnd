import 'dart:convert';

import 'package:e_learn/app/modules/forgetPassword/controllers/forget_password_controller.dart';
import 'package:e_learn/app/routes/app_pages.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OtpController extends GetxController {
  //TODO: Implement OtpController
  var forgetPasswordcontroller = Get.find<ForgetPasswordController>();

  GlobalKey<FormState> otpformkey = GlobalKey<FormState>();
  TextEditingController otpcontroller = TextEditingController();
  FocusNode focusNode = FocusNode();
  SharedPreferences? prefs;
  var isLoading = false.obs;
  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    otpcontroller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void onOTPClicked() async {
    isLoading.value = true;
    if (otpformkey.currentState!.validate()) {
      var url = Uri.http(ipaddress, 'finalyearproject_api/otpVerify.php');
      var response = await http.post(url, body: {
        'otp': otpcontroller.text,
        'email': forgetPasswordcontroller.forgotEmailController.text
      });
      print(otpcontroller.text);
      print(forgetPasswordcontroller.forgotEmailController.text);
      print(response.body);
      if (response.body.isNotEmpty) {
        var result = jsonDecode(response.body);

        if (result['success']) {
          print(result['userId']);
          await prefs!.setString('userId', result['userId']);
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
        duration: Duration(seconds: 3),
      ));
    }
    isLoading.value = false;
  }

  void increment() => count.value++;
}
