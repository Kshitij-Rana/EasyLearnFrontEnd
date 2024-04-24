import 'package:dotted_border/dotted_border.dart';
import 'package:e_learn/app/customs/customTextField.dart';
import 'package:e_learn/app/customs/custom_body.dart';
import 'package:e_learn/app/customs/custom_button.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/components/constants.dart';
import 'package:e_learn/components/delete_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/edit_category_controller.dart';

class EditCategoryView extends GetView<EditCategoryController> {
  const EditCategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Edit Category'),
        // centerTitle: true,
        backgroundColor: backgroundColor,
        title: const Text(
          'Edit Category',
          style: TextStyle(color: Colors.black),
        ),
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
              size: isTablet() ? 14.sp : 16.sp,
            )),
        elevation: 0,
        centerTitle: true,
      ),
      body: Form(
        key: controller.categoryFormKey,
        child: customBody(
          isScrollable: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Text(
              //   "Add Category",
              //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              // ),
              // Gap(height: 2.w),
              Text(
                'Category Image',
                style: TextStyle(
                  fontSize: isTablet() ? 10.sp : 11.sp,
                  fontWeight: FontWeight.w500,
                  color: primaryTextColor.withOpacity(0.7),
                ),
              ),
              Gap(height: 1.w),
              Obx(
                () => Center(
                  child: GestureDetector(
                    onTap: () {
                      controller.pickImage();
                    },
                    child: controller.url.value == ""
                        ? DottedBorder(
                            borderPadding: const EdgeInsets.all(1.6),
                            dashPattern: const [6],
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(12),
                            strokeWidth: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                  height: 50.w,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.2),
                                  ),
                                  child: Icon(
                                    Icons.add_a_photo_rounded,
                                    color: Colors.black.withOpacity(0.7),
                                  )),
                            ),
                          )
                        : Obx(
                            () => Center(
                              child: DottedBorder(
                                borderPadding: const EdgeInsets.all(1.5),
                                dashPattern: const [6],
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(12),
                                strokeWidth: 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    height: 50.w,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                    ),
                                    child: controller.imagebytes.value.isEmpty
                                        ? Image.network(controller.url.value,
                                            fit: BoxFit.cover)
                                        : Image.memory(
                                            controller.imagebytes.value,
                                            fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              Gap(height: 2.w),
              Center(
                child: CustomTextField(
                  title: "Category Name",
                  controller: controller.categoryController,
                  hintText: 'Category Name',
                ),
              ),
              Gap(height: 10.w),
              Center(
                child: Obx(
                  () => SizedBox(
                    width: 80.w,
                    height: 12.w,
                    child: CustomButton(
                      isLoading: controller.isLoading.value,
                      title: "Save",
                      onPressed: () {
                        controller.editCategory();
                      },
                    ),
                  ),
                ),
              ),
              Gap(height: 3.w),
              Center(
                child: SizedBox(
                  width: 80.w,
                  height: 12.w,
                  child: CustomButton(
                    color: Colors.red,
                    title: "Delete",
                    onPressed: () {
                      showCupertinoDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) {
                          return DeleteModal(
                              question: "Are you sure you want to delete?",
                              deleteFunction: controller.deleteCategory);
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
