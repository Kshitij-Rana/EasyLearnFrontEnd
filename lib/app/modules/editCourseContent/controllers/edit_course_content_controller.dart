import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:e_learn/app/models/course_content.dart';
import 'package:e_learn/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:e_learn/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class EditCourseContentController extends GetxController {
  //TODO: Implement EditCourseContentController
  GlobalKey<FormState> courseFormKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  CourseContent courseContent = Get.arguments as CourseContent;
  final count = 0.obs;
  RxBool isLoading = false.obs;

  late VideoPlayerController videoPlayerController;
  Duration? duration;
  Duration? position;
  Duration? fiveSecBehind;
  Duration? fiveSecFront;
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
  var picker = ImagePicker();
  //for image
  XFile? image;
  var imagebytes = Uint8List(0);
  //for video
  XFile? video;
  var videobytes = Uint8List(0);
  @override
  Future<void> onInit() async {
    videoUrl = courseContent.contentVideo ?? '';
    await initializeVideoURL(videoUrl);
    prefs = await SharedPreferences.getInstance();
    titleController.text = courseContent.contentName ?? '';
    descriptionController.text = courseContent.contentDescription ?? '';

    super.onInit();
  }

  Future<void> onContentEdit() async {
    isLoading.value = true;
    try {
      if (courseFormKey.currentState!.validate()) {
        var url = Uri.http(
            ipaddress, "finalyearproject_api/edit/editCourseContent.php");
        var form = http.MultipartRequest('POST', url);
        form.fields['content_id'] = courseContent.contentId ?? '';
        form.fields['token'] = prefs!.getString('token')!;
        form.fields['content_name'] = titleController.text;
        form.fields['content_description'] = descriptionController.text;
        form.fields['course_id'] = courseContent.courseId ?? '';

        // Check if a new video file has been selected
        if (video != null) {
          final storageref = FirebaseStorage.instance.ref();
          final videoRef =
              storageref.child(DateTime.now().toString() + video!.name);
          task = await videoRef.putFile(File(video!.path));
          videoUrl = await videoRef.getDownloadURL();
          form.fields['content_video'] =
              videoUrl; // Include the video URL in the request
          form.fields['content_duration'] =
              "${hour.value}:${minute.value}:${second.value}";
        }

        // Add the image file if it exists
        if (image != null) {
          form.files.add(http.MultipartFile.fromBytes('image', imagebytes,
              filename: image!.name));
        }

        var response = await http.Response.fromStream(await form.send());

        var data = jsonDecode(response.body);
        if (data['success']) {
          Get.back();
          Get.back();
          Get.showSnackbar(GetSnackBar(
            message: data['message'],
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ));
          Get.find<HomepageController>().getCourseContent();

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
      Get.showSnackbar(GetSnackBar(
        message: "Something went wrong hai:$e",
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ));
    }
    isLoading.value = false;
  }

  Timer? timer;
  String convertTwo(int value) {
    return value < 10 ? "0$value" : "$value";
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
  // void initializeVideo() async {
  //   videoPlayerController = VideoPlayerController.file(File(video!.path))
  //     ..initialize().then((_) async {
  //       // await videoPlayerController.videoPlayerOptions!.webOptions!.controls;
  //       // videoPlayerController
  //       //     .videoPlayerOptions!.webOptions!.controls.allowPlaybackRate;

  //       videoPlayerController.pause();
  //       videoPlaying.value = false;
  //       oncontrollerUpdate();
  //       update();
  //     })
  //     ..addListener(() {
  //       if (videoPlayerController.value.isPlaying) {
  //         videoPlaying.value = true;
  //       }
  //     });
  // }
  Future<void> initializeVideoURL(String videoPath) async {
    isLoading.value = true;
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl))
          ..initialize().then((_) {
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
    isLoading.value = false;
  }

  void initializeVideo(String videoPath) async {
    videoPlayerController = VideoPlayerController.file(File(videoPath))
      ..initialize().then((_) {
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

  Future<void> pickVideo() async {
    videoLoading.value = true;
    try {
      video = await picker.pickVideo(source: ImageSource.gallery);
      if (video == null) {
        Get.showSnackbar(
          const GetSnackBar(
            message: "No video selected",
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }
      // Dispose of the original video player controller
      videoPlayerController.dispose();
      // Initialize with the new video
      initializeVideo(video!.path);
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

  // Future<void> pickVideo() async {
  //   videoLoading.value = true;
  //   try {
  //     video = await picker.pickVideo(source: ImageSource.gallery);
  //     if (video == null) {
  //       // User cancelled the operation
  //       Get.showSnackbar(
  //         const GetSnackBar(
  //           message: "No video selected",
  //           backgroundColor: Colors.orange,
  //           duration: Duration(seconds: 3),
  //         ),
  //       );
  //       return;
  //     }
  //     initializeVideo();
  //     isInitialized.value = true;
  //     videobytes = await video!.readAsBytes();
  //     update();
  //     Get.showSnackbar(
  //       const GetSnackBar(
  //         message: "Video uploaded",
  //         backgroundColor: Colors.green,
  //         duration: Duration(seconds: 3),
  //       ),
  //     );
  //   } catch (e) {
  //     Get.showSnackbar(
  //       const GetSnackBar(
  //         message: "Image upload failed",
  //         backgroundColor: Colors.red,
  //         duration: Duration(seconds: 3),
  //       ),
  //     );
  //   }
  //   videoLoading.value = false;
  // }

  void increment() => count.value++;
  @override
  void dispose() {
    videoPlayerController.dispose();
    // print("disposed");
    super.dispose();
  }
}
