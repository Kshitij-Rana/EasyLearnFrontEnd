import 'package:e_learn/app/controller/user_detail_controller.dart';
import 'package:e_learn/app/modules/admin_home/controllers/admin_home_controller.dart';
import 'package:e_learn/app/routes/app_pages.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/admin_category_controller.dart';

class AdminCategoryView extends GetView<AdminCategoryController> {
  const AdminCategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var userdetailController = Get.find<UserDetailController>();
    var adminHomeController = Get.find<AdminHomeController>();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          title: const Text(
            'Add Category',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Obx(
          () => Container(
            height: 100.h,
            // padding: EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            child: GridView.builder(
              itemCount: userdetailController.category.length + 1,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 15, crossAxisSpacing: 15),
              itemBuilder: (context, index) {
                if (index < userdetailController.category.length) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.EDIT_CATEGORY,
                          arguments: userdetailController.category[index]);
                      // showDialog(
                      //   context: Get.context!,
                      //   builder: (context) {
                      //     return Dialog(
                      //       child: Container(
                      //         decoration: BoxDecoration(
                      //             color: Colors.white,
                      //             borderRadius: BorderRadius.circular(12)),
                      //         height: 35.w,
                      //         child: Column(
                      //           mainAxisAlignment:
                      //               MainAxisAlignment.spaceEvenly,
                      //           children: [
                      //             SizedBox(
                      //               width: 50.w,
                      //               child: CustomButton(
                      //                 title: "Delete",
                      //                 onPressed: () {},
                      //               ),
                      //             ),
                      //             SizedBox(
                      //               width: 50.w,
                      //               child: CustomButton(
                      //                 title: "Edit",
                      //                 onPressed: () {},
                      //               ),
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // );
                    },
                    child: Container(
                      height: 10.w,
                      width: 10.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white),
                      child: Column(
                        children: [
                          userdetailController.category[index].categoryImage ==
                                  ""
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child:
                                      Image.asset("assets/images/noImage.png"),
                                )
                              : Column(
                                  children: [
                                    Gap(height: 1.5.w),
                                    SizedBox(
                                      height: 21.w,
                                      width: 26.w,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          userdetailController.category[index]
                                                  .categoryImage ??
                                              '',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                          SizedBox(
                            width: 24.w,
                            height: 5.w,
                            child: Center(
                              child: Text(
                                userdetailController
                                        .category[index].categoryName ??
                                    'No category name',
                                style: TextStyle(fontSize: 11.sp),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: () {
                      adminHomeController.onAddCategory();
                    },
                    child: Container(
                      height: 10.w,
                      width: 10.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Icon(
                              Icons.add,
                              size: 60.sp,
                              color: Colors.grey,
                            ),
                          ),
                          Gap(height: 2.w),
                          SizedBox(
                            width: 24.w,
                            height: 5.w,
                            child: Center(
                              child: Text(
                                "Add Category",
                                style: TextStyle(fontSize: 11.sp),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ));
  }
}
