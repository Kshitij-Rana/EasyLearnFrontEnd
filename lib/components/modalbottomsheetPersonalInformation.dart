import 'package:e_learn/app/modules/personalInformation/controllers/personal_information_controller.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ModalBottomSheet extends StatelessWidget {
  const ModalBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonalInformationController>(
      builder: (controller) => Container(
          padding: EdgeInsets.symmetric(vertical: 2.w, horizontal: 5.w),
          width: 100.w,
          height: 31.5.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3.w),
          ),
          child: Column(
            children: [
              Gap(height: 2.w),
              SizedBox(
                height: 12.w,
                child: TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.grey),
                  onPressed: () {
                    controller.pickImage();
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.photo,
                        color: Colors.black,
                        size: 18.sp,
                      ),
                      Gap(width: 6.w),
                      SizedBox(
                        width: 55.w,
                        child: Text(
                          "Choose from gallery",
                          style: TextStyle(
                              fontSize: 12.sp, color: primaryTextColor),
                        ),
                      ),
                      Gap(width: 6.w),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 12.w,
                child: TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.grey),
                  onPressed: () {
                    controller.pickImageCamera();
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.black,
                        size: 18.sp,
                      ),
                      Gap(width: 6.w),
                      SizedBox(
                        width: 55.w,
                        child: Text(
                          "Take a Photo",
                          style: TextStyle(
                              fontSize: 12.sp, color: primaryTextColor),
                        ),
                      ),
                      Gap(width: 6.w),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
