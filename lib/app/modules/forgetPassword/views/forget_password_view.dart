import 'package:e_learn/app/customs/customTextField.dart';
import 'package:e_learn/app/customs/custom_body.dart';
import 'package:e_learn/app/customs/custom_button.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/forget_password_controller.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  const ForgetPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Forgot password"),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          body: customBody(
              child: Form(
            key: controller.forgotPasswordKey,
            child: Column(
              children: [
                Gap(height: 25.h),
                CustomTextField(
                  hintText: "Enter your Email",
                  controller: controller.forgotEmailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter your Email";
                    } else if (!value.isEmail) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),
                Gap(height: 3.h),
                SizedBox(
                  width: 230.sp,
                  child: Obx(
                    () => CustomButton(
                      isLoading: controller.isLoading.value,
                      title: "Find your profile",
                      onPressed: () {
                        controller.onFindProfileClicked();
                      },
                    ),
                  ),
                )
              ],
            ),
          ))),
    );
  }
}
