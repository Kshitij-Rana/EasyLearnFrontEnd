import 'package:e_learn/app/controller/user_detail_controller.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/app/views/myCourses.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/my_learning_controller.dart';

class MyLearningView extends GetView<MyLearningController> {
  const MyLearningView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(UserDetailController);
    var userdetailController = Get.find<UserDetailController>();

    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('My COurses'),
        //   centerTitle: true,
        // ),
        appBar: AppBar(
          backgroundColor: backgroundColor,
          title: const Text(
            'My courses',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 95.w,
                    height: 168.w,
                    child: Obx(
                      () => ListView.builder(
                        itemCount:
                            userdetailController.paidCourses?.length ?? 0,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return MyCourses(
                            paidCourse:
                                userdetailController.paidCourses![index],
                            isPaidCourses: true,
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
