import 'package:get/get.dart';

import '../controllers/detailed_category_courses_controller.dart';

class DetailedCategoryCoursesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailedCategoryCoursesController>(
      () => DetailedCategoryCoursesController(),
    );
  }
}
