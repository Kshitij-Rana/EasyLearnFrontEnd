import 'package:e_learn/app/controller/user_detail_controller.dart';
import 'package:e_learn/app/customs/custom_body.dart';
import 'package:e_learn/app/routes/app_pages.dart';
import 'package:e_learn/app/utils/Assets.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/components/constants.dart';
import 'package:e_learn/components/delete_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Get.put(UserDetailController);
    var usercontroller = Get.find<UserDetailController>();

    Get.put(ProfileController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          title: const Text(
            'My Profile',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: customBody(
          child: Obx(
            () => Column(
              children: [
                usercontroller.profilePic.value == ''
                    ? CircleAvatar(
                        maxRadius: 22.w,
                        backgroundColor: Colors.grey.withOpacity(0.4),
                        backgroundImage:
                            const AssetImage('assets/images/profile.jpeg'),
                      )
                    : CircleAvatar(
                        maxRadius: 22.w,
                        backgroundColor: Colors.grey.withOpacity(0.4),
                        backgroundImage: NetworkImage(
                            getImageUrl(usercontroller.profilePic.value)),
                      ),
                Gap(height: 7.w),
                AccountButton(
                    title: "Personal Information",
                    onpressed: () {
                      Get.toNamed(Routes.PERSONAL_INFORMATION);
                    },
                    iconFront: Icons.person),
                Gap(height: 3.w),
                // AccountButton(
                //     title: "Want to be a tutor?",
                //     onpressed: () {},
                //     iconFront: Icons.person_add_alt_rounded),
                // Gap(height: 3.w),
                AccountButton(
                    title: "Change Password",
                    onpressed: () {
                      Get.toNamed(Routes.CHANGE_PASSWORD);
                    },
                    iconFront: Icons.password_sharp),
                Gap(height: 3.w),
                AccountButton(
                  title: "Log Out",
                  iconFront: Icons.logout_rounded,
                  onpressed: () {
                    showCupertinoDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) {
                        return DeleteModal(
                          isLogout: true,
                          question: "Are you sure you want to Log Out?",
                          deleteFunction: () {
                            controller.onLogOut();
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
