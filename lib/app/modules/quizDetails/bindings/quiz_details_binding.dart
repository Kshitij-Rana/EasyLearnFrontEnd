import 'package:get/get.dart';

import '../controllers/quiz_details_controller.dart';

class QuizDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuizDetailsController>(
      () => QuizDetailsController(),
    );
  }
}
