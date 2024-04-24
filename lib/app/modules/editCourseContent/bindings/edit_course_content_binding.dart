import 'package:get/get.dart';

import '../controllers/edit_course_content_controller.dart';

class EditCourseContentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditCourseContentController>(
      () => EditCourseContentController(),
    );
  }
}
