import 'package:e_learn/app/customs/custom_body.dart';
import 'package:e_learn/app/models/courses.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/coursecontent_controller.dart';

class CoursecontentView extends GetView<CoursecontentController> {
  const CoursecontentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var courses = Get.arguments as Courses;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios_new_sharp,
                color: Colors.black,
              )),
          title: Text(
            courses.courseName ?? '',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: customBody(
            isScrollable: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 90.w,
                  height: 55.w,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 206, 205, 205)
                          .withOpacity(1),
                      borderRadius: BorderRadius.circular(13),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 1,
                            color: Colors.grey.withOpacity(0.4),
                            offset: const Offset(1, 2),
                            spreadRadius: 1),
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: Image.network(
                      getImageUrl(courses.image ?? ''),
                      height: 26.w,
                      width: 42.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Gap(height: 5.w),
                controller.isPaid.value == false
                    ? Text(
                        "3. How to unlock mobile phone?",
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.bold),
                      )
                    : SizedBox.shrink(),
                Gap(height: 3.w),
                controller.isPaid.value == false
                    ? Text(
                        "Video Details",
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.bold),
                      )
                    : Text(
                        "Course Details",
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.bold),
                      ),
                Gap(height: 3.w),
                Text(
                  courses.description ?? '',
                  style: TextStyle(
                      fontSize: 12.5.sp,
                      color: Colors.black.withOpacity(0.55),
                      fontWeight: FontWeight.w500),
                ),
                Gap(height: 4.w),
                Text(
                  "Lesson's Content",
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold),
                ),
                Gap(height: 2.w),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => GestureDetector(
                        onTap: () {
                          if (controller.isClicked[index].value == false) {
                            controller.isClicked[index].value = true;
                          } else {
                            controller.isClicked[index].value = false;
                          }
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            margin: EdgeInsets.symmetric(
                                vertical: 2.w, horizontal: 1.w),
                            height: controller.isClicked[index].value == false
                                ? 16.5.w
                                : 25.w,
                            width: Get.width,
                            decoration: BoxDecoration(
                                color: Colors.green.shade100,
                                borderRadius: BorderRadius.circular(7),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 1,
                                      blurStyle: BlurStyle.normal,
                                      color: Colors.grey.withOpacity(0.4),
                                      offset: const Offset(1, 2),
                                      spreadRadius: 1)
                                ]),
                            child: Row(
                              children: [
                                Gap(width: 1.w),
                                Align(
                                  alignment:
                                      controller.isClicked[index].value == true
                                          ? Alignment.topCenter
                                          : Alignment.center,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.play_arrow_rounded,
                                      color: bottomnavigationBarColor,
                                    ),
                                  ),
                                ),
                                Gap(width: 3.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '${(index + 1).toString()}.',
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Gap(width: 1.w),
                                        SizedBox(
                                          width: 65.w,
                                          child: Text(
                                            "Introduction to Information System ho hai",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Gap(height: 1.w),
                                    Text(
                                      "10:20",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.8),
                                          fontSize: 11.sp),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            )));
  }
}
