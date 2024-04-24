import 'package:get/get.dart';

import '../controllers/paicourse_content_controller.dart';

class PaicourseContentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaicourseContentController>(
      () => PaicourseContentController(),
    );
  }
}
