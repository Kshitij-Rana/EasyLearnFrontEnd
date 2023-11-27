import 'dart:convert';

import 'package:e_learn/app/routes/app_pages.dart';
import 'package:e_learn/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  SharedPreferences? prefs;
  var loginKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

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

  // Future<void> login() async {
  //   if (loginKey.currentState!.validate()) {
  //     try {
  //       var url = Uri.http(ipaddress, 'finalyearproject_api/auth/login.php');
  //       var response = await http.post(url, body: {
  //         'email': emailController.text,
  //         'password': passController.text
  //       });
  //       // print('Response Status Code: ${response.statusCode}');
  //       // print('Response Body: ${response.body}');
  //       // print('Content-Type: ${response.headers['content-type']}');

  //       var result = jsonDecode(response.body);

  //       if (result['success']) {
  //         await prefs.setString('role', result['role']);
  //         await prefs.setString('token', result['token']);

  //         if (result['role'] == 'admin') {
  //           Get.offAllNamed(Routes.ADMIN_MAIN);
  //         } else {
  //           Get.offAllNamed(Routes.HOME);
  //         }

  //         Get.showSnackbar(GetSnackBar(
  //           backgroundColor: Colors.green,
  //           message: result['message'],
  //           duration: const Duration(seconds: 3),
  //         ));
  //       } else {
  //         Get.showSnackbar(GetSnackBar(
  //           backgroundColor: Colors.red,
  //           message: 'Something went wrong',
  //           duration: const Duration(seconds: 3),
  //         ));
  //       }
  //     } catch (e) {
  //       print("Caught exception: $e");
  //       Get.showSnackbar(const GetSnackBar(
  //         backgroundColor: Colors.red,
  //         message: "Gaad fatyo wrong vayo",
  //         duration: Duration(seconds: 3),
  //       ));
  //     }
  //   }
  // }
  Future<void> login() async {
    if (loginKey.currentState!.validate()) {
      try {
        var url = Uri.http(ipaddress, 'finalyearproject_api/auth/login.php');
        print(url);
        var response = await http.post(url, body: {
          'email': emailController.text,
          'password': passController.text
        });
        print(response);
        if (response.statusCode == 200) {
          if (response.body.isNotEmpty) {
            var result = jsonDecode(response.body);
            print(response.body);
            if (result['success']) {
              await prefs!.setString('role', result['role']);
              await prefs!.setString('token', result['token']);

              if (result['role'] == 'admin') {
                Get.offAllNamed(Routes.ADMIN_MAIN);
              } else {
                Get.offAllNamed(Routes.HOME);
              }

              Get.showSnackbar(GetSnackBar(
                backgroundColor: Colors.green,
                message: result['message'],
                duration: const Duration(seconds: 3),
              ));
            } else {
              Get.showSnackbar(GetSnackBar(
                backgroundColor: Colors.red,
                message: 'Something went wrong',
                duration: const Duration(seconds: 3),
              ));
            }
          } else {
            // Handle empty response body
            Get.showSnackbar(GetSnackBar(
              backgroundColor: Colors.red,
              message: 'Empty response body',
              duration: const Duration(seconds: 3),
            ));
          }
        } else {
          // Handle non-200 status code (e.g., server error)
          Get.showSnackbar(GetSnackBar(
            backgroundColor: Colors.red,
            message: 'Server error: ${response.statusCode}',
            duration: const Duration(seconds: 3),
          ));
        }
      } catch (e) {
        // Handle exceptions (e.g., network issues)
        print('Error: $e');
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: 'An error occurred: $e',
          duration: const Duration(seconds: 3),
        ));
      }
    }
  }

  void increment() => count.value++;
}
