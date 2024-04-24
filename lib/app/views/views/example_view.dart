// import 'package:e_learn/app/customs/custom_body.dart';
// import 'package:e_learn/app/modules/homepage/controllers/homepage_controller.dart';
// import 'package:e_learn/app/routes/app_pages.dart';
// import 'package:e_learn/app/utils/colors.dart';
// import 'package:e_learn/components/constants.dart';
// import 'package:e_learn/components/delete_modal.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';

// import '../controllers/coursecontent_controller.dart';

// class CoursecontentView extends GetView<CoursecontentController> {
//   final bool isAdmin;
//   const CoursecontentView({this.isAdmin = false, Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     var homepageController = Get.find<HomepageController>();
//     return GetBuilder<CoursecontentController>(
//       builder: (controller) => Scaffold(
//           appBar: AppBar(
//             backgroundColor: backgroundColor,
//             leading: GestureDetector(
//                 onTap: () {
//                   Get.back();
//                 },
//                 child: const Icon(
//                   Icons.arrow_back_ios_new_sharp,
//                   color: Colors.black,
//                 )),
//             title: Text(
//               controller.courses.courseName ?? '',
//               style: const TextStyle(color: Colors.black),
//             ),
//           ),
//           body: customBody(
//               isScrollable: true,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     width: 90.w,
//                     height: 55.w,
//                     decoration: BoxDecoration(
//                         color: const Color.fromARGB(255, 206, 205, 205)
//                             .withOpacity(1),
//                         borderRadius: BorderRadius.circular(13),
//                         boxShadow: [
//                           BoxShadow(
//                               blurRadius: 1,
//                               color: Colors.grey.withOpacity(0.4),
//                               offset: const Offset(1, 2),
//                               spreadRadius: 1),
//                         ]),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(13),
//                       child: Image.network(
//                         getImageUrl(controller.courses.image ?? ''),
//                         height: 26.w,
//                         width: 42.w,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   Gap(height: 5.w),
//                   controller.isPaid.value == false
//                       ? Text(
//                           "3. How to unlock mobile phone?",
//                           style: TextStyle(
//                               fontSize: 14.sp,
//                               color: Colors.black.withOpacity(0.8),
//                               fontWeight: FontWeight.bold),
//                         )
//                       : const SizedBox.shrink(),
//                   Gap(height: 3.w),
//                   controller.isPaid.value == false
//                       ? Text(
//                           "Video Details",
//                           style: TextStyle(
//                               fontSize: 14.sp,
//                               color: Colors.black.withOpacity(0.8),
//                               fontWeight: FontWeight.bold),
//                         )
//                       : Text(
//                           "Course Details",
//                           style: TextStyle(
//                               fontSize: 14.sp,
//                               color: Colors.black.withOpacity(0.8),
//                               fontWeight: FontWeight.bold),
//                         ),
//                   Gap(height: 3.w),
//                   Text(
//                     controller.courses.description ?? '',
//                     style: TextStyle(
//                         fontSize: 12.5.sp,
//                         color: Colors.black.withOpacity(0.55),
//                         fontWeight: FontWeight.w500),
//                   ),
//                   Gap(height: 4.w),
//                   controller.courses.isOnline == "0"
//                       ? const SizedBox.shrink()
//                       : Text(
//                           "Lesson's Content",
//                           style: TextStyle(
//                               fontSize: 14.sp,
//                               color: Colors.black.withOpacity(0.8),
//                               fontWeight: FontWeight.bold),
//                         ),
//                   controller.courses.isOnline == "0"
//                       ? Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Location",
//                               style: TextStyle(
//                                   fontSize: 14.sp,
//                                   color: Colors.black.withOpacity(0.8),
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             Gap(height: 2.w),
//                             Text(
//                               controller.courses.location ?? '',
//                               style: TextStyle(
//                                   fontSize: 12.5.sp,
//                                   color: Colors.black.withOpacity(0.55),
//                                   fontWeight: FontWeight.w500),
//                             ),
//                             Gap(height: 2.w),
//                             Text(
//                               "Contact No",
//                               style: TextStyle(
//                                   fontSize: 14.sp,
//                                   color: Colors.black.withOpacity(0.8),
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             Gap(height: 2.w),
//                             Row(
//                               children: [
//                                 Text(
//                                   controller.courses.ConactNo ?? '',
//                                   style: TextStyle(
//                                       fontSize: 12.5.sp,
//                                       color: Colors.black.withOpacity(0.55),
//                                       fontWeight: FontWeight.w500),
//                                 ),
//                                 IconButton(
//                                     onPressed: () {
//                                       controller.openPhoneCall();
//                                     },
//                                     icon: Icon(
//                                       Icons.call,
//                                       color: Colors.green.shade300,
//                                     ))
//                               ],
//                             )
//                           ],
//                         )
//                       : const SizedBox.shrink(),
//                   Gap(height: 2.w),
//                   ListView.builder(
//                     physics: const NeverScrollableScrollPhysics(),
//                     shrinkWrap: true,
//                     itemCount: controller.courseContentCourseId?.length ?? 0,
//                     itemBuilder: (context, index) {
//                       return Obx(
//                         () => GestureDetector(
//                           onTap: () {
//                             if (controller.isClicked[index].value == false) {
//                               controller.isClicked[index].value = true;
//                             } else {
//                               controller.isClicked[index].value = false;
//                             }
//                           },
//                           child: AnimatedContainer(
//                             duration: const Duration(milliseconds: 200),
//                             child: Stack(
//                               children: [
//                                 Container(
//                                   padding: const EdgeInsets.all(8),
//                                   margin: EdgeInsets.symmetric(
//                                       vertical: 2.w, horizontal: 1.w),
//                                   height:
//                                       controller.isClicked[index].value == false
//                                           ? 16.5.w
//                                           : 25.w,
//                                   width: Get.width,
//                                   decoration: BoxDecoration(
//                                       color: Colors.green.shade100,
//                                       borderRadius: BorderRadius.circular(7),
//                                       boxShadow: [
//                                         BoxShadow(
//                                             blurRadius: 1,
//                                             blurStyle: BlurStyle.normal,
//                                             color: Colors.grey.withOpacity(0.4),
//                                             offset: const Offset(1, 2),
//                                             spreadRadius: 1)
//                                       ]),
//                                   child: Row(
//                                     children: [
//                                       Gap(width: 1.w),
//                                       Align(
//                                         alignment:
//                                             controller.isClicked[index].value ==
//                                                     true
//                                                 ? Alignment.topCenter
//                                                 : Alignment.center,
//                                         child: CircleAvatar(
//                                           backgroundColor: Colors.white,
//                                           child: Icon(
//                                             Icons.play_arrow_rounded,
//                                             color: bottomnavigationBarColor,
//                                           ),
//                                         ),
//                                       ),
//                                       Gap(width: 3.w),
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Text(
//                                                 '${(index + 1).toString()}.',
//                                                 style: TextStyle(
//                                                     fontSize: 12.sp,
//                                                     fontWeight:
//                                                         FontWeight.w500),
//                                               ),
//                                               Gap(width: 1.w),
//                                               SizedBox(
//                                                 height: 5.w,
//                                                 width: 52.w,
//                                                 child: Text(
//                                                   controller
//                                                           .courseContentCourseId?[
//                                                               index]
//                                                           .contentName ??
//                                                       "No content",
//                                                   style: TextStyle(
//                                                       fontSize: 12.sp,
//                                                       fontWeight:
//                                                           FontWeight.w500),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           Gap(height: 1.w),
//                                           Text(
//                                             formatTime(controller
//                                                     .courseContentCourseId?[
//                                                         index]
//                                                     .contentDuration ??
//                                                 "00:00"),
//                                             style: TextStyle(
//                                                 color: Colors.black
//                                                     .withOpacity(0.8),
//                                                 fontSize: 11.sp),
//                                           ),
//                                           controller.isClicked[index].value ==
//                                                   true
//                                               ? SizedBox(
//                                                   width: 60.w,
//                                                   child: Text(
//                                                       controller
//                                                               .courseContentCourseId?[
//                                                                   index]
//                                                               .contentDescription ??
//                                                           "No description",
//                                                       style: TextStyle(
//                                                           overflow: TextOverflow
//                                                               .ellipsis,
//                                                           color: Colors.black
//                                                               .withOpacity(0.8),
//                                                           fontSize: 11.sp)),
//                                                 )
//                                               : const SizedBox.shrink(),
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                                 Positioned(
//                                     left: 75.w,
//                                     top: 5.w,
//                                     child: homepageController.role == "admin" ||
//                                             homepageController.role ==
//                                                 "instructor"
//                                         ? SizedBox(
//                                             height: 9.w,
//                                             child: Center(
//                                               child: PopupMenuButton<String>(
//                                                 icon: const Icon(
//                                                   Icons.more_vert,
//                                                   color: Colors.black,
//                                                 ), // Change to Icons.more_horiz if you prefer horizontal dots
//                                                 onSelected: (String value) {
//                                                   if (value == 'edit') {
//                                                     Get.toNamed(
//                                                         Routes
//                                                             .EDIT_COURSE_CONTENT,
//                                                         arguments: controller
//                                                                 .courseContentCourseId![
//                                                             index]);
//                                                   } else if (value ==
//                                                       'delete') {
//                                                     showCupertinoDialog(
//                                                       barrierDismissible: true,
//                                                       context: context,
//                                                       builder: (context) {
//                                                         return DeleteModal(
//                                                           question:
//                                                               "Are you sure you want to delete this course content?",
//                                                           deleteFunction: () {
//                                                             controller.deleteCourseContent(
//                                                                 int.parse(controller
//                                                                         .courses
//                                                                         .courseId ??
//                                                                     "0"),
//                                                                 int.parse(controller
//                                                                         .courseContentCourseId!
//                                                                         .value[
//                                                                             index]
//                                                                         .contentId ??
//                                                                     "0"));
//                                                             Get.back();
//                                                           },
//                                                         );
//                                                       },
//                                                     );
//                                                     // Implement your delete functionality here
//                                                   }
//                                                 },

//                                                 itemBuilder: (context) =>
//                                                     <PopupMenuEntry<String>>[
//                                                   const PopupMenuItem<String>(
//                                                     value: 'edit',
//                                                     child: Text('Edit'),
//                                                   ),
//                                                   const PopupMenuItem<String>(
//                                                     value: 'delete',
//                                                     child: Text('Delete'),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           )
//                                         : const SizedBox.shrink()),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                   homepageController.role == "admin" ||
//                           homepageController.role == "instructor"
//                       ? controller.courses.isOnline == "0"
//                           ? const SizedBox.shrink()
//                           : GestureDetector(
//                               onTap: () {
//                                 Get.toNamed(Routes.ADD_COURSE_CONTENT,
//                                     arguments: controller.courses);
//                                 // GetPage(
//                                 //   name: Routes.ADD_COURSE_CONTENT,
//                                 //   page: () => AddCourseContentView(),
//                                 //   binding: AddCourseContentBinding(),
//                                 //   transition: Transition.fadeIn,
//                                 //   transitionDuration: Duration(milliseconds: 700),
//                                 // );
//                               },
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Icon(
//                                     Icons.add,
//                                     size: 50.sp,
//                                     color: Colors.grey,
//                                   ),
//                                   Gap(width: 2.h),
//                                   Text(
//                                     "Add a Course Content",
//                                     style: TextStyle(
//                                         fontSize: 13.sp, color: Colors.black),
//                                     overflow: TextOverflow.ellipsis,
//                                   )
//                                 ],
//                               ),
//                             )
//                       : const SizedBox.shrink(),
//                 ],
//               ))),
//     );
//   }
// }
