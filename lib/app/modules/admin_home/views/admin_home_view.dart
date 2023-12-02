import 'package:e_learn/app/customs/statsCard.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/admin_home_controller.dart';

class AdminHomeView extends GetView<AdminHomeController> {
  const AdminHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(AdminHomeController());
    return Scaffold(
      //     body: GetBuilder<AdminHomeController>(builder: (controller) {
      //   // if
      //   // return RefreshIndicator(child: child, onRefresh: () {

      //   // },)
      //   return Text("data");
      // })
      body: SafeArea(
        child: Column(
          children: [
            const Center(child: Text("Dashboard")),
            Gap(height: 4.w),
            Container(
              height: 144.w,
              margin: const EdgeInsets.all(10),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 5, crossAxisSpacing: 5),
                children: [
                  StatsCard(
                      label: "Total Users",
                      value: "3",
                      icon: Icon(Icons.people)),
                  StatsCard(
                      label: "Total Courses",
                      value: "4",
                      icon: Icon(Icons.menu_book_rounded)),
                  StatsCard(
                      label: "Total Orders",
                      value: "7",
                      icon: Icon(Icons.production_quantity_limits_rounded)),
                  StatsCard(
                    isAmount: true,
                    label: "Total Income",
                    value: "3000",
                    icon: Icon(Icons.attach_money_outlined),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.onAddCategory();
                    },
                    child: StatsCard(
                        label: "Add Category",
                        value: "",
                        icon: Icon(Icons.attach_money_outlined)),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: StatsCard(
                        label: "Add Courses",
                        value: "",
                        icon: Icon(Icons.attach_money_outlined)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
