import 'package:e_learn/app/models/courses.dart';
import 'package:e_learn/app/modules/cart/controllers/cart_controller.dart';
import 'package:e_learn/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:e_learn/app/routes/app_pages.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CategoryCourseCard extends StatelessWidget {
  final Courses? course;
  const CategoryCourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    var cartController = Get.put(CartController());
    var homeController = Get.find<HomepageController>();
    return GestureDetector(
        onTap: () async {
          Get.toNamed(Routes.COURSECONTENT, arguments: course);
          Get.find<HomepageController>()
              .getRatingofUser(course?.courseId ?? '');
        },
        child: Container(
          height: 100.w,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    blurRadius: 1,
                    color: Colors.grey.withOpacity(0.1),
                    offset: const Offset(1, 2),
                    spreadRadius: 1),
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 22.w,
                width: 49.w,
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
                    getImageUrl(course?.image ?? ''),
                    fit: BoxFit.cover,
                    height: 26.w,
                    width: 42.w,
                  ),
                ),
              ),
              Gap(height: 1.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 35.w,
                        child: Text(
                          course?.courseName ?? '',
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withOpacity(0.9)),
                        ),
                      ),
                      Gap(height: 0.5.w),
                      SizedBox(
                        width: 35.w,
                        child: Text(
                          course?.fullName ?? '',
                          style: TextStyle(
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black.withOpacity(0.7)),
                        ),
                      ),
                    ],
                  ),
                  course!.isOnline == "0"
                      ? SizedBox.shrink()
                      : GestureDetector(
                          onTap: () {
                            if (homeController.isbought.value =
                                homeController.isCourseInPaidCourses(
                                    course!, homeController.paidCourses!)) {
                              Get.showSnackbar(GetSnackBar(
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.red,
                                message: "Course already purchased",
                              ));
                            } else {
                              cartController.addCoursesTocart(course: course!);
                            }
                          },
                          child: Icon(
                            Icons.add_shopping_cart,
                            color: Colors.black,
                          ),
                        )
                ],
              ),
              Gap(height: 0.5.w),
              // Row(
              //   children: [
              //     Text(
              //       "Rating Stars",
              //       style: TextStyle(
              //           fontSize: 9.sp,
              //           fontWeight: FontWeight.w400,
              //           color:
              //               Colors.black.withOpacity(0.75)),
              //     ),
              //     Gap(width: 4.w),
              //     Text(
              //       "4.0",
              //       style: TextStyle(
              //           fontSize: 9.sp,
              //           fontWeight: FontWeight.w400,
              //           color:
              //               Colors.black.withOpacity(0.75)),
              //     )
              //   ],
              // ),
              RatingBar.builder(
                itemSize: 12.sp,
                initialRating: double.parse(course?.averageRating ?? '0.0'),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                unratedColor: primaryColor,
                itemPadding: EdgeInsets.symmetric(horizontal: 1.sp),
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: bottomnavigationBarColor,
                ),
                onRatingUpdate: (value) {},
                ignoreGestures: true,
              ),
              Gap(height: 0.5.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    course?.price ?? '',
                    style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(0.90)),
                  ),
                  course?.isOnline == "0"
                      ? Container(
                          padding: EdgeInsets.symmetric(horizontal: 3),
                          height: 5.w,
                          width: 15.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors
                                .brown[500], // Adjusted for offline classes
                          ),
                          child: Center(
                            child: Text(
                              "Physical",
                              style: TextStyle(
                                  fontSize: 8.sp, color: Colors.white),
                            ),
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.symmetric(horizontal: 3),
                          height: 5.w,
                          width: 15.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color.fromARGB(255, 94, 207,
                                97), // Adjusted for online classes
                          ),
                          child: Center(
                            child: Text(
                              "Online",
                              style: TextStyle(
                                  fontSize: 9.sp, color: Colors.white),
                            ),
                          ),
                        )
                ],
              )
            ],
          ),
        ));
  }
}
