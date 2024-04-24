import 'package:get/get.dart';

import '../controllers/add_course_content_controller.dart';

class AddCourseContentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCourseContentController>(
      () => AddCourseContentController(),
    );
  }
}
