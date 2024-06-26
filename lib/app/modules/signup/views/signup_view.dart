import 'package:e_learn/app/customs/customTextField.dart';
import 'package:e_learn/app/customs/custom_body.dart';
import 'package:e_learn/app/customs/custom_button.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          body: customBody(
              isScrollable: true,
              child: Form(
                key: controller.signUpKey,
                child: Column(
                  children: [
                    Gap(height: 7.h),
                    Text(
                      "Sign Up",
                      style: TextStyle(
                          color: buttonColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    Gap(height: 4.w),

                    CustomTextField(
                      hintText: "Full name",
                      controller: controller.nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter your first name";
                        }
                        return null;
                      },
                    ),
                    Gap(height: 4.w),

                    CustomTextField(
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
                    Gap(height: 4.w),
                    // CustomTextField(
                    //     hintText: "role",
                    //     controller: controller.roleController),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Role",
                        labelStyle: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                        prefixIcon: Icon(Icons.person,
                            color: Colors.black.withOpacity(0.5)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide(
                                width: 2,
                                color: Colors.black.withOpacity(0.25))),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: const BorderSide(
                                width: 2, color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide: BorderSide(
                                width: 2, color: Colors.grey.shade400)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                            borderSide:
                                const BorderSide(width: 2, color: Colors.red)),
                      ),
                      items: const [
                        DropdownMenuItem(value: "admin", child: Text("Admin")),
                        DropdownMenuItem(value: "user", child: Text("User"))
                      ],
                      value: controller.dropDownValue_role,
                      onChanged: (value) =>
                          controller.dropDownValue_role = value as String,
                      validator: (value) {
                        if (value == null) {
                          return "Select your role";
                        }
                        return null;
                      },
                      dropdownColor: Colors
                          .white, // Set the dropdown background color to white
                    ),

                    Gap(height: 4.w),

                    CustomTextField(
                      isPassword: true,
                      hintText: "Password",
                      controller: controller.passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter password";
                        } else if (value.length < 8) {
                          return "Password must have at least 8 characters";
                        }
                        return null;
                      },
                    ),
                    Gap(height: 4.w),

                    CustomTextField(
                      isPassword: true,
                      hintText: "Confirm Password",
                      controller: controller.confirmPasswordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter password";
                        } else if (value.length < 8) {
                          return "Password must have at least 8 characters";
                        } else if (value !=
                            controller.passwordController.text) {
                          return "Password didn't match the above password";
                        }
                        return null;
                      },
                    ),
                    Gap(height: 3.h),
                    CustomButton(
                      title: "Sign Up",
                      onPressed: () {
                        controller.signup();
                      },
                    ),
                    Gap(height: 7.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an Account? ",
                            style: TextStyle(
                                color: primaryTextColor, fontSize: 13.5.sp)),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Text("Log In",
                              style: TextStyle(
                                  color: buttonColor,
                                  fontSize: 13.5.sp,
                                  fontWeight: FontWeight.w500)),
                        )
                      ],
                    )
                  ],
                ),
              ))),
    );
  }
}
