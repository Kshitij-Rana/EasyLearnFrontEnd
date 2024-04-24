import 'package:e_learn/app/controller/user_detail_controller.dart';
import 'package:e_learn/app/models/category.dart';
import 'package:e_learn/app/models/courses.dart';
import 'package:get/get.dart';

class DetailedCategoryCoursesController extends GetxController {
  //TODO: Implement DetailedCategoryCoursesController

  final count = 0.obs;
  @override
  var category = Get.arguments as Categories;
  var allCourses = Get.find<UserDetailController>().courses;
  RxList<Courses>? filteredCourses = RxList<Courses>([]);

  void onInit() {
    super.onInit();
    filteredCourses?.value = allCourses!
        .where((course) => course.categoryId == category.categoryId)
        .toList();
    print(filteredCourses?.value);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
