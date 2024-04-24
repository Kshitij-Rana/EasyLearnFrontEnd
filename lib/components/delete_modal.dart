import 'package:e_learn/app/controller/user_detail_controller.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class DeleteModal extends StatelessWidget {
  final String question;
  final VoidCallback deleteFunction;
  final bool isLogout;
  const DeleteModal(
      {super.key,
      required this.question,
      required this.deleteFunction,
      this.isLogout = false});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.w)),
      child: GetBuilder<UserDetailController>(
        builder: (controller) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3.w),
          ),
          width: 90.w,
          height: isLogout == true ? 28.w : 34.w,
          child: Padding(
            padding:
                EdgeInsets.only(top: 4.w, bottom: 4.w, left: 5.w, right: 5.w),
            child: Column(
              children: [
                Text(
                  question,
                  style: TextStyle(
                      fontSize: isLogout == true ? 13.sp : 14.sp,
                      // fontFamily: Assets.jakartaFont,
                      fontWeight: FontWeight.w500),
                ),
                Gap(height: 2.w),
                Padding(
                  padding: EdgeInsets.only(
                    left: isTablet() ? 8.w : 4.w,
                    right: isTablet() ? 8.w : 4.w,
                    top: isTablet() ? 8.w : 4.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              color: primaryTextColor,
                              fontSize: 11.5.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          // controller.onDeleteDownloadedFile(
                          //     controller.downloadPaths[index], index);
                          deleteFunction();
                          // Get.back();
                        },
                        child: Text(
                          isLogout == true ? "Log Out" : "Delete",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 11.5.sp,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
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
