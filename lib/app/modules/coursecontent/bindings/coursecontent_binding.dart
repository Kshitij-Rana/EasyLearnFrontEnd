import 'package:get/get.dart';

import '../controllers/coursecontent_controller.dart';

class CoursecontentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CoursecontentController>(
      () => CoursecontentController(),
    );
  }
}
