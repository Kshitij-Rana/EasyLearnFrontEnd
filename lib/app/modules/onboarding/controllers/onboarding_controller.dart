import 'package:e_learn/app/modules/intro/intropage1.dart';
import 'package:e_learn/app/modules/intro/intropage2.dart';
import 'package:e_learn/app/modules/intro/intropage3.dart';
import 'package:e_learn/app/modules/intro/intropage5.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  //TODO: Implement OnboardingController
  List<Widget> pages = [Intropage1(), Intropage2(), Intropage3(), Intropage5()];
  final count = 0.obs;
  // to keep track of pages
  var currentIndex = 0.obs;
  PageController pageController = PageController();
  // To keep track if we are on the last page or not
  RxBool onLastPage = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  void nextPage() {
    pageController.nextPage(
        duration: const Duration(seconds: 1), curve: Curves.easeInOut);
  }

  void backpage() {
    pageController.previousPage(
        duration: const Duration(seconds: 1), curve: Curves.easeInOut);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
