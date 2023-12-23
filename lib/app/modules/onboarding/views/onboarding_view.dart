import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: controller.pageController,
          children: controller.pages,
          onPageChanged: (value) {
            controller.currentIndex.value = value;
            if (controller.currentIndex.value == controller.pages.length - 1) {
              controller.onLastPage.value = true;
            } else {
              controller.onLastPage.value = false;
            }
          },
        ),
        Obx(
          () => Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Skip
                GestureDetector(
                    onTap: () {
                      controller.backpage();
                    },
                    child: Text(
                      "Back",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp,
                          color: Colors.white),
                    )),
                // Dots Indicator
                SmoothPageIndicator(
                    effect: const ExpandingDotsEffect(
                      activeDotColor: Colors.deepPurple,
                    ),
                    controller: controller.pageController,
                    count: controller.pages.length),

                // Next and done
                controller.onLastPage.value
                    ? const SizedBox(
                        width: 35,
                      )
                    // GestureDetector(
                    //     onTap: () {
                    //       Get.toNamed(
                    //         Routes.,
                    //       );
                    //     },
                    //     child: Text(
                    //       "Done",
                    //       style: TextStyle(
                    //           fontWeight: FontWeight.w500,
                    //           fontSize: 15.sp,
                    //           color: Colors.white),
                    //     ))
                    : GestureDetector(
                        onTap: () {
                          controller.nextPage();
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp,
                              color: Colors.white),
                        ))
              ],
            ),
          ),
        ),
        Obx(
          () => Positioned(
            top: 5.h,
            right: 5.w,
            child: controller.onLastPage.value
                ? const SizedBox()
                : GestureDetector(
                    onTap: () {
                      controller.pageController
                          .jumpToPage(controller.pages.length - 1);
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp,
                          color: Colors.white),
                    )),
          ),
        ),
      ],
    ));
  }
}
