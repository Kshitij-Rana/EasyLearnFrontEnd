import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class Intropage2 extends StatefulWidget {
  const Intropage2({super.key});

  @override
  State<Intropage2> createState() => _Intropage2State();
}

class _Intropage2State extends State<Intropage2> {
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
                animatedTexts: [TyperAnimatedText("A course of your choice")]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Lottie.asset("assets/lottie/course.json"),
          ),
        ],
      ),
    );
  }
}
