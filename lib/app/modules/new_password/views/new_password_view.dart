import 'package:e_learn/app/customs/customTextField.dart';
import 'package:e_learn/app/customs/custom_body.dart';
import 'package:e_learn/app/customs/custom_button.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  const NewPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        centerTitle: true,
      ),
      body: customBody(
        child: Form(
          key: controller.newpasswordFormKey,
          child: Column(
            children: [
              CustomTextField(
                isPassword: true,
                hintText: "New Password",
                controller: controller.newpasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter password";
                  } else if (value.length < 8) {
                    return "Password must have at least 8 characters";
                  }
                  return null;
                },
              ),
              CustomTextField(
                isPassword: true,
                hintText: "Confirm Password",
                controller: controller.confirmpasswordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter password";
                  } else if (value.length < 8) {
                    return "Password must have at least 8 characters";
                  } else if (value != controller.newpasswordController.text) {
                    return "Password didn't match the above password";
                  }
                  return null;
                },
              ),
              Gap(height: 3.w),
              SizedBox(
                width: 49.w,
                child: CustomButton(
                  title: "Change Password",
                  onPressed: () {
                    controller.onNewPasswordclicked();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
