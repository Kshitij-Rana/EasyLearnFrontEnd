import 'package:e_learn/app/models/courses.dart';
import 'package:e_learn/app/models/paid_courses.dart';
import 'package:e_learn/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:e_learn/app/routes/app_pages.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/components/constants.dart';
import 'package:e_learn/components/delete_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_indicator/progress_indicator.dart';
import 'package:sizer/sizer.dart';

class MyCourses extends StatelessWidget {
  final Courses? course;
  final bool isSearch;
  final bool? isPaidCourses;
  final Paidcourse? paidCourse;

  const MyCourses(
      {super.key,
      this.course,
      this.isSearch = false,
      this.isPaidCourses = false,
      this.paidCourse});

  @override
  Widget build(BuildContext context) {
    var homepageController = Get.find<HomepageController>();
    return GestureDetector(
      onTap: () {
        if (isPaidCourses == true) {
          Get.toNamed(Routes.PAICOURSE_CONTENT, arguments: paidCourse);

          homepageController.getRatingofUser(paidCourse?.courseId ?? '');
        } else if (isPaidCourses == false) {
          Get.toNamed(Routes.COURSECONTENTFORADMIN, arguments: course);
        }
      },
      child: Stack(
        children: [
          Card(
            shadowColor: Colors.grey,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  isPaidCourses == true
                      ? Container(
                          height: 20.w,
                          width: 30.w,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: isPaidCourses == true
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image(
                                      image: NetworkImage(
                                          getImageUrl(paidCourse?.image)),
                                      fit: BoxFit.cover),
                                )
                              : paidCourse?.image == null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: const Image(
                                          image: AssetImage(
                                              "assets/images/noImage.png"),
                                          fit: BoxFit.cover),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image(
                                          image: NetworkImage(
                                              getImageUrl(course?.image)),
                                          fit: BoxFit.cover),
                                    ),
                        )
                      : Container(
                          height: 20.w,
                          width: 30.w,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: isPaidCourses == true
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image(
                                      image: NetworkImage(
                                          getImageUrl(paidCourse?.image)),
                                      fit: BoxFit.cover),
                                )
                              : course?.image == null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: const Image(
                                          image: AssetImage(
                                              "assets/images/noImage.png"),
                                          fit: BoxFit.cover),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image(
                                          image: NetworkImage(
                                              getImageUrl(course?.image)),
                                          fit: BoxFit.cover),
                                    ),
                        ),
                  Gap(width: 3.w),
                  SizedBox(
                    width: 45.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 40.w,
                          child: Text(
                            isPaidCourses == true
                                ? paidCourse?.courseName ?? ''
                                : course?.courseName ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.8)),
                          ),
                        ),
                        Gap(height: 0.5.w),
                        Text(
                          isPaidCourses == true
                              ? getCategoryName(
                                  int.parse(paidCourse?.categoryId ?? '1'))
                              : course?.categoryName ?? '',
                          style: TextStyle(
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black.withOpacity(0.7)),
                        ),
                        Gap(height: 0.5.w),
                        Text(
                          isPaidCourses == true
                              ? "${paidCourse?.numberOfContent ?? '0'} videos"
                              : course?.fullName ?? '',
                          style: TextStyle(
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black.withOpacity(0.75)),
                        ),
                        Gap(height: 3.w),
                        homepageController.role == "admin" ||
                                homepageController.role == "instructor"
                            ? const SizedBox.shrink()
                            : isSearch == true
                                ? const SizedBox.shrink()
                                : Padding(
                                    padding: const EdgeInsets.only(left: 3),
                                    child: SizedBox(
                                      width: 48.w,
                                      height: 1.w,
                                      child: BarProgress(
                                        percentage: paidCourse
                                                        ?.numberOfContent ==
                                                    null ||
                                                paidCourse
                                                        ?.numberOfContentFinished ==
                                                    null
                                            ? 0
                                            : (int.parse(paidCourse
                                                        ?.numberOfContentFinished ??
                                                    "1") /
                                                int.parse(paidCourse
                                                        ?.numberOfContent ??
                                                    "1") *
                                                100),
                                        backColor: Colors.grey.withOpacity(0.4),
                                        gradient: LinearGradient(colors: [
                                          bottomnavigationBarColor,
                                          bottomnavigationBarColor
                                        ]),
                                        showPercentage: true,
                                        textStyle: const TextStyle(
                                            color: Colors.orange, fontSize: 0),
                                        stroke: 3,
                                        round: true,
                                      ),
                                    ),
                                  ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              right: 5.w,
              top: 7.w,
              child: homepageController.role == "admin" ||
                      homepageController.role == "instructor"
                  ? PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.black,
                      ), // Change to Icons.more_horiz if you prefer horizontal dots
                      onSelected: (String value) {
                        if (value == 'edit') {
                          Get.toNamed(Routes.EDIT_COURSES_ADMIN,
                              arguments: course);
                          Get.find<HomepageController>().getCourses();
                        } else if (value == 'delete') {
                          showCupertinoDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (context) {
                              return DeleteModal(
                                question:
                                    "Are you sure you want to delete this course?",
                                deleteFunction: () {
                                  homepageController.deleteCourse(
                                      int.parse(course?.courseId ?? "0"));
                                  Get.back();
                                },
                              );
                            },
                          );
                        }
                      },

                      itemBuilder: (context) => <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'edit',
                          child: Text('Edit'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'delete',
                          child: Text('Delete'),
                        ),
                      ],
                    )
                  : const SizedBox.shrink())
        ],
      ),
    );
  }
}
