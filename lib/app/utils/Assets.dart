import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

class Assets {
  static const openEye = 'assets/svg/eye.svg';
  static const closeEye = 'assets/svg/eye_slash.svg';
  static const calenderIcon = 'assets/svg/calender_icon.svg';
  static const profileBackground = 'assets/images/profile.png';
}

class AccountButton extends StatelessWidget {
  final Color? containerColor;
  final Color? textColor;
  final String title;
  final IconData iconFront;
  final Function() onpressed;
  const AccountButton(
      {super.key,
      this.containerColor,
      required this.title,
      required this.onpressed,
      required this.iconFront,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        padding: EdgeInsets.only(
          left: 5.w,
        ),
        width: Get.width,
        height: 13.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.w),
          color: containerColor ?? Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 1,
              color: secondaryTextColor.withOpacity(0.1),
              spreadRadius: 0.5,
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey.withOpacity(0.2),
              child: Icon(
                iconFront,
                color: buttonColor,
                size: 18.sp,
              ),
            ),
            Gap(width: 6.w),
            SizedBox(
              width: 55.w,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: textColor ?? primaryTextColor,
                ),
              ),
            ),
            Gap(width: 6.w),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: buttonColor,
            ),
          ],
        ),
      ),
    );
  }
}
