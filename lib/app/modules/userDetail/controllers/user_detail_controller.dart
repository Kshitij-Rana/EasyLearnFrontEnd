import 'package:e_learn/app/models/admin_paid_course.dart';
import 'package:get/get.dart';

class AdminUserDetailController extends GetxController {
  //TODO: Implement UserDetailController
  var userDetail = Get.arguments as List<Adminpaidcourse>;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
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
