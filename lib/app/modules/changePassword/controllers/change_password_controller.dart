import 'dart:convert';

import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordController extends GetxController {
  //TODO: Implement ChangePasswordController
  GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
  TextEditingController oldpasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController reNewPasswordController = TextEditingController();
  RxBool isLoading = false.obs;
  SharedPreferences? prefs;
  final count = 0.obs;
  @override
  Future<void> onInit() async {
    prefs = await SharedPreferences.getInstance();
    super.onInit();
  }

  Future<void> onChangePassword() async {
    isLoading.value = true;
    if (passwordKey.currentState!.validate()) {
      try {
        var url =
            Uri.http(ipaddress, "finalyearproject_api/changePassword.php");
        var response = await http.post(url, body: {
          'token': prefs!.getString('token')!,
          'password': oldpasswordController.text,
          'new_password': newPasswordController.text,
        });

        var data = jsonDecode(response.body);

        Get.back();
        Get.showSnackbar(GetSnackBar(
          message: data['message'],
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 3),
        ));
        update();
      } catch (e) {
        Get.showSnackbar(GetSnackBar(
          message: "Something went wrong hai:$e",
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ));
      }
    }
    isLoading.value = false;
  }

  void increment() => count.value++;
}
