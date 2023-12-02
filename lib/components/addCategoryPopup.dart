import 'package:e_learn/app/customs/customTextField.dart';
import 'package:e_learn/app/customs/custom_button.dart';
import 'package:e_learn/app/modules/admin_home/controllers/admin_home_controller.dart';
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
            width: 40.w,
            height: 60.w,
            decoration: const BoxDecoration(),
            child: Form(
              key: controller.categoryFormKey,
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Add Category",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),

                    SizedBox(
                      height: 30.w,
                      width: 60.w,
                      // child: TextFormField(
                      //   controller: controller.categoryController,
                      //   decoration: const InputDecoration(
                      //       hintText: "Enter category Name",
                      //       labelText: "Category Name",
                      //       border: OutlineInputBorder()),
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return "Please enter the category you want to enter";
                      //     }
                      //     return null;
                      //   },
                      // ),
                      child: CustomTextField(
                        controller: controller.categoryController,
                        hintText: 'Category Name',
                      ),
                    ),
                    // ElevatedButton(
                    //     onPressed: () {}, child: const Text('Add category')),
                    SizedBox(
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
                    Text(controller.addingCategoryLoading.value.toString())
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
