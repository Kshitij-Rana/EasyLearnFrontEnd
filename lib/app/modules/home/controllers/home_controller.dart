import 'package:e_learn/app/modules/homepage/views/homepage_view.dart';
import 'package:e_learn/app/modules/profile/views/profile_view.dart';
import 'package:e_learn/app/modules/searchpage/views/searchpage_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  List<Widget> screens = [
    const HomepageView(),
    // const SearchpageView(),
    // SearchButtonFunction()
    const ProfileView(),
  ];
  var currentIndex = 0.obs;
  final count = 0.obs;

  void increment() => count.value++;
}
