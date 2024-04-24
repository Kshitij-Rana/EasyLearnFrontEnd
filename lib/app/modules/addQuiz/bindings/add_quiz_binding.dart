import 'package:get/get.dart';

import '../controllers/add_quiz_controller.dart';

class AddQuizBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddQuizController>(
      () => AddQuizController(),
    );
  }
}
