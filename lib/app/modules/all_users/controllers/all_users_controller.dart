import 'dart:convert';

import 'package:e_learn/app/controller/user_detail_controller.dart';
import 'package:e_learn/app/models/allUsers.dart';
import 'package:e_learn/app/models/personalInfo.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AllUsersController extends GetxController {
  //TODO: Implement AllUsersController
  SharedPreferences? prefs;
  RxList<Allusers> allUsers = RxList<Allusers>([]);
  final count = 0.obs;
  @override
  Future<void> onInit() async {
    prefs = await SharedPreferences.getInstance();
    await getUserInfo();
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

  Future<void> getUserInfo() async {
    try {
      var url = Uri.http(ipaddress, 'finalyearproject_api/getAllUsers.php');
      var response =
          await http.post(url, body: {'token': prefs!.getString('token')});
      var result = jsonDecode(response.body);
      if (result['success']) {
        // Get.showSnackbar(GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: result['message'],
        //     duration: const Duration(seconds: 3)));
        allUsers.value = allusersFromJson(jsonEncode(result['data']));
        update();
      }
    } catch (e) {
      print(e);
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong in userInfo fetch',
        duration: Duration(seconds: 3),
      ));
    }
  }

  Future<void> blockAndUnblockUser(
      String userId, String isBlocked, String message) async {
    var url = Uri.http(ipaddress, "finalyearproject_api/auth/blockUser.php");
    var response = await http.post(url, body: {
      'token': prefs!.getString('token'),
      'isBlocked': isBlocked,
      'userID': userId
    });

    var data = jsonDecode(response.body);
    if (data['success']) {
      getUserInfo();
      Get.back();
      Get.showSnackbar(GetSnackBar(
        message: message,
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ));
    } else {
      Get.showSnackbar(GetSnackBar(
        message: data['message'],
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ));
    }
  }

  void increment() => count.value++;
}
