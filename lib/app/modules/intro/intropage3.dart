import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class Intropage3 extends StatefulWidget {
  const Intropage3({super.key});

  @override
  State<Intropage3> createState() => _Intropage3State();
}

class _Intropage3State extends State<Intropage3> {
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
              TyperAnimatedText("Learn and master the course")
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Lottie.asset("assets/lottie/master.json"),
          ),
        ],
      ),
    );
    ;
  }
}
