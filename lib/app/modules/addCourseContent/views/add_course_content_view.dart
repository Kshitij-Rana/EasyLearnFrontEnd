import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:e_learn/app/customs/customTextField.dart';
import 'package:e_learn/app/customs/custom_body.dart';
import 'package:e_learn/app/customs/custom_button.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

import '../controllers/add_course_content_controller.dart';

class AddCourseContentView extends GetView<AddCourseContentController> {
  const AddCourseContentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final duration = controller.duration?.inSeconds ?? 0;
    final head = controller.position?.inSeconds ?? 0;
    final remained = max(0, duration - head);
    final mins = controller.convertTwo(remained ~/ 60.0); //22 ~/ 7 = 3
    final secs = controller.convertTwo(remained %
        60); //22%7= 3.1 (% this symbol gets rid of the front part and return 1)

    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Course Content'),
          centerTitle: true,
        ),
        body: GetBuilder<AddCourseContentController>(
          builder: (controller) => customBody(
            isScrollable: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Course Thumb Nail",
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
                Gap(height: 2.w),
                Center(
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
                                        color: Colors.black.withOpacity(0.7),
                                      ),
                                    )),
                              )
                            : DottedBorder(
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
                                      image: MemoryImage(controller.imagebytes),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ))),
                Gap(height: 3.w),
                Text(
                  "Add Course Video",
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w600),
                ),
                Gap(height: 2.w),
                GestureDetector(
                  onTap: () {
                    controller.pickVideo();
                  },
                  child: controller.videobytes.isEmpty
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
                                  Icons.play_arrow_rounded,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              )
                              // : Container(
                              //     height: 16.w,
                              //     width: 23.w,
                              //     decoration: BoxDecoration(
                              //       color: Colors.grey.withOpacity(0.2),
                              //     ),
                              //     child: Image(
                              //       image: MemoryImage(controller.imagebytes),
                              //       fit: BoxFit.cover,
                              //     ),
                              //   ),
                              ),
                        )
                      : controller.isInitialized.value
                          ? Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    height: 50.w,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                    ),
                                    child: controller.videoPreviewWidget(),
                                  ),
                                ),
                                Positioned(
                                    right: 40.w,
                                    bottom: 20.w,
                                    child: Obx(
                                      () => controller.videoPlaying.value
                                          ? GestureDetector(
                                              onTap: () {
                                                controller.videoPlaying.value =
                                                    false;
                                                controller.videoPlayerController
                                                    .pause();
                                              },
                                              child: CircleAvatar(
                                                backgroundColor: Colors.white
                                                    .withOpacity(0.8),
                                                child: Icon(Icons.pause,
                                                    color: Colors.black),
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                controller.videoPlaying.value =
                                                    true;
                                                controller.videoPlayerController
                                                    .play();
                                                controller.oncontrollerUpdate();
                                              },
                                              child: CircleAvatar(
                                                backgroundColor: Colors.white
                                                    .withOpacity(0.8),
                                                child: Icon(Icons.play_arrow,
                                                    color: Colors.black),
                                              ),
                                            ),
                                    )),
                                Positioned(
                                    right: 10,
                                    bottom: 10,
                                    child: Obx(
                                      () => Row(
                                        children: [
                                          Text(
                                            "$mins:$secs",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Gap(width: 3.w),
                                          controller.isMute.value
                                              ? GestureDetector(
                                                  onTap: () {
                                                    controller
                                                        .videoPlayerController
                                                        .setVolume(1);
                                                    controller.isMute.value =
                                                        false;
                                                  },
                                                  child: Icon(Icons.volume_off,
                                                      color: Colors.white),
                                                )
                                              : GestureDetector(
                                                  onTap: () {
                                                    controller
                                                        .videoPlayerController
                                                        .setVolume(0);
                                                    controller.isMute.value =
                                                        true;
                                                  },
                                                  child: Icon(Icons.volume_up,
                                                      color: Colors.white),
                                                ),
                                          Gap(width: 2.w),
                                          controller.isLandScape.value
                                              ? GestureDetector(
                                                  onTap: () {
                                                    // controller
                                                    //     .controller!
                                                    //     .videoPlayerOptions!
                                                    //     .webOptions!
                                                    //     .controls
                                                    //     .allowFullscreen;
                                                    controller
                                                        .setAllOrientation();
                                                  },
                                                  child: Icon(
                                                    Icons.fullscreen_exit,
                                                    color: Colors.white,
                                                  ))
                                              : GestureDetector(
                                                  onTap: () {
                                                    // controller
                                                    //     .videoPlayerOptionsController
                                                    //     ?.webOptions
                                                    //     ?.controls
                                                    //     .allowFullscreen;
                                                    controller.setLandscape();
                                                  },
                                                  child: Icon(
                                                    Icons.fullscreen,
                                                    color: Colors.white,
                                                  )),
                                        ],
                                      ),
                                    )),
                                Positioned(
                                    right: 14.w,
                                    bottom: 22.w,
                                    child: GestureDetector(
                                      onTap: () {
                                        // controller.videoPlayerController
                                        //     .seekTo();
                                      },
                                      child: Icon(
                                        Icons.replay_5_rounded,
                                        color: Colors.white,
                                        size: 19.sp,
                                      ),
                                    )),
                                Positioned(
                                    left: 14.w,
                                    bottom: 22.w,
                                    child: Icon(
                                      Icons.replay_5_rounded,
                                      color: Colors.white,
                                      size: 19.sp,
                                    )),
                                Positioned(
                                    left: 1.w,
                                    top: 1.w,
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return SizedBox(
                                              height: 10.w,
                                              child: Dialog(
                                                child: SizedBox(
                                                  height: 30.w,
                                                  child: Column(
                                                    children: [
                                                      Text("0.5X"),
                                                      Text("1X"),
                                                      Text("1.5X"),
                                                      Text("2X")
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Icon(
                                        Icons.playlist_play_rounded,
                                        color: Colors.white,
                                      ),
                                    ))
                              ],
                            )
                          : Container(
                              height: 50.w,
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                              ),
                              // child: CustomVideoPlayer(
                              //   customVideoPlayerController:
                              //       controller.customVideoPlayerController,
                              // ),
                            ),
                ),
                // Text(
                //   "Choose an image that will reflect your course",
                //   style: TextStyle(
                //       fontSize: 10.sp,
                //       fontWeight: FontWeight.w600,
                //       color: Colors.black.withOpacity(0.5)),
                // ),
                // Gap(height: 1.w),
                // CupertinoButton(
                //   child: const Text("Play Fullscreen"),
                //   onPressed: () {
                //     controller.customVideoPlayerController.setFullscreen(true);
                //     controller.customVideoPlayerController.videoPlayerController
                //         .play();
                //   },
                // ),
                Gap(height: 3.w),
                Text(
                  "Add Course Details",
                  style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w600),
                ),
                Gap(height: 3.w),
                CustomTextField(
                  textInputAction: TextInputAction.next,
                  title: "Select Course Title",
                  hintText: "Add Title",
                  controller: controller.titleController,
                ),
                Gap(height: 3.w),

                CustomTextField(
                  textInputAction: TextInputAction.done,
                  title: "Reference Link ",
                  hintText: "Enter link here",
                  controller: controller.linkController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your course description";
                    }
                    return null;
                  },
                ),
                Gap(height: 3.w),

                CustomTextField(
                  textInputAction: TextInputAction.done,
                  isMultiline: true,
                  title: "Course Description ",
                  hintText: "Enter description here",
                  controller: controller.descriptionController,
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
                    // controller.addProduct();
                  },
                ),
                // CustomButton(
                //   title: "Dispose",
                //   onPressed: () {
                //     controller.dispose();
                //   },
                // )
              ],
            ),
          ),
        ));
  }
}
