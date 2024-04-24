import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminProductController extends GetxController {
  final ImagePicker picker = ImagePicker();
  var imagebytes = Uint8List(0);
  final count = 0.obs;
  late final SharedPreferences prefs;

  String videoURL = "";
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    prefs = await SharedPreferences.getInstance();
  }

  void uploadVideo() async {
    final image = await picker.pickVideo(source: ImageSource.gallery);
    if (image != null) {
      imagebytes = await image.readAsBytes();
      final storageRef = FirebaseStorage.instance.ref();
      final videoRef = storageRef.child(DateTime.now().toString() + image.name);
      final task = await videoRef.putFile(
          File(image.path), SettableMetadata(contentType: "video/mp4"));
      videoURL = await videoRef.getDownloadURL();
      try {
        task;
      } catch (e) {
        e;
      }
      Get.showSnackbar(const GetSnackBar(
        message: "Image uploaded",
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ));
    } else {
      Get.showSnackbar(const GetSnackBar(
        message: "Video upload failed",
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ));
    }
  }

  void increment() => count.value++;
}
