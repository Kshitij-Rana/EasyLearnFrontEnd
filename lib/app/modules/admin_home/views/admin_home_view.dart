import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_home_controller.dart';

class AdminHomeView extends GetView<AdminHomeController> {
  const AdminHomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //     body: GetBuilder<AdminHomeController>(builder: (controller) {
      //   // if
      //   // return RefreshIndicator(child: child, onRefresh: () {

      //   // },)
      //   return Text("data");
      // })
      body: Column(
        children: [Text("data")],
      ),
    );
  }
}
