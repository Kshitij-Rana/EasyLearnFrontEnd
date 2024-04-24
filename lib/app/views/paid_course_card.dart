import 'package:e_learn/app/models/paid_courses.dart';
import 'package:e_learn/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:e_learn/app/routes/app_pages.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PaidCourseCard extends StatelessWidget {
  final Paidcourse course;
  const PaidCourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Get.toNamed(Routes.PAICOURSE_CONTENT, arguments: course);
        Get.find<HomepageController>().getRatingofUser(course.courseId ?? '');
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 26.w,
              width: 42.w,
              decoration: BoxDecoration(
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
                  getImageUrl(course.image ?? ''),
                  height: 26.w,
                  width: 42.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Gap(height: 1.w),
            SizedBox(
              width: 41.w,
              child: Text(
                course.courseName ?? '',
                style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.black.withOpacity(0.9)),
              ),
            ),
            Gap(height: 0.5.w),
            SizedBox(
              width: 40.w,
              child: Text(
                course.fullName ?? '',
                style: TextStyle(
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.7)),
              ),
            ),
            Gap(height: 0.5.w),
            Row(
              children: [
                Text(
                  "${course.numberOfContent ?? '0'} videos",
                  style: TextStyle(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.75)),
                ),
                Gap(width: 4.w),
                // Text(
                //   "4 hr 20 min",
                //   style: TextStyle(
                //       fontSize: 9.sp,
                //       fontWeight: FontWeight.w400,
                //       color: Colors.black.withOpacity(0.75)),
                // )
              ],
            )
          ],
        ),
      ),
    );
  }
}
