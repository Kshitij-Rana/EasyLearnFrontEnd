import 'dart:convert';

import 'package:e_learn/app/routes/app_pages.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ForgetPasswordController extends GetxController {
  var forgotPasswordKey = GlobalKey<FormState>();
  TextEditingController forgotEmailController = TextEditingController();
  var isLoading = false.obs;
  final count = 0.obs;

  void increment() => count.value++;
  void onFindProfileClicked() async {
    isLoading.value = true;
    if (forgotPasswordKey.currentState!.validate()) {
      try {
        var url =
            Uri.http(ipaddress, 'finalyearproject_api/forrgetPassword.php');
        var response =
            await http.post(url, body: {'email': forgotEmailController.text});
        var result = jsonDecode(response.body);

        if (result['success']) {
          Get.toNamed(Routes.OTP);
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
      } catch (e) {
        Get.showSnackbar(const GetSnackBar(
          backgroundColor: Colors.red,
          message: "Something went worng in api",
          duration: Duration(seconds: 3),
        ));
      }
    }

    isLoading.value = false;
  }
}
