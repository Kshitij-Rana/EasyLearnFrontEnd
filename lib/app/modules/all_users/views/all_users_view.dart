import 'package:e_learn/app/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/all_users_controller.dart';

class AllUsersView extends GetView<AllUsersController> {
  const AllUsersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(AllUsersController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          title: const Text(
            'All Users',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Obx(
          () => ListView.builder(
            itemCount: controller.allUsers.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.w),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.allUsers[index].fullName ?? '',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 1.w),
                      Text(
                        controller.allUsers[index].email ?? '',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      // SizedBox(height: 10),
                      // Text(
                      //   'Role: ${controller.allUsers[index].userRole ?? 'Not set'}',
                      //   style: TextStyle(fontSize: 16),
                      // ),
                      // SizedBox(height: 10),
                      // controller.allUsers[index].address == ""
                      //     ? Text(
                      //         'Address: Unknown',
                      //         style: TextStyle(fontSize: 16),
                      //       )
                      //     : Text(
                      //         'Address: ${controller.allUsers[index].address ?? 'Unknown'}',
                      //         style: TextStyle(fontSize: 16),
                      //       ),
                      // SizedBox(height: 10),
                      // controller.allUsers[index].bio == ""
                      //     ? Text(
                      //         'Bio:  No bio yet',
                      //         style: TextStyle(fontSize: 16),
                      //       )
                      //     : Text(
                      //         'Bio: ${controller.allUsers[index].bio ?? 'No bio yet'}',
                      //         style: TextStyle(fontSize: 16),
                      //       ),
                      Obx(
                        () => controller.allUsers[index].isBlocked == '1'
                            ? GestureDetector(
                                onTap: () {
                                  controller.blockAndUnblockUser(
                                      controller.allUsers[index].userID ?? '',
                                      controller.allUsers[index].isBlocked ??
                                          '',
                                      "User unblocked");
                                },
                                child: const Icon(
                                  Icons.toggle_off_rounded,
                                  color: Colors.red,
                                  size: 30,
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  controller.blockAndUnblockUser(
                                      controller.allUsers[index].userID ?? '',
                                      controller.allUsers[index].isBlocked ??
                                          '',
                                      "User Blocked");
                                },
                                child: Icon(
                                  Icons.toggle_off_rounded,
                                  color: Colors.green,
                                  size: 30,
                                ),
                              ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
