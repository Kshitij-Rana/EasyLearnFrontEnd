import 'package:dotted_border/dotted_border.dart';
import 'package:e_learn/app/customs/customTextField.dart';
import 'package:e_learn/app/customs/custom_button.dart';
import 'package:e_learn/app/modules/admin_home/controllers/admin_home_controller.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddCategoryPopup extends StatelessWidget {
  const AddCategoryPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: GetBuilder<AdminHomeController>(
        builder: (controller) => Dialog(
          child: Container(
            // padding: EdgeInsets.only(left: 18),
            width: 40.w,
            height: 110.w,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Form(
              key: controller.categoryFormKey,
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(height: 2.w),
                    Center(
                      child: const Text(
                        "Add Category",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                    Gap(height: 2.w),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        'Category Image',
                        style: TextStyle(
                          fontSize: isTablet() ? 10.sp : 11.sp,
                          fontWeight: FontWeight.w500,
                          color: primaryTextColor.withOpacity(0.7),
                        ),
                      ),
                    ),
                    Gap(height: 1.w),
                    Center(
                      child: SizedBox(
                        height: 40.w,
                        width: 60.w,
                        child: GestureDetector(
                            onTap: () {
                              controller.pickImage();
                            },
                            child: controller.imagebytes.isEmpty
                                ? DottedBorder(
                                    borderPadding: const EdgeInsets.all(2.5),
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
                                            color:
                                                Colors.black.withOpacity(0.7),
                                          ),
                                        )),
                                  )
                                : Center(
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
                                          child: Image(
                                            image: MemoryImage(
                                                controller.imagebytes),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                      ),
                    ),
                    Gap(height: 2.w),
                    Center(
                      child: SizedBox(
                        height: 30.w,
                        width: 60.w,
                        child: CustomTextField(
                          title: "Category Name",
                          controller: controller.categoryController,
                          hintText: 'Category Name',
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        width: 40.w,
                        height: 12.w,
                        child: CustomButton(
                          isLoading: controller.addingCategoryLoading.value,
                          title: "Add Category",
                          onPressed: () {
                            controller.addCategory();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
