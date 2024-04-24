import 'package:dotted_border/dotted_border.dart';
import 'package:e_learn/app/customs/customTextField.dart';
import 'package:e_learn/app/customs/custom_body.dart';
import 'package:e_learn/app/customs/custom_button.dart';
import 'package:e_learn/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/edit_courses_admin_controller.dart';

class EditCoursesAdminView extends GetView<EditCoursesAdminController> {
  const EditCoursesAdminView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var homeController = Get.find<HomepageController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Course'),
        centerTitle: true,
      ),
      body: GetBuilder<EditCoursesAdminController>(
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
                          child: Obx(
                            () => ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: controller.imagebytes.isEmpty
                                  ? controller.url.value == ''
                                      ? Container(
                                          height: 16.w,
                                          width: 23.w,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.2),
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
                                            color: Colors.grey.withOpacity(0.2),
                                          ),
                                          child: Image(
                                            image: NetworkImage(getImageUrl(
                                                controller.url.value)),
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                  : Container(
                                      height: 16.w,
                                      width: 23.w,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.2),
                                      ),
                                      child: Image(
                                        image:
                                            MemoryImage(controller.imagebytes),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                      controller.imagebytes.isEmpty
                          ? controller.url.value == ''
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
                                            color:
                                                Colors.black.withOpacity(0.7)),
                                      ),
                                      Gap(width: 1.w),
                                      Icon(
                                        size: 13.sp,
                                        Icons.add_a_photo_rounded,
                                        color: buttonColor.withOpacity(0.8),
                                      ),
                                    ],
                                  ),
                                )
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
                                        color: Colors.black.withOpacity(0.7)),
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
                            dropdownColor: Colors
                                .white, // Set the dropdown background color to white

                            isExpanded: true,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              enabled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  borderSide: BorderSide(color: Colors.grey)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  borderSide: BorderSide(color: Colors.grey)),
                            ),
                            hint: Text(controller.selectedcategoryName),
                            items: homeController.category!
                                .map((e) => DropdownMenuItem(
                                    value: e.categoryId,
                                    child: Text(e.categoryName ?? '')))
                                .toList(),
                            onChanged: (value) {
                              controller.selectedCategory.value = value ?? '';
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
                        contentPadding: const EdgeInsets.all(0),
                        title: Text(
                          "Online",
                          style: TextStyle(
                            fontSize: 16.0, // Change font size
                            fontWeight: FontWeight.bold, // Apply font weight
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
                        contentPadding: const EdgeInsets.all(0),
                        title: Text(
                          "Offline",
                          style: TextStyle(
                            fontSize: 16.0, // Change font size
                            fontWeight: FontWeight.bold, // Apply font weight
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

                  Obx(
                    () => Form(
                        key: controller.offlineFormKey,
                        child: Column(
                          children: [
                            Gap(height: 3.w),
                            controller.val.value == 0
                                ? CustomTextField(
                                    textInputAction: TextInputAction.next,
                                    title: "Location",
                                    hintText: "Rautahat,Nepal",
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter your location";
                                      }
                                      return null;
                                    },
                                    controller: controller.locationController)
                                : const SizedBox.shrink(),
                            Gap(height: 3.w),
                            controller.val.value == 0
                                ? CustomTextField(
                                    keyboardType: TextInputType.phone,
                                    textInputAction: TextInputAction.done,
                                    title: "Contact No",
                                    hintText: "9806XXXXXX",
                                    controller: controller.contactController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Enter your phone number";
                                      }
                                      return null;
                                    },
                                  )
                                : const SizedBox.shrink(),
                            controller.val.value == 0
                                ? Gap(height: 10.w)
                                : const SizedBox.shrink(),
                          ],
                        )),
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
                    title: "Edit",
                    isLoading: controller.isLoading.value,
                    onPressed: () {
                      controller.onEditButtonCLicked();
                    },
                  )
                ],
              ),
            )),
      ),
    );
  }
}
