import 'package:e_learn/app/utils/Assets.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class CustomButton extends StatefulWidget {
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
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: !isTablet() ? 100.w : 70.w,
      height: isTablet() ? 14.w : 6.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.w),
        gradient: (widget.color != null ||
                widget.isOutline ||
                widget.isLight ||
                widget.isDisabled)
            ? null
            : LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  buttonColor.withOpacity(0.9),
                  buttonColor.withOpacity(0.7),
                ],
              ),
        color: widget.isDisabled
            ? secondaryTextColor.withOpacity(0.3)
            : widget.isLight
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
          onTap: widget.isDisabled ? null : widget.onPressed,
          splashColor: Colors.white24, // Set splash color to transparent
          highlightColor: backgroundColor.withOpacity(0.3), // Highlight color
          child: Center(
            child: widget.isLoading
                ? CircularProgressIndicator(
                    color: widget.isOutline ? primaryColor : Colors.white,
                    strokeWidth: 0.75.w,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      widget.icon ?? const SizedBox.shrink(),
                      widget.icon == null ? Gap() : Gap(width: 5.w),
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: widget.isOutline
                              ? primaryTextColor
                              : Colors.white,
                          // fontFamily: Assets.jakartaFont,
                          fontSize: widget.isOutline ? 12.5.sp : 15.sp,
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
