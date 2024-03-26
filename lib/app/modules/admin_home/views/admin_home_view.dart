import 'package:e_learn/app/customs/customRefreshIndicator.dart';
import 'package:e_learn/app/customs/custom_body.dart';
import 'package:e_learn/app/customs/statsCard.dart';
import 'package:e_learn/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
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
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.black),
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
                height: 80.h,
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
                        color: Color(0xffDCBFFF),
                        label: "Total Users",
                        value: "${controller.totalUsers}",
                        icon: Icon(Icons.people, color: Color(0xff140F1A)),
                      ),
                      StatsCard(
                          color: Color(0xffDCBFFF),
                          label: "Total Courses",
                          value: "${controller.totalCourses}",
                          icon: Icon(Icons.menu_book_rounded,
                              color: Color(0xff140F1A))),
                      StatsCard(
                          color: Color(0xffDCBFFF),
                          label: "Total Orders",
                          value: "${controller.totalPaidOrders}",
                          icon: Icon(Icons.production_quantity_limits_rounded,
                              color: Color(0xff140F1A))),
                      StatsCard(
                        color: Color(0xffDCBFFF),
                        isAmount: true,
                        label: "Total Income",
                        value: "${controller.totalIncome}",
                        icon: Icon(Icons.attach_money_outlined,
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
            ],
          ),
        ),
      ),
    );
  }
}
