import 'package:e_learn/app/utils/themes.dart';
import 'package:e_learn/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
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
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        title: "Application",
        debugShowCheckedModeBanner: false,
        initialRoute: token != null
            ? (role != null && role == 'admin')
                ? Routes.ADMIN_MAIN
                : Routes.HOME
            : Routes.LOGIN,
        getPages: AppPages.routes,
        defaultTransition: Transition.cupertino,
        theme: lightTheme,
      ),
    ),
  );
}
