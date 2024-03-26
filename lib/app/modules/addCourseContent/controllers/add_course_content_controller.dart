import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:e_learn/app/models/courses.dart';
import 'package:e_learn/app/modules/coursecontent/controllers/coursecontent_controller.dart';
import 'package:e_learn/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:http/http.dart' as http;

import 'package:e_learn/app/controller/user_detail_controller.dart';
import 'package:e_learn/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class AddCourseContentController extends GetxController {
  GlobalKey<FormState> courseFormKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late VideoPlayerController videoPlayerController;
  Duration? duration;
  Duration? position;
  Duration? fiveSecBehind;
  Duration? fiveSecFront;
  var courses = Get.arguments as Courses;
  SharedPreferences? prefs;
  var progress = 0.0.obs;
  var videoLoading = false.obs;
  var isMute = false.obs;
  var videoPlaying = false.obs;
  var isInitialized = false.obs;
  var isLandScape = false.obs;
  var task;
  String videoUrl = '';
  final hour = "00".obs;
  final minute = "00".obs;
  final second = "00".obs;
  final count = 0.obs;
  var picker = ImagePicker();
  //for image
  XFile? image;
  var imagebytes = Uint8List(0);
  //for video
  XFile? video;
  var videobytes = Uint8List(0);

  // void dispose() {
  //   customVideoPlayerController.dispose();
  //   super.dispose();
  // }
  Timer? timer;
  String convertTwo(int value) {
    return value < 10 ? "0$value" : "$value";
  }

  @override
  Future<void> onInit() async {
    prefs = await SharedPreferences.getInstance();
    super.onInit();
  }

  void replayfiveSecBehind() {
    fiveSecBehind =
        videoPlayerController.value.duration - const Duration(seconds: 5);
    videoPlayerController.seekTo(fiveSecBehind!);
  }

  void replayfiveSecFront() {
    fiveSecFront =
        videoPlayerController.value.duration + const Duration(seconds: 5);
    videoPlayerController.seekTo(fiveSecFront!);
  }

//for video players
  void initializeVideo() async {
    videoPlayerController = VideoPlayerController.file(File(video!.path))
      ..initialize().then((_) async {
        // await videoPlayerController.videoPlayerOptions!.webOptions!.controls;
        // videoPlayerController
        //     .videoPlayerOptions!.webOptions!.controls.allowPlaybackRate;

        videoPlayerController.pause();
        videoPlaying.value = false;
        oncontrollerUpdate();
        update();
      })
      ..addListener(() {
        if (videoPlayerController.value.isPlaying) {
          videoPlaying.value = true;
        }
      });
  }

  Future setAllOrientation() async {
    isLandScape.value = false;
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    Get.back;
  }

  Future setLandscape() async {
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

  void pickImage() async {
    try {
      image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        imagebytes = await image!.readAsBytes();
        update();
      }
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          message: "Image upload failed:{$e}",
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> pickVideo() async {
    videoLoading.value = true;
    try {
      video = await picker.pickVideo(source: ImageSource.gallery);
      if (video == null) {
        // User cancelled the operation
        Get.showSnackbar(
          const GetSnackBar(
            message: "No video selected",
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }
      initializeVideo();
      isInitialized.value = true;
      videobytes = await video!.readAsBytes();
      update();
      Get.showSnackbar(
        const GetSnackBar(
          message: "Video uploaded",
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
    } catch (e) {
      Get.showSnackbar(
        const GetSnackBar(
          message: "Image upload failed",
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
    videoLoading.value = false;
  }

  void onAddCourseContent() async {
    if (courseFormKey.currentState!.validate()) {
      try {
        // var url;
        if (video != null) {
          final storageref = FirebaseStorage.instance.ref();
          final videoRef =
              storageref.child(DateTime.now().toString() + video!.name);
          task = await videoRef.putFile(File(video!.path));
          videoUrl = await videoRef.getDownloadURL();
          // url = videoUrl;
          // dispose();
          // Get.find<UserDetailController>().getCourseContent();
          update();
        }

        try {
          if (courseFormKey.currentState!.validate()) {
            var url = Uri.http(
                ipaddress, "finalyearproject_api/addcourseContent.php");
            var response = await http.post(url, body: {
              'token': prefs!.getString('token')!,
              'content_name': titleController.text,
              'content_description': descriptionController.text,
              'course_id': courses.courseId.toString(),
              'content_video': videoUrl,
              'content_duration': "$hour:$minute:$second"
            });

            var data = jsonDecode(response.body);
            // print(data['success']);
            // print(data['message']);
            if (data['success']) {
              Get.back(closeOverlays: true);
              Get.showSnackbar(GetSnackBar(
                message: data['message'],
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 3),
              ));
              update();
            } else {
              Get.showSnackbar(GetSnackBar(
                message: data['message'],
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ));
            }
          } else {
            Get.showSnackbar(const GetSnackBar(
              message: "Fill all the fields",
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ));
          }
        } catch (e) {
          // print(e);

          Get.showSnackbar(GetSnackBar(
            message: "Something went wrong hai:$e",
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ));
        }
      } catch (e) {
        e;
      }
    }
  }

  void increment() => count.value++;
  @override
  void dispose() {
    videoPlayerController.dispose();
    // print("disposed");
    super.dispose();
  }
}
