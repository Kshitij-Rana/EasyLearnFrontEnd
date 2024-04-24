import 'package:e_learn/app/controller/user_detail_controller.dart';
import 'package:e_learn/app/modules/cart/controllers/cart_controller.dart';
import 'package:e_learn/app/utils/themes.dart';
import 'package:e_learn/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  var role = prefs.getString('role');
  if (role != null) {
    Get.put(UserDetailController());
    Get.put(CartController(), permanent: true);
  }
  runApp(
    KhaltiScope(
      publicKey: "test_public_key_079a2f2576844ba2962c82378012eb4b",
      builder: (context, navigatorKey) => Sizer(
        builder: (context, orientation, deviceType) => GetMaterialApp(
          navigatorKey: navigatorKey,
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('ne', 'NP'),
          ],
          localizationsDelegates: const [KhaltiLocalizations.delegate],
          title: "Application",
          debugShowCheckedModeBanner: false,
          initialRoute: token != null
              ? (role != null && role == 'admin')
                  ? Routes.ADMIN_MAIN
                  : (role == 'mainadmin')
                      ? Routes.MAIN_ADMINHOME
                      : Routes.HOME
              : Routes.LOGIN,
          getPages: AppPages.routes,
          defaultTransition: Transition.cupertino,
          theme: lightTheme,
        ),
      ),
    ),
  );
}
