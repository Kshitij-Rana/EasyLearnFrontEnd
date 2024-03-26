import 'package:e_learn/app/customs/components/videoPlayer.dart';
import 'package:e_learn/app/customs/custom_body.dart';
import 'package:e_learn/app/modules/addCourseContent/controllers/add_course_content_controller.dart';
import 'package:e_learn/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:e_learn/app/routes/app_pages.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/components/constants.dart';
import 'package:e_learn/components/ratingModal.dart';
import 'package:e_learn/components/ratingdetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/paicourse_content_controller.dart';

class PaicourseContentView extends GetView<PaicourseContentController> {
  const PaicourseContentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var homepageController = Get.find<HomepageController>();
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
                        ? VideoPlauer()
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
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.courseContentCourseId?.length ?? 0,
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
                          duration: const Duration(milliseconds: 200),
                          child: Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                margin: EdgeInsets.symmetric(
                                    vertical: 2.w, horizontal: 1.w),
                                height:
                                    controller.isClicked[index].value == false
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
                                    GestureDetector(
                                      onTap: () {
                                        if (controller.isPlayed[index].value ==
                                            false) {
                                          controller.onclickingplayIcon(index);
                                        } else {
                                          controller.isPlayed[index].value =
                                              false;
                                        }
                                      },
                                      child: Align(
                                        alignment:
                                            controller.isClicked[index].value ==
                                                    true
                                                ? Alignment.topCenter
                                                : Alignment.center,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            controller.isPlayed[index].value
                                                ? Icons.pause
                                                : Icons.play_arrow_rounded,
                                            color: bottomnavigationBarColor,
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
                                                  fontWeight: FontWeight.w500),
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
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Gap(height: 1.w),
                                        Text(
                                          formatTime(controller
                                                  .courseContentCourseId?[index]
                                                  .contentDuration ??
                                              "00:00"),
                                          style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.8),
                                              fontSize: 11.sp),
                                        ),
                                        controller.isClicked[index].value ==
                                                true
                                            ? SizedBox(
                                                width: 60.w,
                                                child: Text(
                                                    controller
                                                            .courseContentCourseId?[
                                                                index]
                                                            .contentDescription ??
                                                        "No description",
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        color: Colors.black
                                                            .withOpacity(0.8),
                                                        fontSize: 11.sp)),
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
                                  child: homepageController.role == "admin" ||
                                          homepageController.role ==
                                              "instructor"
                                      ? Container(
                                          height: 9.w,
                                          child: Center(
                                            child: PopupMenuButton<String>(
                                              icon: Icon(
                                                Icons.more_vert,
                                                color: Colors.black,
                                              ), // Change to Icons.more_horiz if you prefer horizontal dots
                                              onSelected: (String value) {
                                                if (value == 'edit') {
                                                  print('Edit option selected');
                                                  // Implement your edit functionality here
                                                } else if (value == 'delete') {
                                                  print(
                                                      'Delete option selected');
                                                  // Implement your delete functionality here
                                                }
                                              },

                                              itemBuilder: (context) =>
                                                  <PopupMenuEntry<String>>[
                                                const PopupMenuItem<String>(
                                                  value: 'edit',
                                                  child: Text('Edit'),
                                                ),
                                                const PopupMenuItem<String>(
                                                  value: 'delete',
                                                  child: Text('Delete'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : SizedBox.shrink()),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
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
                    : SizedBox.shrink(),
                Gap(height: 5.h),
                Padding(
                  padding: EdgeInsets.only(left: 0.sp),
                  child: Text(
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
                )
              ],
            )));
  }
}
