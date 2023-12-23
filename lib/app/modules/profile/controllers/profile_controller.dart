import 'package:e_learn/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  late final SharedPreferences prefs;

  final count = 0.obs;
  @override
  void onInit() async {
    prefs = await SharedPreferences.getInstance();

    super.onInit();
  }

  void onLogOut() async {
    await prefs.remove('token');
    await prefs.clear();
    Get.offAllNamed(Routes.LOGIN);
  }

  void increment() => count.value++;
}
