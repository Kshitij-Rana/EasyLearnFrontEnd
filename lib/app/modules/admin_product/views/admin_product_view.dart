import 'package:e_learn/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:e_learn/app/routes/app_pages.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/app/views/myCourses.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/admin_product_controller.dart';

class AdminProductView extends GetView<AdminProductController> {
  const AdminProductView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var homepageCOntroller = Get.find<HomepageController>();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          title: const Text(
            'Add Courses',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Obx(
          () => Column(
            children: [
              SizedBox(
                width: 95.w,
                height: 151.w,
                child: ListView.builder(
                  itemCount:
                      homepageCOntroller.coursesAddedByInstructor?.length ?? 0,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return MyCourses(
                        course: homepageCOntroller
                            .coursesAddedByInstructor![index]);
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.ADD_PRODUCT);
                  // GetPage(
                  //   name: Routes.ADD_PRODUCT,
                  //   page: () => AddProductView(),
                  //   binding: AddProductBinding(),
                  //   transition: Transition.fadeIn,
                  //   transitionDuration: Duration(milliseconds: 700),
                  // );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      size: 50.sp,
                      color: Colors.grey,
                    ),
                    Text(
                      "Add a New Course",
                      style: TextStyle(fontSize: 13.sp, color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
