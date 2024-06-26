import 'package:e_learn/app/customs/customRefreshIndicator.dart';
import 'package:e_learn/app/customs/custom_body.dart';
import 'package:e_learn/app/customs/statsCard.dart';
import 'package:e_learn/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:e_learn/app/routes/app_pages.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:sizer/sizer.dart';

import '../controllers/admin_home_controller.dart';

class AdminHomeView extends GetView<AdminHomeController> {
  const AdminHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(HomepageController());

    Get.put(AdminHomeController());
    return Scaffold(
      //     body: GetBuilder<AdminHomeController>(builder: (controller) {
      //   // if
      //   // return RefreshIndicator(child: child, onRefresh: () {

      //   // },)
      //   return Text("data");
      // })
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Dashboard',
              style: TextStyle(color: Colors.black),
            ),
            Gap(width: 2.w),
            Icon(
              FontAwesome.dashboard,
              color: const Color(0xffDCBFFF),
              size: 12.5.sp,
            )
          ],
        ),
        centerTitle: true,
      ),
      body: customBody(
        isScrollable: true,
        child: CustomRefreshIndicator(
          onRefresh: () {
            return controller.onRefresh();
          },
          child: Column(
            children: [
              SizedBox(
                height: 95.w,
                // margin: const EdgeInsets.all(10),
                child: GetBuilder<AdminHomeController>(
                  builder: (controller) => GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15),
                    children: [
                      StatsCard(
                        color: const Color(0xffDCBFFF),
                        label: "Total Users",
                        value: "${controller.totalUsers}",
                        icon:
                            const Icon(Icons.people, color: Color(0xff140F1A)),
                      ),
                      StatsCard(
                          color: const Color(0xffDCBFFF),
                          label: "Total Courses",
                          value: "${controller.totalCourses}",
                          icon: const Icon(Icons.menu_book_rounded,
                              color: Color(0xff140F1A))),
                      StatsCard(
                          color: const Color(0xffDCBFFF),
                          label: "Total Orders",
                          value: "${controller.totalPaidOrders}",
                          icon: const Icon(
                              Icons.production_quantity_limits_rounded,
                              color: Color(0xff140F1A))),
                      StatsCard(
                        color: const Color(0xffDCBFFF),
                        isAmount: true,
                        label: "Total Income",
                        value: "${controller.totalIncome}",
                        icon: const Icon(Icons.attach_money_outlined,
                            color: Color(0xff140F1A)),
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     controller.onAddCategory();
                      //   },
                      //   child: const StatsCard(
                      //       label: "Add Category",
                      //       value: "",
                      //       icon: Icon(Icons.attach_money_outlined)),
                      // ),
                      // GestureDetector(
                      //   onTap: () {
                      //     Get.toNamed(Routes.ADD_PRODUCT);
                      //   },
                      //   child: const StatsCard(
                      //       label: "Add Courses",
                      //       value: "",
                      //       icon: Icon(Icons.attach_money_outlined)),
                      // ),
                      // GestureDetector(
                      //   onTap: () async {
                      //     Get.toNamed(Routes.ADD_COURSE_CONTENT);
                      //   },
                      //   child: const StatsCard(
                      //       label: "Add C.content",
                      //       value: "",
                      //       icon: Icon(Icons.attach_money_outlined)),
                      // )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.USER_DETAIL,
                      arguments: controller.paidCourseList);
                },
                child: Text(
                  "View Details",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 182, 131, 243),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
