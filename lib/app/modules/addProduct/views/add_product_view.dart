import 'package:dotted_border/dotted_border.dart';
import 'package:e_learn/app/customs/customTextField.dart';
import 'package:e_learn/app/customs/custom_body.dart';
import 'package:e_learn/app/customs/custom_button.dart';
import 'package:e_learn/app/modules/admin_home/controllers/admin_home_controller.dart';
import 'package:e_learn/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:e_learn/app/routes/app_pages.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  const AddProductView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var homeController = Get.find<HomepageController>();
    var adminhomecontroller = Get.find<AdminHomeController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Course'),
        centerTitle: true,
      ),
      body: Obx(
        () => adminhomecontroller.isAdded.value
            ? customBody(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gap(height: 10.w),
                    Center(
                      child: Text(
                        "Course Added Successfully",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.sp),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Now, You can go to your added course and add other course content",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: primaryTextColor.withOpacity(0.6),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Gap(height: 6.w),
                    Container(
                      height: 25.w,
                      width: 85.w,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12)),
                      child: const Column(
                        children: [],
                      ),
                    ),
                    Gap(height: 4.w),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 40.w,
                          height: 12.w,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  elevation: 0,
                                  backgroundColor:
                                      const Color.fromARGB(255, 228, 227, 227),
                                  foregroundColor:
                                      Colors.grey.withOpacity(0.2)),
                              onPressed: () {
                                Get.offNamed(Routes.ADMIN_MAIN);
                              },
                              child: Text(
                                "Back to Home",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8)),
                              )),
                        ),
                        // SizedBox(
                        //   width: 40.w,
                        //   child: CustomButton(
                        //     title: "Back to Home",
                        //     onPressed: () {},
                        //   ),
                        // ),
                        // SizedBox(
                        //   width: 40.w,
                        //   child: CustomButton(
                        //     title: "Add course contents",
                        //     onPressed: () {},
                        //   ),
                        // )
                        SizedBox(
                          width: 44.w,
                          height: 12.w,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  elevation: 0,
                                  backgroundColor: buttonColor.withOpacity(0.9),
                                  foregroundColor:
                                      Colors.grey.withOpacity(0.2)),
                              onPressed: () {
                                Get.toNamed(Routes.ADD_COURSE_CONTENT);
                              },
                              child: const Text(
                                "Add course contents",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : GetBuilder<AdminHomeController>(
                builder: (controller) => Form(
                    key: controller.productFormKey,
                    child: customBody(
                      isScrollable: true,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Add Course Image",
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.black.withOpacity(0.7),
                                fontWeight: FontWeight.w600),
                          ),
                          Gap(height: 1.w),
                          Text(
                            "Choose an image that will reflect your course",
                            style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.5)),
                          ),
                          Gap(height: 1.w),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.pickImage();
                                },
                                child: DottedBorder(
                                  borderPadding: const EdgeInsets.all(2.5),
                                  dashPattern: const [6],
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(12),
                                  strokeWidth: 1,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: controller.imagebytes.isEmpty
                                        ? Container(
                                            height: 16.w,
                                            width: 23.w,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                            ),
                                            child: Icon(
                                              Icons.add_a_photo_rounded,
                                              color:
                                                  Colors.black.withOpacity(0.7),
                                            ),
                                          )
                                        : Container(
                                            height: 16.w,
                                            width: 23.w,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                            ),
                                            child: Image(
                                              image: MemoryImage(
                                                  controller.imagebytes),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              controller.imagebytes.isEmpty
                                  ? const SizedBox.shrink()
                                  : GestureDetector(
                                      onTap: () {
                                        controller.pickImage();
                                      },
                                      child: Row(
                                        children: [
                                          Gap(width: 5.w),
                                          Text(
                                            "Edit",
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black
                                                    .withOpacity(0.7)),
                                          ),
                                          Gap(width: 1.w),
                                          Icon(
                                            size: 13.sp,
                                            Icons.add_a_photo_rounded,
                                            color: buttonColor.withOpacity(0.8),
                                          ),
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                          Gap(height: 3.w),
                          Text(
                            "Add Course Details",
                            style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.black.withOpacity(0.7),
                                fontWeight: FontWeight.w600),
                          ),
                          Gap(height: 3.w),
                          // CustomTextField(
                          //   textInputAction: TextInputAction.next,
                          //   title: "Select Course Category",
                          //   hintText: "Add Category",
                          //   controller: controller.categoryController,
                          // ),
                          homeController.category == null
                              ? const CircularProgressIndicator()
                              : SizedBox(
                                  height: 15.w,
                                  child: DropdownButtonFormField(
                                    isExpanded: true,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      enabled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6)),
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6)),
                                          borderSide:
                                              BorderSide(color: Colors.grey)),
                                    ),
                                    hint: const Text("Select Category"),
                                    items: homeController.category!
                                        .map((e) => DropdownMenuItem(
                                            value: e.categoryId,
                                            child: Text(e.categoryName ?? '')))
                                        .toList(),
                                    onChanged: (value) {
                                      controller.selectedCategory.value =
                                          value ?? '';
                                      // print(controller.selectedCategory.value);
                                    },
                                  ),
                                ),
                          // : SizedBox(
                          //     height: 14.w,
                          //     child: Container(
                          //       decoration: BoxDecoration(
                          //           color: Colors.white,
                          //           borderRadius: BorderRadius.circular(4),
                          //           border: Border.all(
                          //               color: Colors.grey.withOpacity(0.7),
                          //               width: 0.3.w)),
                          //       child: DropdownButtonHideUnderline(
                          //         child: SizedBox(
                          //           height: 14.w,
                          //           child: DropdownButton2<String>(
                          //             isExpanded: true,
                          //             hint: Text("Select Category"),
                          //             barrierColor:
                          //                 Colors.transparent.withOpacity(0.1),
                          //             items: homeController.category!
                          //                 .map((e) => DropdownMenuItem(
                          //                     value: e.categoryId,
                          //                     child: Text(
                          //                         e.categoryName ?? 'No Category')))
                          //                 .toList(),
                          //             onChanged: (value) {
                          //               controller.selectedCategory.value =
                          //                   value ?? '';
                          //               print(controller.selectedCategory.value);
                          //             },
                          //             value: controller.selectedCategory.value,
                          //             dropdownStyleData: DropdownStyleData(
                          //               maxHeight: 150,
                          //               elevation: 0,
                          //               decoration: BoxDecoration(
                          //                 color: Colors.white,
                          //               ),
                          //             ),
                          //           ),

                          //           // value: ,
                          //           // onChanged: (value) {
                          //           //   controller.projectType.value =
                          //           //       value.toString();
                          //           // },
                          //         ),
                          //       ),
                          //     ),
                          //   ),

                          Gap(height: 3.w),
                          CustomTextField(
                            textInputAction: TextInputAction.next,
                            title: "Course Name",
                            hintText: "Course Name",
                            controller: controller.courseNameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter your course name";
                              }
                              return null;
                            },
                          ),
                          Gap(height: 3.w),
                          CustomTextField(
                            title: "Price",
                            hintText: "Course Price",
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            controller: controller.coursePriceController,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(100000),
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter your course price";
                              }
                              return null;
                            },
                          ),
                          Gap(height: 3.w),
                          Text(
                            "Is your course online or offline?",
                            style: TextStyle(
                              fontSize: isTablet() ? 10.sp : 11.sp,
                              fontWeight: FontWeight.w500,
                              color: primaryTextColor.withOpacity(0.7),
                            ),
                          ),
                          Gap(height: 1.w),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.all(0),
                                title: Text(
                                  "Online",
                                  style: TextStyle(
                                    fontSize: 16.0, // Change font size
                                    fontWeight:
                                        FontWeight.bold, // Apply font weight
                                    color: primaryTextColor
                                        .withOpacity(0.8), // Change text color
                                  ),
                                ),
                                leading: Obx(() => Radio(
                                      value: 1,
                                      groupValue: controller.val.value,
                                      onChanged: (value) {
                                        controller.val.value = value!;
                                      },
                                      activeColor: Colors.green,
                                    )),
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.all(0),
                                title: Text(
                                  "Offline",
                                  style: TextStyle(
                                    fontSize: 16.0, // Change font size
                                    fontWeight:
                                        FontWeight.bold, // Apply font weight
                                    color: primaryTextColor
                                        .withOpacity(0.8), // Change text color
                                  ),
                                ),
                                leading: Obx(() => Radio(
                                      value: 0,
                                      groupValue: controller.val.value,
                                      onChanged: (value) {
                                        controller.val.value = value!;
                                      },
                                      activeColor: Colors.green,
                                    )),
                              ),
                            ],
                          ),
                          Gap(height: 3.w),
                          CustomTextField(
                            textInputAction: TextInputAction.done,
                            isMultiline: true,
                            title: "Course Description ",
                            hintText: "Enter description here",
                            controller: controller.courseDescriptionController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter your course description";
                              }
                              return null;
                            },
                          ),
                          Gap(height: 3.w),
                          CustomButton(
                            title: "Add Course",
                            onPressed: () {
                              controller.addProduct();
                            },
                          )
                        ],
                      ),
                    )),
              ),
      ),
    );
  }
}
