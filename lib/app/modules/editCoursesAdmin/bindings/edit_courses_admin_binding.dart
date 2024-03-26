import 'package:get/get.dart';

import '../controllers/edit_courses_admin_controller.dart';

class EditCoursesAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditCoursesAdminController>(
      () => EditCoursesAdminController(),
    );
  }
}
