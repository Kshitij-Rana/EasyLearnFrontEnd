import 'package:e_learn/app/customs/custom_body.dart';
import 'package:e_learn/app/views/myCourses.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/my_learning_controller.dart';

class MyLearningView extends GetView<MyLearningController> {
  const MyLearningView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('My COurses'),
        //   centerTitle: true,
        // ),
        body: SafeArea(
      child: Column(
        children: [
          Center(
            child: Text(
              "My Courses",
              style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500),
            ),
          ),
          customBody(
            child: Column(
              children: [
                SizedBox(
                  width: 95.w,
                  height: 70.h,
                  child: ListView.builder(
                    itemCount: 4,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return MyCourses();
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
