import 'package:e_learn/app/routes/app_pages.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Intropage5 extends StatefulWidget {
  const Intropage5({super.key});

  @override
  State<Intropage5> createState() => _Intropage5State();
}

class _Intropage5State extends State<Intropage5> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: secondaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultTextStyle(
            style: TextStyle(
                fontSize: 17.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            child: AnimatedTextKit(
                animatedTexts: [TyperAnimatedText("Now, let's get started")]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Lottie.asset("assets/lottie/getStarted.json"),
          ),
          Container(
            width: 60.w,
            height: 7.h,
            decoration: BoxDecoration(
                color: buttonColor, borderRadius: BorderRadius.circular(16)),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    foregroundColor: fadedpurpleColor,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
                onPressed: () {
                  Get.toNamed(Routes.LOGIN);
                },
                child: const Text(
                  "Log In",
                  style: TextStyle(color: Colors.white, fontSize: 19),
                )),
          ),
        ],
      ),
    );
  }
}
