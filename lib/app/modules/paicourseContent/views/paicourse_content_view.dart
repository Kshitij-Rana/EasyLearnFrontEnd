import 'package:e_learn/app/controller/user_detail_controller.dart';
import 'package:e_learn/app/customs/components/certification.dart';
import 'package:e_learn/app/customs/components/videoPlayer.dart';
import 'package:e_learn/app/customs/custom_body.dart';
import 'package:e_learn/app/customs/custom_button.dart';
import 'package:e_learn/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:e_learn/app/routes/app_pages.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/components/constants.dart';
import 'package:e_learn/components/delete_modal.dart';
import 'package:e_learn/components/ratingModal.dart';
import 'package:e_learn/components/ratingdetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:sizer/sizer.dart';

import '../controllers/paicourse_content_controller.dart';

class PaicourseContentView extends GetView<PaicourseContentController> {
  const PaicourseContentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var homepageController = Get.find<HomepageController>();
    var userDetailController = Get.find<UserDetailController>();
    RxInt currentQuizIndex = 0.obs;

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
            controller.courses.courseName ?? '',
            style: const TextStyle(color: Colors.black),
          ),
        ),
        body: customBody(
            isScrollable: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 90.w,
                  height: 50.w,
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
                  child: Obx(
                    () => controller.videoplayed.value
                        ? const VideoPlauer()
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(13),
                            child: Image.network(
                              getImageUrl(controller.courses.image ?? ''),
                              height: 26.w,
                              width: 42.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
                Gap(height: 5.w),
                Text(
                  "Course Details",
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold),
                ),
                Gap(height: 3.w),
                Text(
                  controller.courses.description ?? '',
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
                Obx(
                  () => controller.courseContentCourseId?.length == 0
                      ? const Text("No lessons in this course")
                      : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              controller.courseContentCourseId?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Obx(
                              () => GestureDetector(
                                onTap: () {
                                  if (controller.isClicked[index].value ==
                                      false) {
                                    controller.isClicked[index].value = true;
                                  } else {
                                    controller.isClicked[index].value = false;
                                  }
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        margin: EdgeInsets.symmetric(
                                            vertical: 2.w, horizontal: 1.w),
                                        height:
                                            controller.isClicked[index].value ==
                                                    false
                                                ? 16.5.w
                                                : 25.w,
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                            color: controller
                                                    .progressTracking!.value
                                                    .map((e) => e.lessonId)
                                                    .contains(controller
                                                        .courseContentCourseId!
                                                        .value[index]
                                                        .contentId)
                                                ? Colors.green.shade100
                                                : Colors.grey.shade300,
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 1,
                                                  blurStyle: BlurStyle.normal,
                                                  color: Colors.grey
                                                      .withOpacity(0.4),
                                                  offset: const Offset(1, 2),
                                                  spreadRadius: 1)
                                            ]),
                                        child: Row(
                                          children: [
                                            Gap(width: 1.w),
                                            GestureDetector(
                                              onTap: () {
                                                if (controller.isPlayed[index]
                                                        .value ==
                                                    false) {
                                                  controller.onclickingplayIcon(
                                                      index,
                                                      controller
                                                              .courseContentCourseId?[
                                                                  index]
                                                              .contentId ??
                                                          '');
                                                } else {
                                                  controller.isPlayed[index]
                                                      .value = false;
                                                }
                                              },
                                              child: Align(
                                                alignment: controller
                                                            .isClicked[index]
                                                            .value ==
                                                        true
                                                    ? Alignment.topCenter
                                                    : Alignment.center,
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  child: Icon(
                                                    controller.isPlayed[index]
                                                            .value
                                                        ? Icons.pause
                                                        : Icons
                                                            .play_arrow_rounded,
                                                    color:
                                                        bottomnavigationBarColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Gap(width: 3.w),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      '${(index + 1).toString()}.',
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Gap(width: 1.w),
                                                    SizedBox(
                                                      height: 5.w,
                                                      width: 52.w,
                                                      child: Text(
                                                        controller
                                                                .courseContentCourseId?[
                                                                    index]
                                                                .contentName ??
                                                            "No content",
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Gap(height: 1.w),
                                                Text(
                                                  formatTime(controller
                                                          .courseContentCourseId?[
                                                              index]
                                                          .contentDuration ??
                                                      "00:00"),
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(0.8),
                                                      fontSize: 11.sp),
                                                ),
                                                controller.isClicked[index]
                                                            .value ==
                                                        true
                                                    ? SizedBox(
                                                        width: 60.w,
                                                        child: Text(
                                                            controller
                                                                    .courseContentCourseId?[
                                                                        index]
                                                                    .contentDescription ??
                                                                "No description",
                                                            style:
                                                                TextStyle(
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.8),
                                                                    fontSize:
                                                                        11.sp)),
                                                      )
                                                    : const SizedBox.shrink(),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                          left: 75.w,
                                          top: 5.w,
                                          child: homepageController.role ==
                                                      "admin" ||
                                                  homepageController.role ==
                                                      "instructor"
                                              ? SizedBox(
                                                  height: 9.w,
                                                  child: Center(
                                                    child:
                                                        PopupMenuButton<String>(
                                                      icon: const Icon(
                                                        Icons.more_vert,
                                                        color: Colors.black,
                                                      ), // Change to Icons.more_horiz if you prefer horizontal dots
                                                      onSelected:
                                                          (String value) {
                                                        if (value == 'edit') {
                                                          Get.toNamed(
                                                              Routes
                                                                  .EDIT_COURSE_CONTENT,
                                                              arguments: controller
                                                                      .courseContentCourseId![
                                                                  index]);
                                                        } else if (value ==
                                                            'delete') {
                                                          // Implement your delete functionality here
                                                        }
                                                      },

                                                      itemBuilder: (context) =>
                                                          <PopupMenuEntry<
                                                              String>>[
                                                        const PopupMenuItem<
                                                            String>(
                                                          value: 'edit',
                                                          child: Text('Edit'),
                                                        ),
                                                        const PopupMenuItem<
                                                            String>(
                                                          value: 'delete',
                                                          child: Text('Delete'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink()),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
                homepageController.role == "admin" ||
                        homepageController.role == "instructor"
                    ? GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.ADD_COURSE_CONTENT,
                              arguments: controller.courses);
                          // GetPage(
                          //   name: Routes.ADD_COURSE_CONTENT,
                          //   page: () => AddCourseContentView(),
                          //   binding: AddCourseContentBinding(),
                          //   transition: Transition.fadeIn,
                          //   transitionDuration: Duration(milliseconds: 700),
                          // );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                              size: 50.sp,
                              color: Colors.grey,
                            ),
                            Gap(width: 2.h),
                            Text(
                              "Add a Course Content",
                              style: TextStyle(
                                  fontSize: 13.sp, color: Colors.black),
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
                Gap(height: 5.h),
                Obx(
                  () => Text(
                    homepageController.isRated.value == true
                        ? "Your Review"
                        : "Rate this course",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Gap(height: 2.w),
                Obx(
                  () => Center(
                    child: homepageController.isRated.value == true
                        ? RatingDetails(
                            rating: homepageController.rating[0],
                          )
                        : RatingBar.builder(
                            initialRating:
                                homepageController.ratingNumber.value,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            unratedColor: primaryColor,
                            itemPadding:
                                EdgeInsets.symmetric(horizontal: 12.sp),
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: bottomnavigationBarColor,
                            ),
                            onRatingUpdate: (value) {
                              homepageController.ratingNumber.value = value;
                              homepageController
                                  .ratingDescriptionController.text = "";
                              showCupertinoDialog(
                                barrierDismissible: true,
                                context: context,
                                builder: (context) {
                                  return RatingModal(
                                    CourseId: controller.courses.courseId ?? '',
                                  );
                                },
                              );
                            },
                          ),
                  ),
                ),
                Gap(height: 2.w),
                Obx(
                  () => Text(
                    controller.quizMarks?.value == null
                        ? "Take Quiz"
                        : "Quiz Marks",
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black.withOpacity(0.8),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Gap(height: 2.w),
                Obx(
                  () => controller.quizMarks?.value == null
                      ? GestureDetector(
                          onTap: () {
                            () async {
                              await controller
                                  .getQuiz(controller.courses.courseId ?? '0');
                              currentQuizIndex.value = 0;
                              controller.score.value = 0;
                              controller.isSubmitted.value = false;
                              // ignore: use_build_context_synchronously
                              showCupertinoDialog(
                                barrierDismissible: true,
                                context: context,
                                builder: (context) {
                                  return Obx(
                                    () => Dialog(
                                      child: controller.quizz!.value.isNotEmpty
                                          ? Container(
                                              height: 70.w,
                                              width: 95.w,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Colors.white,
                                              ),
                                              child:
                                                  controller.isSubmitted.value
                                                      ? Center(
                                                          child: Text(
                                                              'Your score is: ${controller.score.value}/${controller.quizz?.value.length}'),
                                                        )
                                                      : Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Gap(height: 4.w),
                                                            Text(
                                                              controller
                                                                      .quizz!
                                                                      .value[currentQuizIndex
                                                                          .value]
                                                                      .questionText ??
                                                                  '',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      11.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            // Display options as radio buttons or any other suitable widget
                                                            // For simplicity, options are displayed as text
                                                            // ...List.generate(
                                                            //     4,
                                                            //     (index) => RadioListTile<int>(
                                                            //           title: Text(
                                                            //               'Option ${index + 1}'),
                                                            //           value: index + 1,
                                                            //           groupValue: controller
                                                            //               .selectedOption.value,
                                                            //           onChanged: (value) {
                                                            //             controller.selectedOption
                                                            //                 .value = value!;
                                                            //           },
                                                            //         )),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: <Widget>[
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                      boxShadow: controller.selectedOption.value == 1 // Check if selectedValue is equal to radio value
                                                                          ? [
                                                                              BoxShadow(
                                                                                color: Colors.grey.withOpacity(0.5), // Shadow color
                                                                                spreadRadius: 1, // Spread radius
                                                                                blurRadius: 1, // Blur radius
                                                                                offset: const Offset(0, 1), // Shadow position
                                                                              ),
                                                                            ]
                                                                          : [],
                                                                      color: Colors.grey.shade100,
                                                                      borderRadius: BorderRadius.circular(12)),
                                                                  height: 10.w,
                                                                  width: 70.w,
                                                                  child: Row(
                                                                    children: [
                                                                      Radio(
                                                                        value:
                                                                            1,
                                                                        groupValue: controller
                                                                            .selectedOption
                                                                            .value,
                                                                        onChanged:
                                                                            (valu) {
                                                                          controller
                                                                              .selectedOption
                                                                              .value = valu!;
                                                                        },
                                                                      ),
                                                                      Text(
                                                                        controller.quizz!.value[currentQuizIndex.value].option1 ??
                                                                            '',
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                16.0),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Gap(
                                                                    height:
                                                                        2.w),
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                      boxShadow: controller.selectedOption.value == 2 // Check if selectedValue is equal to radio value
                                                                          ? [
                                                                              BoxShadow(
                                                                                color: Colors.grey.withOpacity(0.5), // Shadow color
                                                                                spreadRadius: 1, // Spread radius
                                                                                blurRadius: 1, // Blur radius
                                                                                offset: const Offset(0, 1), // Shadow position
                                                                              ),
                                                                            ]
                                                                          : [],
                                                                      color: Colors.grey.shade100,
                                                                      borderRadius: BorderRadius.circular(12)),
                                                                  height: 10.w,
                                                                  width: 70.w,
                                                                  child: Row(
                                                                    children: [
                                                                      Radio(
                                                                        value:
                                                                            2,
                                                                        groupValue: controller
                                                                            .selectedOption
                                                                            .value,
                                                                        onChanged:
                                                                            (valu) {
                                                                          controller
                                                                              .selectedOption
                                                                              .value = valu!;
                                                                        },
                                                                      ),
                                                                      Text(
                                                                        controller.quizz!.value[currentQuizIndex.value].option2 ??
                                                                            '',
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                16.0),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Gap(
                                                                    height:
                                                                        2.w),
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                      boxShadow: controller.selectedOption.value == 3 // Check if selectedValue is equal to radio value
                                                                          ? [
                                                                              BoxShadow(
                                                                                color: Colors.grey.withOpacity(0.5), // Shadow color
                                                                                spreadRadius: 1, // Spread radius
                                                                                blurRadius: 1, // Blur radius
                                                                                offset: const Offset(0, 1), // Shadow position
                                                                              ),
                                                                            ]
                                                                          : [],
                                                                      color: Colors.grey.shade100,
                                                                      borderRadius: BorderRadius.circular(12)),
                                                                  height: 10.w,
                                                                  width: 70.w,
                                                                  child: Row(
                                                                    children: [
                                                                      Radio(
                                                                        value:
                                                                            3,
                                                                        groupValue: controller
                                                                            .selectedOption
                                                                            .value,
                                                                        onChanged:
                                                                            (valu) {
                                                                          controller
                                                                              .selectedOption
                                                                              .value = valu!;
                                                                        },
                                                                      ),
                                                                      Text(
                                                                        controller.quizz!.value[currentQuizIndex.value].option3 ??
                                                                            '',
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                16.0),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Gap(
                                                                    height:
                                                                        2.w),
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                      boxShadow: controller.selectedOption.value == 4 // Check if selectedValue is equal to radio value
                                                                          ? [
                                                                              BoxShadow(
                                                                                color: Colors.grey.withOpacity(0.5), // Shadow color
                                                                                spreadRadius: 1, // Spread radius
                                                                                blurRadius: 1, // Blur radius
                                                                                offset: const Offset(0, 1), // Shadow position
                                                                              ),
                                                                            ]
                                                                          : [],
                                                                      color: Colors.grey.shade100,
                                                                      borderRadius: BorderRadius.circular(12)),
                                                                  height: 10.w,
                                                                  width: 70.w,
                                                                  child: Row(
                                                                    children: [
                                                                      Radio(
                                                                        value:
                                                                            4,
                                                                        groupValue: controller
                                                                            .selectedOption
                                                                            .value,
                                                                        onChanged:
                                                                            (valu) {
                                                                          controller
                                                                              .selectedOption
                                                                              .value = valu!;
                                                                        },
                                                                      ),
                                                                      Text(
                                                                        controller.quizz!.value[currentQuizIndex.value].option4 ??
                                                                            '',
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                16.0),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            currentQuizIndex <
                                                                    controller
                                                                            .quizz!
                                                                            .value
                                                                            .length -
                                                                        1
                                                                ? ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      // Get.showSnackbar(GetSnackBar(
                                                                      //   backgroundColor: Colors.red,
                                                                      //   message: controller
                                                                      //       .selectedOption.value
                                                                      //       .toString(),
                                                                      //   duration: const Duration(
                                                                      //       seconds: 3),
                                                                      // ));
                                                                      controller
                                                                          .checkAnswer(
                                                                              currentQuizIndex.value);

                                                                      currentQuizIndex++;
                                                                    },
                                                                    child: const Text(
                                                                        'Next'),
                                                                  )
                                                                : ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      controller
                                                                          .checkAnswer(
                                                                              currentQuizIndex.value);
                                                                      // Handle quiz submission here
                                                                      controller
                                                                          .addMarks();
                                                                      controller
                                                                          .isSubmitted
                                                                          .value = true;
                                                                    },
                                                                    child: const Text(
                                                                        'Submit'),
                                                                  ),
                                                          ],
                                                        ),
                                            )
                                          : const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                    ),
                                  );
                                },
                              );
                            };
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: bottomnavigationBarColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Ionicons.ios_book, color: Colors.white),
                                SizedBox(width: 8),
                                Text(
                                  "Start quizz",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            Row(
                              children: [
                                controller.quizMarks!.value.isNotEmpty
                                    ? RichText(
                                        text: TextSpan(
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  "${controller.quizMarks?.value[0].obtainedMarks}",
                                              style: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Colors
                                                    .green, // Use a color to indicate success
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  "/${controller.quizMarks?.value[0].fullMarks}",
                                              style: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: Colors
                                                    .black, // Use a neutral color for the total marks
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () async {
                                          await controller.getQuiz(
                                              controller.courses.courseId ??
                                                  '0');
                                          currentQuizIndex.value = 0;
                                          controller.score.value = 0;
                                          controller.isSubmitted.value = false;
                                          // ignore: use_build_context_synchronously
                                          showCupertinoDialog(
                                            context: context,
                                            builder: (context) {
                                              return Obx(
                                                () => Dialog(
                                                    child:
                                                        controller.quizz!.value
                                                                .isNotEmpty
                                                            ? Container(
                                                                height: 70.w,
                                                                width: 95.w,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                child: controller
                                                                        .isSubmitted
                                                                        .value
                                                                    ? Column(
                                                                        children: [
                                                                          Gap(height: 15.w),
                                                                          Center(
                                                                              child: RichText(
                                                                            text:
                                                                                TextSpan(
                                                                              style: DefaultTextStyle.of(context).style,
                                                                              children: <TextSpan>[
                                                                                const TextSpan(
                                                                                  text: 'Your score is: ',
                                                                                  style: TextStyle(
                                                                                    fontSize: 18,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                ),
                                                                                TextSpan(
                                                                                  text: '${controller.score.value}',
                                                                                  style: const TextStyle(
                                                                                    fontSize: 24,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.green, // Use a color to indicate success
                                                                                  ),
                                                                                ),
                                                                                TextSpan(
                                                                                  text: '/${controller.quizz?.value.length}',
                                                                                  style: const TextStyle(
                                                                                    fontSize: 24,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.black, // Use a neutral color for the total quizzes
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          )),
                                                                          Gap(height: 15.w),
                                                                          SizedBox(
                                                                            width:
                                                                                30.w,
                                                                            child:
                                                                                CustomButton(
                                                                              title: "Back",
                                                                              onPressed: () {
                                                                                Get.back();
                                                                              },
                                                                            ),
                                                                          )
                                                                        ],
                                                                      )
                                                                    : Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Gap(height: 4.w),
                                                                          Text(
                                                                            controller.quizz!.value[currentQuizIndex.value].questionText ??
                                                                                '',
                                                                            style:
                                                                                TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500),
                                                                          ),
                                                                          // Display options as radio buttons or any other suitable widget
                                                                          // For simplicity, options are displayed as text
                                                                          // ...List.generate(
                                                                          //     4,
                                                                          //     (index) => RadioListTile<int>(
                                                                          //           title: Text(
                                                                          //               'Option ${index + 1}'),
                                                                          //           value: index + 1,
                                                                          //           groupValue: controller
                                                                          //               .selectedOption.value,
                                                                          //           onChanged: (value) {
                                                                          //             controller.selectedOption
                                                                          //                 .value = value!;
                                                                          //           },
                                                                          //         )),
                                                                          Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: <Widget>[
                                                                              Container(
                                                                                decoration: BoxDecoration(
                                                                                    boxShadow: controller.selectedOption.value == 1 // Check if selectedValue is equal to radio value
                                                                                        ? [
                                                                                            BoxShadow(
                                                                                              color: Colors.grey.withOpacity(0.5), // Shadow color
                                                                                              spreadRadius: 1, // Spread radius
                                                                                              blurRadius: 1, // Blur radius
                                                                                              offset: const Offset(0, 1), // Shadow position
                                                                                            ),
                                                                                          ]
                                                                                        : [],
                                                                                    color: Colors.grey.shade100,
                                                                                    borderRadius: BorderRadius.circular(12)),
                                                                                height: 10.w,
                                                                                width: 70.w,
                                                                                child: Row(
                                                                                  children: [
                                                                                    Radio(
                                                                                      value: 1,
                                                                                      groupValue: controller.selectedOption.value,
                                                                                      onChanged: (valu) {
                                                                                        controller.selectedOption.value = valu!;
                                                                                      },
                                                                                    ),
                                                                                    Text(
                                                                                      controller.quizz!.value[currentQuizIndex.value].option1 ?? '',
                                                                                      style: const TextStyle(fontSize: 16.0),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              Gap(height: 2.w),
                                                                              Container(
                                                                                decoration: BoxDecoration(
                                                                                    boxShadow: controller.selectedOption.value == 2 // Check if selectedValue is equal to radio value
                                                                                        ? [
                                                                                            BoxShadow(
                                                                                              color: Colors.grey.withOpacity(0.5), // Shadow color
                                                                                              spreadRadius: 1, // Spread radius
                                                                                              blurRadius: 1, // Blur radius
                                                                                              offset: const Offset(0, 1), // Shadow position
                                                                                            ),
                                                                                          ]
                                                                                        : [],
                                                                                    color: Colors.grey.shade100,
                                                                                    borderRadius: BorderRadius.circular(12)),
                                                                                height: 10.w,
                                                                                width: 70.w,
                                                                                child: Row(
                                                                                  children: [
                                                                                    Radio(
                                                                                      value: 2,
                                                                                      groupValue: controller.selectedOption.value,
                                                                                      onChanged: (valu) {
                                                                                        controller.selectedOption.value = valu!;
                                                                                      },
                                                                                    ),
                                                                                    Text(
                                                                                      controller.quizz!.value[currentQuizIndex.value].option2 ?? '',
                                                                                      style: const TextStyle(fontSize: 16.0),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              Gap(height: 2.w),
                                                                              Container(
                                                                                decoration: BoxDecoration(
                                                                                    boxShadow: controller.selectedOption.value == 3 // Check if selectedValue is equal to radio value
                                                                                        ? [
                                                                                            BoxShadow(
                                                                                              color: Colors.grey.withOpacity(0.5), // Shadow color
                                                                                              spreadRadius: 1, // Spread radius
                                                                                              blurRadius: 1, // Blur radius
                                                                                              offset: const Offset(0, 1), // Shadow position
                                                                                            ),
                                                                                          ]
                                                                                        : [],
                                                                                    color: Colors.grey.shade100,
                                                                                    borderRadius: BorderRadius.circular(12)),
                                                                                height: 10.w,
                                                                                width: 70.w,
                                                                                child: Row(
                                                                                  children: [
                                                                                    Radio(
                                                                                      value: 3,
                                                                                      groupValue: controller.selectedOption.value,
                                                                                      onChanged: (valu) {
                                                                                        controller.selectedOption.value = valu!;
                                                                                      },
                                                                                    ),
                                                                                    Text(
                                                                                      controller.quizz!.value[currentQuizIndex.value].option3 ?? '',
                                                                                      style: const TextStyle(fontSize: 16.0),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              Gap(height: 2.w),
                                                                              Container(
                                                                                decoration: BoxDecoration(
                                                                                    boxShadow: controller.selectedOption.value == 4 // Check if selectedValue is equal to radio value
                                                                                        ? [
                                                                                            BoxShadow(
                                                                                              color: Colors.grey.withOpacity(0.5), // Shadow color
                                                                                              spreadRadius: 1, // Spread radius
                                                                                              blurRadius: 1, // Blur radius
                                                                                              offset: const Offset(0, 1), // Shadow position
                                                                                            ),
                                                                                          ]
                                                                                        : [],
                                                                                    color: Colors.grey.shade100,
                                                                                    borderRadius: BorderRadius.circular(12)),
                                                                                height: 10.w,
                                                                                width: 70.w,
                                                                                child: Row(
                                                                                  children: [
                                                                                    Radio(
                                                                                      value: 4,
                                                                                      groupValue: controller.selectedOption.value,
                                                                                      onChanged: (valu) {
                                                                                        controller.selectedOption.value = valu!;
                                                                                      },
                                                                                    ),
                                                                                    Text(
                                                                                      controller.quizz!.value[currentQuizIndex.value].option4 ?? '',
                                                                                      style: const TextStyle(fontSize: 16.0),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              )
                                                                            ],
                                                                          ),
                                                                          currentQuizIndex < controller.quizz!.value.length - 1
                                                                              ? ElevatedButton(
                                                                                  onPressed: () {
                                                                                    // Get.showSnackbar(GetSnackBar(
                                                                                    //   backgroundColor: Colors.red,
                                                                                    //   message: controller
                                                                                    //       .selectedOption.value
                                                                                    //       .toString(),
                                                                                    //   duration: const Duration(
                                                                                    //       seconds: 3),
                                                                                    // ));
                                                                                    controller.checkAnswer(currentQuizIndex.value);

                                                                                    currentQuizIndex++;
                                                                                  },
                                                                                  child: Text(
                                                                                    'Next',
                                                                                    style: TextStyle(color: bottomnavigationBarColor, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                )
                                                                              : ElevatedButton(
                                                                                  onPressed: () {
                                                                                    controller.checkAnswer(currentQuizIndex.value);
                                                                                    // Handle quiz submission here
                                                                                    controller.addMarks();
                                                                                    controller.isSubmitted.value = true;
                                                                                  },
                                                                                  child: Text(
                                                                                    'Submit',
                                                                                    style: TextStyle(color: bottomnavigationBarColor, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                        ],
                                                                      ),
                                                              )
                                                            : Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  color: Colors
                                                                      .white,
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                              0.5),
                                                                      spreadRadius:
                                                                          2,
                                                                      blurRadius:
                                                                          7,
                                                                      offset: const Offset(
                                                                          0,
                                                                          3), // changes position of shadow
                                                                    ),
                                                                  ],
                                                                ),
                                                                height: 20.w,
                                                                width: 80.w,
                                                                child:
                                                                    const Center(
                                                                  child: Text(
                                                                    "No quiz for this course",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          16, // Adjust font size as needed
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold, // Make the text bold
                                                                      color: Colors
                                                                          .black, // Adjust text color as needed
                                                                    ),
                                                                  ),
                                                                ),
                                                              )),
                                              );
                                            },
                                          );
                                        },
                                        child: AnimatedContainer(
                                          duration: Duration(milliseconds: 200),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          decoration: BoxDecoration(
                                            color: bottomnavigationBarColor,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Ionicons.ios_book,
                                                  color: Colors.white),
                                              SizedBox(width: 8),
                                              Text(
                                                "Start quizz",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                              ],
                            )
                          ],
                        ),
                ),
                Gap(height: 3.w),

                // Obx(
                //   () => CustomButton(
                //     color: buttonColor,
                //     isDisabled: !controller.isCourseCompleted.value,
                //     title: "Generate Certificate",
                //     onPressed: () async {
                //       try {
                //         Certificate certificate = Certificate();
                //         Certificate.saveDocumentTemporary(
                //             name: "name",
                //             byteList: await certificate.createPdfTemplate1(
                //                 userDetailController.userInfo?.fullName ?? '',
                //                 controller.courses.courseName ??
                //                     '')); // Perform actions with pdfFile, e.g., open it or show a message
                //       } catch (e) {
                //         // Handle the error, e.g., show an error message to the user
                //       }
                //     },
                //   ),
                // )
                Text(
                  "Get your certificate",
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.bold),
                ),
                // Obx(
                //   () => GestureDetector(
                //     onTap: !controller.isCourseCompleted.value
                //         ? null
                //         : () async {
                //             try {
                //               Certificate certificate = Certificate();
                //               Certificate.saveDocumentTemporary(
                //                   name:
                //                       "${controller.courses.courseName ?? ''} Certificate",
                //                   byteList: await certificate.createPdfTemplate1(
                //                       userDetailController.userInfo?.fullName ??
                //                           '',
                //                       controller.courses.courseName ??
                //                           '')); // Perform actions with pdfFile, e.g., open it or show a message
                //             } catch (e) {
                //               // Handle the error, e.g., show an error message to the user
                //             }
                //           },
                //     child: Text(
                //       "Click here to generate certificate",
                //       style: TextStyle(
                //           fontSize: 10.sp,
                //           color: !controller.isCourseCompleted.value
                //               ? Colors.grey
                //               : bottomnavigationBarColor,
                //           fontWeight: FontWeight.w500),
                //     ),
                //   ),
                // ),
                // Obx(
                //   () => controller.isCourseCompleted.value
                //       ? const SizedBox.shrink()
                //       : Text(
                //           "Complete course to get certificate",
                //           style: TextStyle(color: Colors.red.shade400),
                //         ),
                // ),
                Gap(height: 3.w),
                Obx(
                  () => ElevatedButton.icon(
                    onPressed: !controller.isCourseCompleted.value
                        ? null
                        : () async {
                            try {
                              Certificate certificate = Certificate();
                              Certificate.saveDocumentTemporary(
                                  name:
                                      "${controller.courses.courseName ?? ''} Certificate",
                                  byteList:
                                      await certificate.createPdfTemplate1(
                                          userDetailController
                                                  .userInfo?.value.fullName ??
                                              '',
                                          controller.courses.courseName ?? ''));
                              // Perform actions with pdfFile, e.g., open it or show a message
                            } catch (e) {
                              print(e);
                              // Handle the error, e.g., show an error message to the user
                            }
                          },
                    // icon: Icon(Icons.note_add_sharp, color: Colors.white),
                    icon: Icon(
                      FontAwesome.certificate,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Click here to generate certificate",
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: !controller.isCourseCompleted.value
                            ? Colors.grey
                            : Colors
                                .white, // Assuming bottomnavigationBarColor is a color variable
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: !controller.isCourseCompleted.value
                          ? Colors.grey
                          : bottomnavigationBarColor, // Assuming bottomnavigationBarColor is a color variable
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => controller.isCourseCompleted.value
                      ? const SizedBox.shrink()
                      : Text(
                          "Complete all course content to get certificate!",
                          style: TextStyle(color: Colors.red.shade400),
                        ),
                ),
              ],
            )));
  }
}
