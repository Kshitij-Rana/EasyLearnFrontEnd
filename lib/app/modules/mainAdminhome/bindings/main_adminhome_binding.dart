import 'package:get/get.dart';

import '../controllers/main_adminhome_controller.dart';

class MainAdminhomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainAdminhomeController>(
      () => MainAdminhomeController(),
    );
  }
}
