import 'package:e_learn/app/customs/custom_body.dart';
import 'package:e_learn/app/utils/categoryCard.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../controllers/homepage_controller.dart';

class HomepageView extends GetView<HomepageController> {
  const HomepageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
          body: SafeArea(
        child: GetBuilder<HomepageController>(
          builder: (controller) => customBody(
              isScrollable: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Gap(width: 30.w),
                      const Icon(Icons.back_hand),
                      Gap(width: 3.w),
                      const Text("Hello Name")
                    ],
                  ),
                  Gap(height: 5.w),
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
                              padding: const EdgeInsets.only(top: 20, left: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                            Gap(height: 6.w),
                            SizedBox(
                              height: 12.w,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  // border: OutlineInputBorder(
                                  //     borderRadius: BorderRadius.circular(30)),
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: const Icon(Icons.search),
                                  hintText: "What you want to learn?",
                                  hintStyle: TextStyle(fontSize: 10.sp),
                                  prefixIconColor: Colors.black54,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(16),
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
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => CategoryCard(
                                category: controller.category![index]),
                            itemCount: controller.category!.length,
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
                    height: 40.w,
                    width: 90.w,
                    child: ListView.builder(
                      itemCount: controller.courses!.length,
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
                              ),
                              Gap(height: 1.w),
                              SizedBox(
                                width: 41.w,
                                child: Text(
                                  controller.courses?[index].courseName ?? '',
                                  style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withOpacity(0.9)),
                                ),
                              ),
                              Gap(height: 0.5.w),
                              SizedBox(
                                width: 40.w,
                                child: Text(
                                  controller.courses?[index].fullName ?? '',
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
                                    "17 videos",
                                    style: TextStyle(
                                        fontSize: 9.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black.withOpacity(0.75)),
                                  ),
                                  Gap(width: 4.w),
                                  Text(
                                    "4 hr 20 min",
                                    style: TextStyle(
                                        fontSize: 9.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black.withOpacity(0.75)),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
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
                  Container(
                    height: 44.w,
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
                                      controller.courses?[index].image ?? ''),
                                  height: 26.w,
                                  width: 42.w,
                                ),
                              ),
                              Gap(height: 1.w),
                              SizedBox(
                                width: 40.w,
                                child: Text(
                                  controller.courses?[index].courseName ?? '',
                                  style: TextStyle(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withOpacity(0.9)),
                                ),
                              ),
                              Gap(height: 0.5.w),
                              Text(
                                controller.courses?[index].fullName ?? '',
                                style: TextStyle(
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.7)),
                              ),
                              Gap(height: 0.5.w),
                              Row(
                                children: [
                                  Text(
                                    "Raing Stars",
                                    style: TextStyle(
                                        fontSize: 9.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black.withOpacity(0.75)),
                                  ),
                                  Gap(width: 4.w),
                                  Text(
                                    "4.0",
                                    style: TextStyle(
                                        fontSize: 9.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black.withOpacity(0.75)),
                                  )
                                ],
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
