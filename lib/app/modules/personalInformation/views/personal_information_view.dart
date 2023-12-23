import 'package:e_learn/app/customs/customTextField.dart';
import 'package:e_learn/app/customs/custom_body.dart';
import 'package:e_learn/app/customs/custom_button.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/components/constants.dart';
import 'package:e_learn/components/modalbottomsheetPersonalInformation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/personal_information_controller.dart';

class PersonalInformationView extends GetView<PersonalInformationController> {
  const PersonalInformationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: buttonColor.withOpacity(0.8),
          title: const Text(
            'Personal Information',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.white,
                size: 16.sp,
              )),
        ),
        body: GetBuilder<PersonalInformationController>(
          builder: (controller) => customBody(
            isScrollable: true,
            child: Form(
              key: controller.personalInformationKey,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                context: context,
                                builder: (context) => const ModalBottomSheet());
                          },
                          child: controller.imagebytes.isEmpty
                              ? CircleAvatar(
                                  maxRadius: 95,
                                  backgroundColor: Colors.grey.shade400,
                                  child: const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      maxRadius: 90,
                                      backgroundImage: AssetImage(
                                          'assets/images/profile.jpeg')),
                                )
                              : CircleAvatar(
                                  maxRadius: 95,
                                  backgroundColor: buttonColor.withOpacity(0.5),
                                  child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      maxRadius: 90,
                                      backgroundImage:
                                          MemoryImage(controller.imagebytes)),
                                ),
                        ),
                      ),
                      Positioned(
                          bottom: 10,
                          right: 26.w,
                          child: CircleAvatar(
                              backgroundColor: controller.imagebytes.isEmpty
                                  ? Colors.grey.shade400
                                  : Colors.deepPurple.shade300,
                              child: Icon(
                                Icons.camera_alt,
                                color: controller.imagebytes.isEmpty
                                    ? Colors.black
                                    : Colors.white,
                                size: 19.sp,
                              ))),
                    ],
                  ),
                  Gap(height: 3.w),
                  CustomTextField(
                    title: "Your Name",
                    textInputAction: TextInputAction.next,
                    hintText: "Name",
                    controller: controller.nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
                  Gap(height: 3.w),
                  CustomTextField(
                    title: "Your Email",
                    textInputAction: TextInputAction.next,
                    hintText: "Ex.xyz@gmail.com",
                    controller: controller.emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      } else if (!value.isEmail) {
                        return "Email is not valid";
                      }
                      return null;
                    },
                  ),
                  Gap(height: 3.w),
                  CustomTextField(
                    title: "Address",
                    textInputAction: TextInputAction.next,
                    hintText: "Damauli,Tanahun",
                    controller: controller.addressController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your address";
                      }
                      return null;
                    },
                  ),
                  Gap(height: 3.w),
                  CustomTextField(
                    isMultiline: true,
                    title: "Bio",
                    textInputAction: TextInputAction.next,
                    hintText: "Introduction",
                    controller: controller.bioController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your Bio";
                      }
                      return null;
                    },
                  ),
                  Gap(height: 3.w),
                  CustomButton(
                    title: "Save",
                    onPressed: () {
                      controller.onSaveInformation();
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
