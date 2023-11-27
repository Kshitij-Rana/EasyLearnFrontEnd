import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_category_controller.dart';

class AdminCategoryView extends GetView<AdminCategoryController> {
  const AdminCategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminCategoryView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AdminCategoryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
