import 'dart:convert';

import 'package:e_learn/app/routes/app_pages.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ForgetPasswordController extends GetxController {
  var forgotPasswordKey = GlobalKey<FormState>();
  TextEditingController forgotEmailController = TextEditingController();
  //TODO: Implement ForgetPasswordController

  final count = 0.obs;
  @override
  void onInit() {
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

  void increment() => count.value++;
  void onFindProfileClicked() async {
    var url = Uri.http(ipaddress, 'finalyearproject_api/forgotPassword.php');
    var response =
        await http.post(url, body: {'email': forgotEmailController.text});
    if (response.body.isNotEmpty) {
      var result = jsonDecode(response.body);
      Get.toNamed(Routes.OTP);
      Get.showSnackbar(GetSnackBar(
        backgroundColor: Colors.green,
        message: result['message'],
        duration: const Duration(seconds: 3),
      ));
    }
  }
}
