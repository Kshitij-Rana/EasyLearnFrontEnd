import 'dart:convert';

import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignupController extends GetxController {
  var signUpKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  var dropDownValue_role;

  //TODO: Implement SignupController

  final count = 0.obs;

  void signup() async {
    if (signUpKey.currentState!.validate()) {
      try {
        var url = Uri.http(ipaddress, 'finalyearproject_api/auth/register.php');
        var response = await http.post(url, body: {
          'full_name': nameController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'role': dropDownValue_role,
        });

        var result = jsonDecode(response.body);
        if (result['success']) {
          Get.back();
          Get.showSnackbar(GetSnackBar(
              backgroundColor: Colors.green,
              message: result['message'],
              duration: const Duration(seconds: 3)));
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
          message: "Error in data",
          duration: Duration(seconds: 3),
        ));
      }
    }
  }

  void increment() => count.value++;
}
