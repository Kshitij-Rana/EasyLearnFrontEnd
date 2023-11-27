import 'dart:convert';

import 'package:e_learn/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AdminHomeController extends GetxController {
  //TODO: Implement AdminHomeController
  late final SharedPreferences prefs;
  final count = 0.obs;
  var stats;
  @override
  void onInit() async {
    prefs = await SharedPreferences.getInstance();

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

  void getStats() async {
    try {
      var url = Uri.http(ipaddress, 'finalyearproject_api/getStats.php');
      var response =
          await http.post(url, body: {'token': prefs.getString('token')});
      var result = jsonDecode(response.body);

      if (result['success']) {}
    } catch (e) {
      print(e);
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: Duration(seconds: 3),
      ));
    }
  }

  void increment() => count.value++;
}
