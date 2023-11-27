import 'package:e_learn/app/utils/Assets.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/constants.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Widget? icon;
  final bool isOutline;
  final Color? color;
  final bool isDisabled;
  final Function() onPressed;
  final bool isLight;
  final bool isLoading;
  const CustomButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.isOutline = false,
    this.color,
    this.isLight = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: !isTablet() ? 100.w : 70.w,
      height: isTablet() ? 14.w : 6.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.w),
        gradient: (color != null || isOutline || isLight || isDisabled)
            ? null
            : LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  buttonColor.withOpacity(0.9),
                  buttonColor.withOpacity(0.7),
                ],
              ),
        color: isDisabled
            ? secondaryTextColor.withOpacity(0.3)
            : isLight
                ? buttonColor
                : Colors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            color: secondaryTextColor.withOpacity(0.4),
            spreadRadius: 0.5,
            blurRadius: 1,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(2.w),
        child: InkWell(
          borderRadius: BorderRadius.circular(2.w),
          onTap: isDisabled ? null : onPressed,
          splashColor: Colors.white24, // Set splash color to transparent
          highlightColor: backgroundColor.withOpacity(0.3), // Highlight color
          child: Center(
            child: isLoading
                ? CircularProgressIndicator(
                    color: isOutline ? primaryColor : Colors.white,
                    strokeWidth: 0.75.w,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      icon ?? const SizedBox.shrink(),
                      icon == null ? Gap() : Gap(width: 5.w),
                      Text(
                        title,
                        style: TextStyle(
                          color: isOutline ? primaryTextColor : Colors.white,
                          // fontFamily: Assets.jakartaFont,
                          fontSize: isOutline ? 12.5.sp : 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
