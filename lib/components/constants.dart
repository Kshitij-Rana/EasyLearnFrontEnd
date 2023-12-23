import 'package:flutter/material.dart';
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
