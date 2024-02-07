import 'package:e_learn/app/routes/app_pages.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_indicator/progress_indicator.dart';
import 'package:sizer/sizer.dart';

class MyCourses extends StatefulWidget {
  const MyCourses({super.key});

  @override
  State<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.COURSECONTENT);
      },
      child: Card(
        shadowColor: Colors.grey,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                  SizedBox(
                    width: 50.w,
                    child: Text(
                      "Courses Title ho hai yo chai",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(0.8)),
                    ),
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
                        textStyle:
                            const TextStyle(color: Colors.orange, fontSize: 0),
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
      ),
    );
  }
}
