import 'dart:async';
import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:e_learn/app/customs/customTextField.dart';
import 'package:e_learn/app/customs/custom_body.dart';
import 'package:e_learn/app/customs/custom_button.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/edit_course_content_controller.dart';

class EditCourseContentView extends GetView<EditCourseContentController> {
  const EditCourseContentView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Course Content'),
          centerTitle: true,
        ),
        body: GetBuilder<EditCourseContentController>(
          builder: (controller) => customBody(
            isScrollable: true,
            child: Form(
              key: controller.courseFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Edit Course Video",
                    style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.black.withOpacity(0.7),
                        fontWeight: FontWeight.w600),
                  ),
                  Gap(height: 2.w),
                  Builder(builder: (context) {
                    return Obx(
                      () => controller.videobytes.isEmpty
                          ? controller.videoUrl == ""
                              ? controller.isLoading.value
                                  ? DottedBorder(
                                      borderPadding: const EdgeInsets.all(2.5),
                                      dashPattern: const [6],
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(12),
                                      strokeWidth: 1,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Container(
                                            height: 50.w,
                                            width: Get.width,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                            ),
                                            child: Icon(
                                              Icons.play_arrow_rounded,
                                              color:
                                                  Colors.black.withOpacity(0.7),
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
                                  : Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Container(
                                            height: 50.w,
                                            width: Get.width,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                            ),
                                            child:
                                                controller.videoPreviewWidget(),
                                          ),
                                        ),
                                        Positioned(
                                            right: 40.w,
                                            bottom: 20.w,
                                            child: Obx(
                                              () => controller
                                                      .videoPlaying.value
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        controller.videoPlaying
                                                            .value = false;
                                                        controller
                                                            .videoPlayerController
                                                            .pause();
                                                        controller.timer
                                                            ?.cancel();
                                                      },
                                                      child: CircleAvatar(
                                                        backgroundColor: Colors
                                                            .white
                                                            .withOpacity(0.8),
                                                        child: const Icon(
                                                            Icons.pause,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    )
                                                  : GestureDetector(
                                                      onTap: () {
                                                        controller.videoPlaying
                                                            .value = true;
                                                        controller
                                                            .videoPlayerController
                                                            .play();
                                                        controller
                                                            .oncontrollerUpdate();
                                                        controller.timer =
                                                            Timer.periodic(
                                                                const Duration(
                                                                    seconds: 1),
                                                                (Timer t) =>
                                                                    controller
                                                                        .oncontrollerUpdate());
                                                      },
                                                      child: CircleAvatar(
                                                        backgroundColor: Colors
                                                            .white
                                                            .withOpacity(0.8),
                                                        child: const Icon(
                                                            Icons.play_arrow,
                                                            color:
                                                                Colors.black),
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
                                                    "${controller.minute}:${controller.second}",
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  Gap(width: 3.w),
                                                  controller.isMute.value
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            controller
                                                                .videoPlayerController
                                                                .setVolume(1);
                                                            controller.isMute
                                                                .value = false;
                                                          },
                                                          child: const Icon(
                                                              Icons.volume_off,
                                                              color:
                                                                  Colors.white),
                                                        )
                                                      : GestureDetector(
                                                          onTap: () {
                                                            controller
                                                                .videoPlayerController
                                                                .setVolume(0);
                                                            controller.isMute
                                                                .value = true;
                                                          },
                                                          child: const Icon(
                                                              Icons.volume_up,
                                                              color:
                                                                  Colors.white),
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
                                                          child: const Icon(
                                                            Icons
                                                                .fullscreen_exit,
                                                            color: Colors.white,
                                                          ))
                                                      : GestureDetector(
                                                          onTap: () {
                                                            // controller
                                                            //     .videoPlayerOptionsController
                                                            //     ?.webOptions
                                                            //     ?.controls
                                                            //     .allowFullscreen;
                                                            controller
                                                                .setLandscape();
                                                          },
                                                          child: const Icon(
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
                                                controller.replayfiveSecFront();
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
                                            child: GestureDetector(
                                              onTap: () {
                                                controller
                                                    .replayfiveSecBehind();
                                              },
                                              child: Icon(
                                                Icons.replay_5_rounded,
                                                color: Colors.white,
                                                size: 19.sp,
                                              ),
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
                                                          child: const Column(
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
                                              child: const Icon(
                                                Icons.playlist_play_rounded,
                                                color: Colors.white,
                                              ),
                                            )),
                                        Positioned(
                                            bottom: 1,
                                            child: SizedBox(
                                              width: 90.w,
                                              child: SliderTheme(
                                                data: SliderTheme.of(context).copyWith(
                                                    activeTrackColor:
                                                        Colors.red[700],
                                                    inactiveTrackColor:
                                                        Colors.red[100],
                                                    trackShape:
                                                        const RoundedRectSliderTrackShape(),
                                                    trackHeight: 2.0,
                                                    thumbShape:
                                                        const RoundSliderThumbShape(
                                                            enabledThumbRadius:
                                                                6.0),
                                                    thumbColor:
                                                        Colors.redAccent,
                                                    overlayColor: Colors.red
                                                        .withAlpha(32),
                                                    overlayShape: const RoundSliderOverlayShape(
                                                        overlayRadius: 10.0),
                                                    tickMarkShape:
                                                        const RoundSliderTickMarkShape(),
                                                    activeTickMarkColor:
                                                        Colors.red[700],
                                                    inactiveTickMarkColor:
                                                        Colors.red[100],
                                                    valueIndicatorShape:
                                                        const PaddleSliderValueIndicatorShape(),
                                                    valueIndicatorColor:
                                                        Colors.redAccent,
                                                    valueIndicatorTextStyle:
                                                        const TextStyle(
                                                            color: Colors.white)),
                                                child: Slider(
                                                  value: max(
                                                      0,
                                                      min(
                                                          controller.progress *
                                                              100,
                                                          100)),
                                                  min: 0,
                                                  max: 100,
                                                  divisions: 100,
                                                  label: controller.position
                                                      ?.toString()
                                                      .split(".")[0],
                                                  onChanged: (value) {
                                                    controller.progress.value =
                                                        value * 0.01;
                                                  },
                                                  onChangeStart: (value) {
                                                    controller
                                                        .videoPlayerController
                                                        .pause();
                                                  },
                                                  onChangeEnd: (value) {
                                                    final duration = controller
                                                        .videoPlayerController
                                                        .value
                                                        .duration;
                                                    var newValue =
                                                        max(0, min(value, 99)) *
                                                            0.01;
                                                    var milis = (duration
                                                                .inMilliseconds *
                                                            newValue)
                                                        .toInt();
                                                    controller
                                                        .videoPlayerController
                                                        .seekTo(Duration(
                                                            milliseconds:
                                                                milis));
                                                    controller
                                                        .videoPlayerController
                                                        .play();
                                                  },
                                                ),
                                              ),
                                            ))
                                      ],
                                    )
                              : Stack(
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
                                                    controller.videoPlaying
                                                        .value = false;
                                                    controller
                                                        .videoPlayerController
                                                        .pause();
                                                    controller.timer?.cancel();
                                                  },
                                                  child: CircleAvatar(
                                                    backgroundColor: Colors
                                                        .white
                                                        .withOpacity(0.8),
                                                    child: const Icon(
                                                        Icons.pause,
                                                        color: Colors.black),
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () {
                                                    controller.videoPlaying
                                                        .value = true;
                                                    controller
                                                        .videoPlayerController
                                                        .play();
                                                    controller
                                                        .oncontrollerUpdate();
                                                    controller.timer = Timer.periodic(
                                                        const Duration(
                                                            seconds: 1),
                                                        (Timer t) => controller
                                                            .oncontrollerUpdate());
                                                  },
                                                  child: CircleAvatar(
                                                    backgroundColor: Colors
                                                        .white
                                                        .withOpacity(0.8),
                                                    child: const Icon(
                                                        Icons.play_arrow,
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
                                                "${controller.minute}:${controller.second}",
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              Gap(width: 3.w),
                                              controller.isMute.value
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .videoPlayerController
                                                            .setVolume(1);
                                                        controller.isMute
                                                            .value = false;
                                                      },
                                                      child: const Icon(
                                                          Icons.volume_off,
                                                          color: Colors.white),
                                                    )
                                                  : GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .videoPlayerController
                                                            .setVolume(0);
                                                        controller.isMute
                                                            .value = true;
                                                      },
                                                      child: const Icon(
                                                          Icons.volume_up,
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
                                                      child: const Icon(
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
                                                        controller
                                                            .setLandscape();
                                                      },
                                                      child: const Icon(
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
                                            controller.replayfiveSecFront();
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
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.replayfiveSecBehind();
                                          },
                                          child: Icon(
                                            Icons.replay_5_rounded,
                                            color: Colors.white,
                                            size: 19.sp,
                                          ),
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
                                                      child: const Column(
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
                                          child: const Icon(
                                            Icons.playlist_play_rounded,
                                            color: Colors.white,
                                          ),
                                        )),
                                    Positioned(
                                        bottom: 1,
                                        child: SizedBox(
                                          width: 90.w,
                                          child: SliderTheme(
                                            data: SliderTheme.of(context).copyWith(
                                                activeTrackColor:
                                                    Colors.red[700],
                                                inactiveTrackColor:
                                                    Colors.red[100],
                                                trackShape:
                                                    const RoundedRectSliderTrackShape(),
                                                trackHeight: 2.0,
                                                thumbShape:
                                                    const RoundSliderThumbShape(
                                                        enabledThumbRadius:
                                                            6.0),
                                                thumbColor: Colors.redAccent,
                                                overlayColor:
                                                    Colors.red.withAlpha(32),
                                                overlayShape:
                                                    const RoundSliderOverlayShape(
                                                        overlayRadius: 10.0),
                                                tickMarkShape:
                                                    const RoundSliderTickMarkShape(),
                                                activeTickMarkColor:
                                                    Colors.red[700],
                                                inactiveTickMarkColor:
                                                    Colors.red[100],
                                                valueIndicatorShape:
                                                    const PaddleSliderValueIndicatorShape(),
                                                valueIndicatorColor:
                                                    Colors.redAccent,
                                                valueIndicatorTextStyle:
                                                    const TextStyle(
                                                        color: Colors.white)),
                                            child: Slider(
                                              value: max(
                                                  0,
                                                  min(controller.progress * 100,
                                                      100)),
                                              min: 0,
                                              max: 100,
                                              divisions: 100,
                                              label: controller.position
                                                  ?.toString()
                                                  .split(".")[0],
                                              onChanged: (value) {
                                                controller.progress.value =
                                                    value * 0.01;
                                              },
                                              onChangeStart: (value) {
                                                controller.videoPlayerController
                                                    .pause();
                                              },
                                              onChangeEnd: (value) {
                                                final duration = controller
                                                    .videoPlayerController
                                                    .value
                                                    .duration;
                                                var newValue =
                                                    max(0, min(value, 99)) *
                                                        0.01;
                                                var milis =
                                                    (duration.inMilliseconds *
                                                            newValue)
                                                        .toInt();
                                                controller.videoPlayerController
                                                    .seekTo(Duration(
                                                        milliseconds: milis));
                                                controller.videoPlayerController
                                                    .play();
                                              },
                                            ),
                                          ),
                                        ))
                                  ],
                                )
                          : Stack(
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
                                                controller.timer?.cancel();
                                              },
                                              child: CircleAvatar(
                                                backgroundColor: Colors.white
                                                    .withOpacity(0.8),
                                                child: const Icon(Icons.pause,
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
                                                controller.timer = Timer.periodic(
                                                    const Duration(seconds: 1),
                                                    (Timer t) => controller
                                                        .oncontrollerUpdate());
                                              },
                                              child: CircleAvatar(
                                                backgroundColor: Colors.white
                                                    .withOpacity(0.8),
                                                child: const Icon(
                                                    Icons.play_arrow,
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
                                            "${controller.minute}:${controller.second}",
                                            style: const TextStyle(
                                                color: Colors.white),
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
                                                  child: const Icon(
                                                      Icons.volume_off,
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
                                                  child: const Icon(
                                                      Icons.volume_up,
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
                                                  child: const Icon(
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
                                                  child: const Icon(
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
                                        controller.replayfiveSecFront();
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
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.replayfiveSecBehind();
                                      },
                                      child: Icon(
                                        Icons.replay_5_rounded,
                                        color: Colors.white,
                                        size: 19.sp,
                                      ),
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
                                                  child: const Column(
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
                                      child: const Icon(
                                        Icons.playlist_play_rounded,
                                        color: Colors.white,
                                      ),
                                    )),
                                Positioned(
                                    bottom: 1,
                                    child: SizedBox(
                                      width: 90.w,
                                      child: SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                            activeTrackColor: Colors.red[700],
                                            inactiveTrackColor: Colors.red[100],
                                            trackShape:
                                                const RoundedRectSliderTrackShape(),
                                            trackHeight: 2.0,
                                            thumbShape:
                                                const RoundSliderThumbShape(
                                                    enabledThumbRadius: 6.0),
                                            thumbColor: Colors.redAccent,
                                            overlayColor:
                                                Colors.red.withAlpha(32),
                                            overlayShape:
                                                const RoundSliderOverlayShape(
                                                    overlayRadius: 10.0),
                                            tickMarkShape:
                                                const RoundSliderTickMarkShape(),
                                            activeTickMarkColor:
                                                Colors.red[700],
                                            inactiveTickMarkColor:
                                                Colors.red[100],
                                            valueIndicatorShape:
                                                const PaddleSliderValueIndicatorShape(),
                                            valueIndicatorColor:
                                                Colors.redAccent,
                                            valueIndicatorTextStyle:
                                                const TextStyle(
                                                    color: Colors.white)),
                                        child: Slider(
                                          value: max(
                                              0,
                                              min(controller.progress * 100,
                                                  100)),
                                          min: 0,
                                          max: 100,
                                          divisions: 100,
                                          label: controller.position
                                              ?.toString()
                                              .split(".")[0],
                                          onChanged: (value) {
                                            controller.progress.value =
                                                value * 0.01;
                                          },
                                          onChangeStart: (value) {
                                            controller.videoPlayerController
                                                .pause();
                                          },
                                          onChangeEnd: (value) {
                                            final duration = controller
                                                .videoPlayerController
                                                .value
                                                .duration;
                                            var newValue =
                                                max(0, min(value, 99)) * 0.01;
                                            var milis =
                                                (duration.inMilliseconds *
                                                        newValue)
                                                    .toInt();
                                            controller.videoPlayerController
                                                .seekTo(Duration(
                                                    milliseconds: milis));
                                            controller.videoPlayerController
                                                .play();
                                          },
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                    );
                  }),
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
                  TextButton(
                      onPressed: () {
                        controller.pickVideo();
                      },
                      child: Text("Edit Video")),
                  Gap(height: 3.w),
                  Text(
                    "Edit Course Details",
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
                  Obx(
                    () => CustomButton(
                      isLoading: controller.isLoading.value,
                      title: "Edit Course Content",
                      onPressed: () {
                        controller.onContentEdit();
                      },
                    ),
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
          ),
        ));
  }
}
