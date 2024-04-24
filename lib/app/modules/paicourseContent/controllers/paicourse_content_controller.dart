import 'dart:async';
import 'dart:convert';
import 'package:e_learn/app/models/progress_tracking.dart';
import 'package:e_learn/app/models/quiz.dart';
import 'package:e_learn/app/models/quizMarks.dart';
import 'package:http/http.dart' as http;

import 'package:e_learn/app/models/course_content.dart';
import 'package:e_learn/app/models/paid_courses.dart';
import 'package:e_learn/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:e_learn/components/constants.dart';
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
  RxBool isSubmitted = false.obs;
  // var courses = Get.arguments as Courses;
  SharedPreferences? prefs;
  var progress = 0.0.obs;
  var videoLoading = false.obs;
  var isMute = false.obs;
  RxBool isCourseCompleted = false.obs;
  RxString courseSelected = ''.obs;
  RxInt selectedOption = 1.obs;
  String videoUrl = '';
  final hour = "00".obs;
  final minute = "00".obs;
  final second = "00".obs;
  Timer? timer;
  bool _isVideoCompleted = false; // Add this flag to track video completion
  RxInt score = 0.obs;
  final count = 0.obs;

  var videoPlaying = false.obs;
  var isInitialized = false.obs;
  var isLandScape = false.obs;
  RxBool isPaid = false.obs;

  var courses = Get.arguments as Paidcourse;
  var selectedUrl = ''.obs;
  var length = 0;
  RxBool videoplayed = false.obs;
  var homecontroller = Get.find<HomepageController>();
  RxList<CourseContent>? courseContentCourseId = RxList<CourseContent>([]);
  RxList<ProgressTracking>? progressTracking = RxList<ProgressTracking>([]);
  RxList<Quiz>? quizz = RxList<Quiz>([]);
  RxList<QuizMarks>? quizMarks = RxList<QuizMarks>([]);

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
    // Calculate the new position by subtracting 5 seconds from the current position
    Duration newPosition =
        videoPlayerController.value.position - const Duration(seconds: 5);
    // Ensure the new position is not less than 0
    newPosition = newPosition < Duration.zero ? Duration.zero : newPosition;
    videoPlayerController.seekTo(newPosition);
  }

  void replayfiveSecFront() {
    onScreenTouched();
    // Calculate the new position by adding 5 seconds to the current position
    Duration newPosition =
        videoPlayerController.value.position + const Duration(seconds: 5);
    // Ensure the new position is not more than the video's duration
    newPosition = newPosition > videoPlayerController.value.duration
        ? videoPlayerController.value.duration
        : newPosition;
    videoPlayerController.seekTo(newPosition);
  }

  Future<void> initializeVideo(String lessonId) async {
    videoPlayerController =
        VideoPlayerController.contentUri(Uri.parse(selectedUrl.value))
          ..addListener(() {
            if (!_isVideoCompleted &&
                videoPlayerController.value.position ==
                    videoPlayerController.value.duration) {
              _isVideoCompleted =
                  true; // Set the flag to true when the video completes
              addProgress(lessonId);
            }
          })
          ..initialize().then((_) async {
            videoPlayerController.pause();
            videoLoading.value = false;
            oncontrollerUpdate();
            update();
            await loadLastWatchedPosition(); // Load the last watched position
          })
          ..addListener(() {
            if (videoPlayerController.value.isPlaying) {
              videoLoading.value = true;
            }
          });

    update();
  }

  Future<void> addProgress(String lessonId) async {
    var url = Uri.http(ipaddress, "finalyearproject_api/lessontracking.php");

    var response = await http.post(url, body: {
      'token': prefs!.getString('token')!,
      'progress_number': '100',
      'lesson_id': lessonId,
    });
    var data = jsonDecode(response.body);
    if (data['success']) {
      await addCOurseContent();
      update();
    } else {}
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
    duration = videoPlayerController.value.duration;
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

    // Save the last watched position when the video is paused or ends
    if (!videoPlaying.value) {
      saveLastWatchedPosition();
    }
  }

  Future<void> onclickingplayIcon(int index, String lessonId) async {
    for (int i = 0; i < isPlayed.length; i++) {
      isPlayed[i].value = false;
    }
    selectedUrl.value = "${courseContentCourseId?[index].contentVideo}";
    isPlayed[index].value = true;
    videoplayed.value = true;
    await initializeVideo(lessonId);
    isInitialized.value = true;
  }

  void checkAnswer(int currentQuizIndex) {
    if (selectedOption.value == 1) {
      courseSelected.value = quizz!.value[currentQuizIndex].option1 ?? '';
    } else if (selectedOption.value == 2) {
      courseSelected.value = quizz!.value[currentQuizIndex].option2 ?? '';
    } else if (selectedOption.value == 3) {
      courseSelected.value = quizz!.value[currentQuizIndex].option3 ?? '';
    } else if (selectedOption.value == 4) {
      courseSelected.value = quizz!.value[currentQuizIndex].option4 ?? '';
    }

    if (quizz!.value[currentQuizIndex].correctOption == courseSelected.value) {
      score.value += 1;
    }
  }

  Future<void> addMarks() async {
    var url = Uri.http(ipaddress, "finalyearproject_api/addQuizMarks.php");
    var response = await http.post(url, body: {
      'token': prefs!.getString('token')!,
      'obtained_marks': score.value.toString(),
      'course_id': courses.courseId,
      'full_marks': quizz!.length.toString()
    });
    var data = jsonDecode(response.body);
    if (data['success']) {
      await getMarks();
      Get.showSnackbar(GetSnackBar(
        message: data['message'],
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ));
    } else {
      Get.showSnackbar(GetSnackBar(
        message: data['message'],
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ));
    }
  }

  Future<void> getMarks() async {
    var url = Uri.http(ipaddress, "finalyearproject_api/getQuizMarks.php");
    var response = await http.post(url, body: {
      'token': prefs!.getString('token'),
      'course_id': courses.courseId,
    });
    var data = jsonDecode(response.body);
    if (data['success']) {
      quizMarks?.value = quizMarksFromJson(jsonEncode(data['data']));
      Future.delayed(const Duration(seconds: 2));
      // Get.showSnackbar(GetSnackBar(
      //   message: data['message'],
      //   backgroundColor: Colors.green,
      //   duration: const Duration(seconds: 3),
      // ));
    } else {
      Get.showSnackbar(GetSnackBar(
        message: data['message'],
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ));
    }
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

  Future<void> getQuiz(String courseId) async {
    try {
      var url = Uri.http(ipaddress, 'finalyearproject_api/getQuiz.php');
      var response = await http.post(url,
          body: {'token': prefs!.getString('token'), 'course_id': courseId});
      var result = jsonDecode(response.body);
      if (result['success']) {
        // Get.showSnackbar(GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: result['message'],
        //     duration: const Duration(seconds: 3)));
        quizz?.value = quizFromJson(jsonEncode(result['data']));
        update();
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: "hya Bigriyo hai",
        duration: Duration(seconds: 3),
      ));
    }
  }

  Future<void> getLessonTracking() async {
    try {
      var url =
          Uri.http(ipaddress, 'finalyearproject_api/getLessonTracking.php');
      var response =
          await http.post(url, body: {'token': prefs!.getString('token')});
      var result = jsonDecode(response.body);
      if (result['success']) {
        // Get.showSnackbar(GetSnackBar(
        //     backgroundColor: Colors.green,
        //     message: result['message'],
        //     duration: const Duration(seconds: 3)));
        progressTracking?.value =
            progressTrackingFromJson(jsonEncode(result['data']));
        update();
      } else {
        Get.showSnackbar(GetSnackBar(
          backgroundColor: Colors.red,
          message: result['message'],
          duration: const Duration(seconds: 3),
        ));
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: "hya Bigriyo hai",
        duration: Duration(seconds: 3),
      ));
    }
  }

  Future<void> addCOurseContent() async {
    await getLessonTracking();

    courseContentCourseId?.value = homecontroller.courseContent!
        .where((courseContent) => courseContent.courseId == courses.courseId)
        .toList();
    isCourseCompleted.value = allcontentswatched();
  }

  bool allcontentswatched() {
    return courseContentCourseId?.value.every((courseContent) =>
            progressTracking?.value.any(
                (element) => element.lessonId == courseContent.contentId) ??
            false) ??
        false;
  }

  @override
  Future<void> onInit() async {
    prefs = await SharedPreferences.getInstance();

    await getMarks();

    await addCOurseContent();
    length = courseContentCourseId?.length ?? 0;
    initializeIsClicked(length);
    initializeIsPlayed(length);
    touchtime = Timer.periodic(const Duration(seconds: 3), (Timer t) {
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
  Future<void> saveLastWatchedPosition() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(
        '${courses.courseId}.lastWatchedPosition',
        double.parse(
            videoPlayerController.value.position.inSeconds.toString()));
  }

  Future<void> loadLastWatchedPosition() async {
    final prefs = await SharedPreferences.getInstance();
    final lastWatchedPosition =
        prefs.getDouble('${courses.courseId}.lastWatchedPosition');
    if (lastWatchedPosition != null) {
      videoPlayerController
          .seekTo(Duration(seconds: lastWatchedPosition.toInt()));
    }
  }

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
