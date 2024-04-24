import 'package:e_learn/app/customs/custom_body.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/app/views/categoryCourseCard.dart';
import 'package:e_learn/app/views/course_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/detailed_category_courses_controller.dart';

class DetailedCategoryCoursesView
    extends GetView<DetailedCategoryCoursesController> {
  const DetailedCategoryCoursesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
            controller.category.categoryName ?? '',
            style: const TextStyle(color: Colors.black),
          ),
        ),
        body: Obx(
          () => controller.filteredCourses?.length == 0
              ? const Center(
                  child: Text(
                  'No Courses in this category!',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ))
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 7),
                  child: GridView.builder(
                    itemCount: controller.filteredCourses?.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15),
                    itemBuilder: (context, index) {
                      return CategoryCourseCard(
                          course: controller.filteredCourses?.value[index]);
                    },
                  ),
                ),
        ));
  }
}
