import 'package:e_learn/app/customs/customTextField.dart';
import 'package:e_learn/app/customs/custom_body.dart';
import 'package:e_learn/app/customs/custom_button.dart';
import 'package:e_learn/app/routes/app_pages.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          // backgroundColor: secondaryColor,
          body: Form(
        key: controller.loginKey,
        child: customBody(
          isScrollable: true,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Log In",
                style: TextStyle(fontSize: 5.h, fontWeight: FontWeight.w500),
              ),
              CustomTextField(
                title: "Email",
                hintText: "Email",
                controller: controller.emailController,
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
              CustomTextField(
                title: "Password",
                isPassword: true,
                hintText: "Password",
                controller: controller.passController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter password";
                  }
                  // else if (value.length < 8) {
                  //   return "Password must have at least 8 characters";
                  // }
                  return null;
                },
              ),
              Gap(height: 4.h),
              CustomButton(
                title: "Log In",
                onPressed: () {
                  controller.login();
                },
              ),
              Gap(height: 2.h),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.FORGET_PASSWORD);
                },
                child: Text(
                  "Forgot the password?",
                  style: TextStyle(color: buttonColor, fontSize: 13.5.sp),
                ),
              ),
              Gap(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an Account? ",
                      style: TextStyle(
                          color: primaryTextColor, fontSize: 13.5.sp)),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.SIGNUP);
                    },
                    child: Text("Sign Up",
                        style: TextStyle(
                            color: buttonColor,
                            fontSize: 13.5.sp,
                            fontWeight: FontWeight.w500)),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
