import 'package:e_learn/app/controller/user_detail_controller.dart';
import 'package:e_learn/app/customs/custom_body.dart';
import 'package:e_learn/app/modules/cart/controllers/cart_controller.dart';
import 'package:e_learn/app/modules/cart/views/cart_view.dart';
import 'package:e_learn/app/routes/app_pages.dart';
import 'package:e_learn/app/utils/categoryCard.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/app/views/course_card.dart';
import 'package:e_learn/app/views/searchpage.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../controllers/homepage_controller.dart';

class HomepageView extends GetView<HomepageController> {
  const HomepageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var userdetailcontroller = Get.find<UserDetailController>();
    var cartController = Get.put(CartController());
    Get.put(HomepageController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          // appBar: AppBar(
          //   title: Row(
          //     children: [
          //       Text('Hello Name')],
          //   ),
          //   centerTitle: true,
          // ),
          appBar: AppBar(
            backgroundColor: backgroundColor,
            title: Row(
              children: [
                Gap(width: 30.w),
                const Icon(
                  Icons.back_hand,
                  color: Colors.black,
                ),
                Gap(width: 3.w),
                const Text(
                  "Hello Name",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                Gap(width: 17.w),
                IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.CART);
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: GetBuilder<HomepageController>(
              builder: (controller) => customBody(
                  isScrollable: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 45.w,
                        width: 90.w,
                        // color: primaryColor,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.sp),
                            color: secondaryColor),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 0, bottom: 0, left: 20, right: 20),
                          child: Stack(children: [
                            Positioned(
                                right: -10.w,
                                child: SizedBox(
                                    height: 40.w,
                                    width: 60.w,
                                    child: Lottie.asset(
                                        'assets/lottie/learning-homepage.json'))),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20, left: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Start",
                                        style: TextStyle(
                                            fontSize: 23.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        "Learning",
                                        style: TextStyle(
                                            fontSize: 23.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                Gap(height: 4.w),
                                SizedBox(
                                  height: 12.w,
                                  child: TextFormField(
                                    onTap: () {
                                      showSearch(
                                          context: context,
                                          delegate: SearchButtonFunction());
                                    },
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        color: Colors.black.withOpacity(0.8)),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(top: 2.w),
                                      // border: OutlineInputBorder(
                                      //     borderRadius: BorderRadius.circular(30)),
                                      filled: true,
                                      fillColor: Colors.white,
                                      prefixIcon: Icon(
                                        Icons.search,
                                        size: 15.sp,
                                      ),
                                      hintText: "What you want to learn?",
                                      hintStyle: TextStyle(fontSize: 10.sp),
                                      prefixIconColor: Colors.black54,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ]),
                        ),
                      ),
                      Gap(height: 5.w),
                      controller.category == null
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              height: 10.w,
                              width: 90.w,
                              child: Obx(
                                () => ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => CategoryCard(
                                      category: controller.category![index]),
                                  itemCount: controller.category!.length,
                                ),
                              ),
                            ),
                      Gap(height: 5.w),
                      Text(
                        'Ongoing courses',
                        style: TextStyle(
                            color: primaryTextColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      Gap(height: 3.w),
                      SizedBox(
                        height: 42.w,
                        width: 90.w,
                        child: ListView.builder(
                          itemCount: userdetailcontroller.paidCourses!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CourseCard(
                                course:
                                    userdetailcontroller.paidCourses![index]);
                          },
                        ),
                      ),
                      Gap(height: 3.w),
                      Text(
                        'Recommended courses',
                        style: TextStyle(
                            color: primaryTextColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      Gap(height: 3.w),
                      SizedBox(
                        height: 47.w,
                        width: 90.w,
                        child: ListView.builder(
                          itemCount: controller.courses?.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 26.w,
                                    width: 42.w,
                                    color: Colors.black,
                                    child: Image.network(
                                      getImageUrl(
                                          controller.courses?[index].image ??
                                              ''),
                                      fit: BoxFit.cover,
                                      height: 26.w,
                                      width: 42.w,
                                    ),
                                  ),
                                  Gap(height: 1.w),
                                  Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 35.w,
                                            child: Text(
                                              controller.courses?[index]
                                                      .courseName ??
                                                  '',
                                              style: TextStyle(
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontSize: 11.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black
                                                      .withOpacity(0.9)),
                                            ),
                                          ),
                                          Gap(height: 0.5.w),
                                          SizedBox(
                                            width: 35.w,
                                            child: Text(
                                              controller.courses?[index]
                                                      .fullName ??
                                                  '',
                                              style: TextStyle(
                                                  fontSize: 8.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black
                                                      .withOpacity(0.7)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          cartController.addCoursesTocart(
                                              course:
                                                  controller.courses![index]);
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
                                    initialRating: double.parse(controller
                                            .courses![index].averageRating ??
                                        '0.0'),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    unratedColor: primaryColor,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 1.sp),
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: bottomnavigationBarColor,
                                    ),
                                    onRatingUpdate: (value) {},
                                    ignoreGestures: true,
                                  ),
                                  Gap(height: 0.5.w),
                                  Text(
                                    controller.courses?[index].price ?? '',
                                    style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black.withOpacity(0.90)),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  )),
            ),
          )),
    );
  }
}
