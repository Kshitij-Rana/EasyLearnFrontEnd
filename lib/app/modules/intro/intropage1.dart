import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class Intropage1 extends StatefulWidget {
  const Intropage1({super.key});

  @override
  State<Intropage1> createState() => Intropage1State();
}

class Intropage1State extends State<Intropage1> {
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
            child: AnimatedTextKit(animatedTexts: [
              TyperAnimatedText("Let's get the best course for you")
            ]),
          ),
          Lottie.asset("assets/lottie/searchAnimation.json")
        ],
      ),
    );
  }
}
