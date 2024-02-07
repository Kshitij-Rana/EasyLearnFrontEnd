import 'package:e_learn/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:get/get.dart';

class CoursecontentController extends GetxController {
  final count = 0.obs;
  RxBool isPaid = true.obs;
  var length = 0;
  late List<RxBool> isClicked;
  void increment() => count.value++;
  void initializeIsClicked(int length) {
    isClicked = List.generate(length, (index) => RxBool(false));
  }

  @override
  void onInit() {
    // TODO: implement onInit
    var homepageController = Get.find<HomepageController>();
    length = homepageController.courses?.length ?? 0;
    initializeIsClicked(length);
    super.onInit();
  }
}
