import 'package:e_learn/app/customs/custom_body.dart';
import 'package:e_learn/app/routes/app_pages.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/quiz_details_controller.dart';

class QuizDetailsView extends GetView<QuizDetailsController> {
  const QuizDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Details'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 180.w,
            child: Obx(
              () => controller.quizz?.value.length == 0
                  ? Center(
                      child: Text(
                      "No quiz in this course!",
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.black.withOpacity(0.6)),
                    ))
                  : ListView.builder(
                      itemCount: controller.quizz!.value.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.QUIZ,
                                arguments: controller.quizz?.value[index]);
                          },
                          child: Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 1.w),
                            shadowColor: Colors.grey,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: Column(
                                children: [
                                  Text(
                                      controller.quizz!.value[index]
                                              .questionText ??
                                          '',
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500)),
                                  Gap(height: 2.w),
                                  Text(
                                    controller.quizz!.value[index]
                                            .correctOption ??
                                        '',
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.ADD_QUIZ, arguments: controller.course);
              // GetPage(
              //   name: Routes.ADD_PRODUCT,
              //   page: () => AddProductView(),
              //   binding: AddProductBinding(),
              //   transition: Transition.fadeIn,
              //   transitionDuration: Duration(milliseconds: 700),
              // );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  size: 30.sp,
                  color: Colors.grey,
                ),
                Text(
                  "Add a New Quizz",
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
