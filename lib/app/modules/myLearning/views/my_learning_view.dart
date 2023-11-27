import 'package:e_learn/app/customs/custom_body.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:progress_indicator/progress_indicator.dart';
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
          Gap(height: 6.w),
          SizedBox(
            width: 95.w,
            height: 80.h,
            child: ListView.builder(
              itemCount: 4,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Card(
                  shadowColor: Colors.grey,
                  color: Colors.white,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Row(
                      children: [
                        Container(
                          height: 20.w,
                          width: 30.w,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        Gap(width: 3.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Courses Title ho hai yo chai",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black.withOpacity(0.8)),
                            ),
                            Gap(height: 0.5.w),
                            Text(
                              "Category",
                              style: TextStyle(
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.7)),
                            ),
                            Gap(height: 0.5.w),
                            Text(
                              "Instructor name",
                              style: TextStyle(
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.75)),
                            ),
                            Gap(height: 3.w),
                            Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child: SizedBox(
                                width: 48.w,
                                height: 1.w,
                                child: BarProgress(
                                  percentage: 50.0,
                                  backColor: Colors.grey.withOpacity(0.4),
                                  gradient: LinearGradient(colors: [
                                    bottomnavigationBarColor,
                                    bottomnavigationBarColor
                                  ]),
                                  showPercentage: true,
                                  textStyle: TextStyle(
                                      color: Colors.orange, fontSize: 0),
                                  stroke: 3,
                                  round: true,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    ));
  }
}
