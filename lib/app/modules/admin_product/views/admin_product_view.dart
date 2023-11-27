import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/admin_product_controller.dart';

class AdminProductView extends GetView<AdminProductController> {
  const AdminProductView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AdminProductView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AdminProductView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
