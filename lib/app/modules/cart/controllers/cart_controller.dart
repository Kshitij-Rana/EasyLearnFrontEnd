import 'dart:convert';

import 'package:e_learn/app/models/courses.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CartController extends GetxController {
  //TODO: Implement CartController
  late final SharedPreferences? prefs;

  List<CartItem> cart = [];
  var total = 0.0.obs;

  String? getMyCart() {
    return prefs != null ? prefs!.getString('cart') : null;
  }

  void setMyCart(String cart) {
    prefs!.setString('cart', cart);
  }

  void addCoursesTocart({required Courses course, int? quantity}) {
    if (cart.any((element) => element.course.courseId == course.courseId)) {
      Get.showSnackbar(GetSnackBar(
        message: "This course is already added to the cart!",
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ));
      return;
    }
    cart.add(CartItem(course: course));
    updateTotal();
    updateLocal();
    update();
    Get.showSnackbar(const GetSnackBar(
      backgroundColor: Colors.green,
      message: "Course has been added to the cart",
      duration: Duration(seconds: 2),
    ));
  }

  void mapCart() {
    var cart = jsonDecode(getMyCart() ?? '[]') as List<dynamic>;
    this.cart = cart
        .map((e) => CartItem(course: Courses.fromJson(e['course'])))
        .toList();
    updateLocal();
    update();
  }

  void updateTotal() {
    total.value = 0;
    cart.forEach((element) {
      total.value = total.value + double.parse(element.course.price!);
    });
  }

  void updateLocal() {
    setMyCart(jsonEncode(cart
        .map((e) => {
              'course': e.course.toJson(),
            })
        .toList()));
  }

  final count = 0.obs;
  @override
  void onInit() async {
    prefs = await SharedPreferences.getInstance();
    super.onInit();
    mapCart();

    updateTotal();
    updateLocal();
  }

  void removeProduct(int index) async {
    await cart.removeAt(index);
    updateLocal();
    updateTotal();
    update();
  }

  Future<int?> makeOrder() async {
    try {
      var url = Uri.http(ipaddress, 'finalyearproject_api/createOrder.php');
      var response = await http.post(url, body: {
        'token': prefs != null ? prefs!.getString('token') : null,
        'total': total.value.toString(),
        'cart': getMyCart(),
      });
      print(getMyCart());

      var result = jsonDecode(response.body);
      print(result);
      if (result['success']) {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.green,
          message: result['message'],
          duration: Duration(seconds: 3),
        ));
        return result['order_id'];
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      print(e);
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: 'Something went wrong',
        duration: Duration(seconds: 3),
      ));
    }
    return null;
  }

  Future<void> makePayment(
      {required String amount,
      required String orderId,
      required String otherData}) async {
    try {
      var url = Uri.http(ipaddress, 'finalyearproject_api/payment.php');
      var response = await http.post(url, body: {
        'token': prefs != null ? prefs!.getString('token') : null,
        'amount': amount,
        'order_id': orderId,
        'other_data': otherData,
      });

      var result = jsonDecode(response.body);
      print(result['message']);
      if (result['success']) {
        cart.clear();
        setMyCart('[]');
        updateTotal();
        Get.showSnackbar(GetSnackBar(
          message: result['message'],
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.green,
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
        message: 'Something went wrong',
        duration: Duration(seconds: 3),
      ));
    }
    return;
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
}

class CartItem {
  final Courses course;
  CartItem({required this.course});
}
