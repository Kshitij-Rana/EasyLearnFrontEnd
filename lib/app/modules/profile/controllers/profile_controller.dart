import 'package:e_learn/app/controller/user_detail_controller.dart';
import 'package:e_learn/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  late final SharedPreferences prefs;

  var profilePic = ''.obs;

  final count = 0.obs;
  @override
  void onInit() async {
    prefs = await SharedPreferences.getInstance();
    var userProfile = Get.find<UserDetailController>();
    profilePic.value = userProfile.userInfo?.profileImg ?? '';
    print("pic:${profilePic.value}");
    super.onInit();
  }

  void onLogOut() async {
    await prefs.clear();
    Get.offAllNamed(Routes.LOGIN);
  }

  void increment() => count.value++;
}
