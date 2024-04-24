import 'package:e_learn/app/customs/customTextField.dart';
import 'package:e_learn/app/customs/custom_body.dart';
import 'package:e_learn/app/customs/custom_button.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Change Password'),
          centerTitle: true,
        ),
        body: customBody(
            child: Form(
          key: controller.passwordKey,
          child: Column(
            children: [
              CustomTextField(
                  title: "Old Password",
                  isPassword: true,
                  hintText: "Old password",
                  controller: controller.oldpasswordController),
              Gap(height: 3.w),
              CustomTextField(
                title: "New Password",
                isPassword: true,
                hintText: "New password",
                controller: controller.newPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter password";
                  } else if (value.length < 8) {
                    return "Password must have at least 8 characters";
                  }
                  return null;
                },
              ),
              Gap(height: 3.w),
              CustomTextField(
                title: "Confirm Password",
                isPassword: true,
                hintText: "Confirm password",
                controller: controller.reNewPasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter password";
                  } else if (value.length < 8) {
                    return "Password must have at least 8 characters";
                  } else if (value != controller.newPasswordController.text) {
                    return "Password didn't match the above password";
                  }
                  return null;
                },
              ),
              Gap(height: 6.w),
              Obx(
                () => CustomButton(
                  isLoading: controller.isLoading.value,
                  title: "Change Password",
                  onPressed: () {
                    controller.onChangePassword();
                  },
                ),
              )
            ],
          ),
        )));
  }
}
