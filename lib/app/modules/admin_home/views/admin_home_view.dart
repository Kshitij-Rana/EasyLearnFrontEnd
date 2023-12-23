import 'package:e_learn/app/customs/custom_body.dart';
import 'package:e_learn/app/customs/statsCard.dart';
import 'package:e_learn/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:e_learn/app/routes/app_pages.dart';
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
      body: customBody(
        isScrollable: true,
        child: SafeArea(
          child: Column(
            children: [
              Center(
                  child: Text("Dashboard",
                      style: TextStyle(
                          fontSize: 17.sp, fontWeight: FontWeight.w500))),
              Gap(height: 4.w),
              Container(
                height: 80.h,
                margin: const EdgeInsets.all(10),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5),
                  children: [
                    const StatsCard(
                        label: "Total Users",
                        value: "3",
                        icon: Icon(Icons.people)),
                    const StatsCard(
                        label: "Total Courses",
                        value: "4",
                        icon: Icon(Icons.menu_book_rounded)),
                    const StatsCard(
                        label: "Total Orders",
                        value: "7",
                        icon: Icon(Icons.production_quantity_limits_rounded)),
                    const StatsCard(
                      isAmount: true,
                      label: "Total Income",
                      value: "3000",
                      icon: Icon(Icons.attach_money_outlined),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.onAddCategory();
                      },
                      child: const StatsCard(
                          label: "Add Category",
                          value: "",
                          icon: Icon(Icons.attach_money_outlined)),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.ADD_PRODUCT);
                      },
                      child: const StatsCard(
                          label: "Add Courses",
                          value: "",
                          icon: Icon(Icons.attach_money_outlined)),
                    ),
                    GestureDetector(
                      onTap: () async {
                        Get.toNamed(Routes.ADD_COURSE_CONTENT);
                      },
                      child: const StatsCard(
                          label: "Add C.content",
                          value: "",
                          icon: Icon(Icons.attach_money_outlined)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
