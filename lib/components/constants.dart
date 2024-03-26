import 'package:e_learn/app/controller/user_detail_controller.dart';
import 'package:e_learn/app/models/category.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

var ipaddress = '192.168.1.70';
bool isTablet() {
  if (SizerUtil.deviceType == DeviceType.mobile) {
    return false;
  } else {
    return true;
  }
}

var getImageUrl = (images) {
  return 'http://$ipaddress/finalyearproject_api/$images';
};

// ignore: non_constant_identifier_names
Gap({double? width, double? height}) => SizedBox(
      width: width,
      height: height,
    );
String formatTime(String time) {
  List<String> parts = time.split(':');
  if (parts[0] == '00') {
    return '${parts[1]}:${parts[2]}'; // Return only minutes and seconds
  } else {
    return time; // Return the full time
  }
}

// String getCategoryName(int categoryid) {
//   var categories = Get.find<UserDetailController>().category;
//   print(categories);
//   Categories category = categories.firstWhere(
//     (element) => element.categoryId == categoryid,
//   );
//   return category.categoryName ?? '';
// }
String getCategoryName(int categoryId) {
  var categories = Get.find<UserDetailController>().category;
  Categories? category = categories.firstWhere(
    (element) => element.categoryId == categoryId.toString(),
  );
  return category.categoryName ??
      ''; // Use the null-aware operator to handle nulls
}
