import 'package:e_learn/app/controller/user_detail_controller.dart';
import 'package:e_learn/app/customs/custom_body.dart';
import 'package:e_learn/app/routes/app_pages.dart';
import 'package:e_learn/app/utils/categoryCard.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/app/views/course_card.dart';
import 'package:e_learn/app/views/paid_course_card.dart';
import 'package:e_learn/app/views/searchpage.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../controllers/homepage_controller.dart';

class HomepageView extends GetView<HomepageController> {
  const HomepageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var userdetailcontroller = Get.find<UserDetailController>();
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
                SizedBox(
                  width: 50.w,
                  child: Row(
                    children: [
                      Obx(
                        () =>
                            userdetailcontroller.userInfo.value.fullName == null
                                ? const Text(
                                    "Good Morning",
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  )
                                : Text(
                                    "Hello ${userdetailcontroller.userInfo.value.fullName!.split(' ')[0]}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                      ),
                      Gap(width: 3.w),
                      const Icon(
                        FlutterIcons.hand_ent,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.CART);
                  },
                  icon: Icon(
                    FontAwesome.shopping_cart,
                    color: buttonColor,
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
                            return PaidCourseCard(
                                course:
                                    userdetailcontroller.paidCourses![index]);
                          },
                        ),
                      ),
                      Gap(height: 3.w),
                      Text(
                        'Trending courses',
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
                            return CourseCard(
                                // ignore: invalid_use_of_protected_member
                                course: controller.courses?.value[index]);
                          },
                        ),
                      ),
                    ],
                  )),
            ),
          )),
    );
  }
}
