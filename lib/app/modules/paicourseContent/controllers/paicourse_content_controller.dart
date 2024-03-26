import 'dart:async';

import 'package:e_learn/app/models/course_content.dart';
import 'package:e_learn/app/models/courses.dart';
import 'package:e_learn/app/models/paid_courses.dart';
import 'package:e_learn/app/modules/addCourseContent/controllers/add_course_content_controller.dart';
import 'package:e_learn/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class PaicourseContentController extends GetxController {
  //TODO: Implement PaicourseContentController
  Duration? duration;
  Duration? position;
  Duration? fiveSecBehind;
  Duration? fiveSecFront;
  // var courses = Get.arguments as Courses;
  SharedPreferences? prefs;
  var progress = 0.0.obs;
  var videoLoading = false.obs;
  var isMute = false.obs;
  String videoUrl = '';
  final hour = "00".obs;
  final minute = "00".obs;
  final second = "00".obs;
  Timer? timer;

  final count = 0.obs;

  var videoPlaying = false.obs;
  var isInitialized = false.obs;
  var isLandScape = false.obs;
  RxBool isPaid = false.obs;
  var courses = Get.arguments as Paidcourse;
  var selectedUrl =
      'https://firebasestorage.googleapis.com/v0/b/easy-learn-8803a.appspot.com/o/2024-03-14%2015%3A06%3A38.558293VID-20240209-WA0042.mp4?alt=media&token=4b497356-1eea-4aeb-a9f7-77312e302d66'
          .obs;
  var length = 0;
  RxBool videoplayed = false.obs;
  var homecontroller = Get.find<HomepageController>();
  RxList<CourseContent>? courseContentCourseId = RxList<CourseContent>([]);
  late VideoPlayerController videoPlayerController;

  late List<RxBool> isClicked;
  late List<RxBool> isPlayed;

  void increment() => count.value++;
  void initializeIsClicked(int length) {
    isClicked = List.generate(length, (index) => RxBool(false));
  }

  void initializeIsPlayed(int length) {
    isPlayed = List.generate(length, (index) => RxBool(false));
  }

  String convertTwo(int value) {
    return value < 10 ? "0$value" : "$value";
  }

  void replayfiveSecBehind() {
    onScreenTouched();
    fiveSecBehind =
        videoPlayerController.value.duration - const Duration(seconds: 5);
    videoPlayerController.seekTo(fiveSecBehind!);
  }

  void replayfiveSecFront() {
    onScreenTouched();
    fiveSecFront =
        videoPlayerController.value.duration + const Duration(seconds: 5);
    videoPlayerController.seekTo(fiveSecFront!);
  }

  void initializeVideo() async {
    videoPlayerController =
        VideoPlayerController.contentUri(Uri.parse(selectedUrl.value))
          ..initialize().then((_) async {
            // await videoPlayerController.videoPlayerOptions!.webOptions!.controls;
            // videoPlayerController
            //     .videoPlayerOptions!.webOptions!.controls.allowPlaybackRate;

            videoPlayerController.pause();
            videoLoading.value = false;
            oncontrollerUpdate();
            update();
          })
          ..addListener(() {
            if (videoPlayerController.value.isPlaying) {
              videoLoading.value = true;
            }
          });
    update();
  }

  Future setAllOrientation() async {
    isLandScape.value = false;
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    Get.back;
  }

  Future setLandscape() async {
    onScreenTouched();
    // video();
    // Get.toNamed(Routes.VIDEO);
    update();
    isLandScape.value = true;
    await SystemChrome.restoreSystemUIOverlays();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void oncontrollerUpdate() async {
    duration ??= videoPlayerController.value.duration;
    var duration2 = duration;
    if (duration2 == null) return;
    var position1 = await videoPlayerController.position;
    position = position1;
    final playing = videoPlaying.value;
    if (playing) {
      progress.value = position1!.inMilliseconds.ceilToDouble() /
          duration2.inMilliseconds.ceilToDouble();
    }
    videoPlaying.value = playing;
    final durations = duration?.inSeconds ?? 0;
    final head = position?.inSeconds ?? 0;
    final remained = durations - head;
    final hours = convertTwo(remained ~/ 3600);

    final mins = convertTwo(remained ~/ 60.0);
    final secs = convertTwo(remained % 60);
    hour.value = hours;
    minute.value = mins;
    second.value = secs;
    update();
  }

  void onclickingplayIcon(int index) {
    for (int i = 0; i < isPlayed.length; i++) {
      isPlayed[i].value = false;
    }
    selectedUrl.value = "${courseContentCourseId?[index].contentVideo}";
    isPlayed[index].value = true;
    videoplayed.value = true;
    initializeVideo();
    isInitialized.value = true;
  }

  Widget videoPreviewWidget() {
    return AspectRatio(
      aspectRatio: 16 / 8,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          VideoPlayer(videoPlayerController),
          ClosedCaption(
            text: videoPlayerController.value.caption.text,
          ),
          VideoProgressIndicator(videoPlayerController, allowScrubbing: true),
        ],
      ),
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    // print("disposed");
    super.dispose();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    courseContentCourseId?.value = homecontroller.courseContent!
        .where((courseContent) => courseContent.courseId == courses.courseId)
        .toList();
    length = courseContentCourseId?.length ?? 0;
    initializeIsClicked(length);
    initializeIsPlayed(length);

    touchtime = Timer.periodic(Duration(seconds: 3), (Timer t) {
      istouched.value = false;
    });
    // print(courseContentCourseId);
    // print(homepageController.courseContent);
    // print(courses.courseId);
    super.onInit();
  }

  late Timer touchtime;
  Timer? _opacityTimer;

  RxBool istouched = false.obs;
  RxDouble opacity = 1.0.obs;
  // void showandHideVideoIcon() {
  //   print(istouched.value);
  //   if (istouched.value == true) {
  //     opacity.value = 1;
  //   } else {
  //     opacity.value = 0;
  //   }
  // }
  void onScreenTouched() {
    // Set istouched to true and opacity to 1 when the screen is touched
    istouched.value = true;
    opacity.value = 1.0;

    // Cancel any existing opacity timer to reset the timer
    _opacityTimer?.cancel();

    // Set a new timer to set opacity back to 0 after 3 seconds
    _opacityTimer = Timer(const Duration(seconds: 3), () {
      opacity.value = 0.0;
    });
  }
}
