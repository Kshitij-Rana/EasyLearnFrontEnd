import 'package:e_learn/app/models/course_content.dart';
import 'package:e_learn/app/models/courses.dart';
import 'package:e_learn/app/models/paid_courses.dart';
import 'package:e_learn/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:get/get.dart';

class CoursecontentController extends GetxController {
  final count = 0.obs;
  RxBool isPaid = true.obs;
  var courses = Get.arguments as Courses;

  var length = 0;
  var homecontroller = Get.find<HomepageController>();
  RxList<CourseContent>? courseContentCourseId = RxList<CourseContent>([]);

  late List<RxBool> isClicked;
  void increment() => count.value++;
  void initializeIsClicked(int length) {
    isClicked = List.generate(length, (index) => RxBool(false));
  }

  @override
  void onInit() {
    // TODO: implement onInit
    var homepageController = Get.find<HomepageController>();
    courseContentCourseId?.value = homecontroller.courseContent!
        .where((courseContent) => courseContent.courseId == courses.courseId)
        .toList();
    length = courseContentCourseId?.length ?? 0;
    initializeIsClicked(length);

    // print(courseContentCourseId);
    // print(homepageController.courseContent);
    // print(courses.courseId);
    super.onInit();
  }
}
