import 'dart:async';
import 'dart:math';

import 'package:e_learn/app/modules/addCourseContent/controllers/add_course_content_controller.dart';
import 'package:e_learn/app/modules/paicourseContent/bindings/paicourse_content_binding.dart';
import 'package:e_learn/app/modules/paicourseContent/controllers/paicourse_content_controller.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class VideoPlauer extends StatefulWidget {
  const VideoPlauer({
    super.key,
  });

  @override
  State<VideoPlauer> createState() => _VideoPlauerState();
}

class _VideoPlauerState extends State<VideoPlauer> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PaicourseContentController>();
    return

        // controller.isInitialized.value
        //     ?
        Obx(
      () => GestureDetector(
        onTap: () {
          controller.onScreenTouched();
        },
        child: Stack(
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
              child: AnimatedOpacity(
                duration: Duration(seconds: 1),
                opacity: controller.opacity.value,
                child: controller.videoPlaying.value
                    ? GestureDetector(
                        onTap: () {
                          controller.onScreenTouched();
                          controller.videoPlaying.value = false;
                          controller.videoPlayerController.pause();
                          controller.timer?.cancel();
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.8),
                          child: const Icon(Icons.pause, color: Colors.black),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          controller.onScreenTouched();

                          controller.videoPlaying.value = true;
                          controller.videoPlayerController.play();
                          controller.oncontrollerUpdate();
                          controller.timer = Timer.periodic(
                              const Duration(seconds: 1),
                              (Timer t) => controller.oncontrollerUpdate());
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.8),
                          child:
                              const Icon(Icons.play_arrow, color: Colors.black),
                        ),
                      ),
              ),
            ),
            Positioned(
                right: 10,
                bottom: 10,
                child: Obx(
                  () => AnimatedOpacity(
                    opacity: controller.opacity.value,
                    duration: Duration(seconds: 1),
                    child: Row(
                      children: [
                        Text(
                          "${controller.minute}:${controller.second}",
                          style: const TextStyle(color: Colors.white),
                        ),
                        Gap(width: 3.w),
                        controller.isMute.value
                            ? GestureDetector(
                                onTap: () {
                                  controller.onScreenTouched();

                                  controller.videoPlayerController.setVolume(1);
                                  controller.isMute.value = false;
                                },
                                child: const Icon(Icons.volume_off,
                                    color: Colors.white),
                              )
                            : GestureDetector(
                                onTap: () {
                                  controller.videoPlayerController.setVolume(0);
                                  controller.isMute.value = true;
                                },
                                child: const Icon(Icons.volume_up,
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
                                  controller.setAllOrientation();
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
                  ),
                )),
            Positioned(
                right: 14.w,
                bottom: 22.w,
                child: Obx(
                  () => AnimatedOpacity(
                    duration: Duration(seconds: 1),
                    opacity: controller.opacity.value,
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
                    ),
                  ),
                )),
            Positioned(
                left: 14.w,
                bottom: 22.w,
                child: AnimatedOpacity(
                  duration: Duration(seconds: 1),
                  opacity: controller.opacity.value,
                  child: GestureDetector(
                    onTap: () {
                      controller.replayfiveSecBehind();
                    },
                    child: Icon(
                      Icons.replay_5_rounded,
                      color: Colors.white,
                      size: 19.sp,
                    ),
                  ),
                )),
            Positioned(
                left: 1.w,
                top: 1.w,
                child: AnimatedOpacity(
                  duration: Duration(seconds: 1),
                  opacity: controller.opacity.value,
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
                  ),
                )),
            Positioned(
                bottom: 1,
                child: AnimatedOpacity(
                  duration: Duration(seconds: 1),
                  opacity: controller.opacity.value,
                  child: SizedBox(
                    width: 90.w,
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Colors.red[700],
                          inactiveTrackColor: Colors.red[100],
                          trackShape: RoundedRectSliderTrackShape(),
                          trackHeight: 2.0,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 6.0),
                          thumbColor: Colors.redAccent,
                          overlayColor: Colors.red.withAlpha(32),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 10.0),
                          tickMarkShape: RoundSliderTickMarkShape(),
                          activeTickMarkColor: Colors.red[700],
                          inactiveTickMarkColor: Colors.red[100],
                          valueIndicatorShape:
                              PaddleSliderValueIndicatorShape(),
                          valueIndicatorColor: Colors.redAccent,
                          valueIndicatorTextStyle:
                              TextStyle(color: Colors.white)),
                      child: Slider(
                        value: max(0, min(controller.progress * 100, 100)),
                        min: 0,
                        max: 100,
                        divisions: 100,
                        label: controller.position?.toString().split(".")[0],
                        onChanged: (value) {
                          controller.progress.value = value * 0.01;
                        },
                        onChangeStart: (value) {
                          controller?.videoPlayerController.pause();
                        },
                        onChangeEnd: (value) {
                          final duration =
                              controller.videoPlayerController.value.duration;
                          if (duration != null) {
                            var newValue = max(0, min(value, 99)) * 0.01;
                            var milis =
                                (duration.inMilliseconds * newValue).toInt();
                            controller.videoPlayerController
                                .seekTo(Duration(milliseconds: milis));
                            controller.videoPlayerController.play();
                          }
                        },
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
    // :
    //  Container(
    //     height: 55.w,
    //     width: 90.w,
    //     decoration: BoxDecoration(
    //       color: Colors.grey.withOpacity(0.2),
    //     ),
    //     // child: CustomVideoPlayer(
    //     //   customVideoPlayerController:
    //     //       controller.customVideoPlayerController,
    //     // ),
    // );
  }
}
