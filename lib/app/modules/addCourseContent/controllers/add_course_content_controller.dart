import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class AddCourseContentController extends GetxController {
  GlobalKey<FormState> courseFormKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late VideoPlayerController videoPlayerController;
  Duration? duration;
  Duration? position;
  // late VideoPlayerController videoPlayerController2;
  // late VideoPlayerController videoPlayerController3;
  // late VideoPlayerController videoPlayerController4;

  // late CustomVideoPlayerController customVideoPlayerController;
  var progress = 0.0.obs;
  var videoLoading = false.obs;
  var isMute = false.obs;
  var videoPlaying = false.obs;
  var isInitialized = false.obs;
  var isLandScape = false.obs;

  final count = 0.obs;
  var picker = ImagePicker();
  //for image
  XFile? image;
  var imagebytes = Uint8List(0);
  //for video
  XFile? video;
  var videobytes = Uint8List(0);
  var videourl =
      'https://firebasestorage.googleapis.com/v0/b/cv-maker-cbdcc.appspot.com/o/2023-12-06%2014%3A50%3A52.094042pexels-photo-220453.jpg?alt=media&token=4a4ec47c-731e-4c7b-8848-b43cae274d34';

  // void dispose() {
  //   customVideoPlayerController.dispose();
  //   super.dispose();
  // }
  String convertTwo(int value) {
    return value < 10 ? "0$value" : "$value";
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
    if (duration == null) {
      duration = videoPlayerController.value.duration;
    }
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
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> pickVideo() async {
    videoLoading.value = true;
    try {
      video = await picker.pickVideo(source: ImageSource.gallery);
      initializeVideo();
      isInitialized.value = true;
      if (video != null) {
        videobytes = await video!.readAsBytes();

        update();
      }
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

  void increment() => count.value++;
  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }
}
