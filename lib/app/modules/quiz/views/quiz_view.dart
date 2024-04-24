import 'package:e_learn/app/customs/customTextField.dart';
import 'package:e_learn/app/customs/custom_body.dart';
import 'package:e_learn/app/customs/custom_button.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controllers/quiz_controller.dart';

class QuizView extends GetView<QuizController> {
  const QuizView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Update Quiz'),
          centerTitle: true,
        ),
        body: Form(
          key: controller.formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: customBody(
              isScrollable: true,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Update Quiz Question",
                      style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.w600),
                    ),
                    Gap(height: 2.w),
                    CustomTextField(
                      isMultiline: true,
                      title: "Quiz Question",
                      hintText: "Question Text",
                      controller: controller.questionTextController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter question text';
                        }
                        return null;
                      },
                    ),
                    Gap(height: 3.w),

                    CustomTextField(
                      title: "Choose correct option",
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        NumberRangeFormatter(),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      textInputAction: TextInputAction.next,
                      hintText: "Correct Option (1-4)",
                      controller: controller.correctOptionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter correct option';
                        }
                        return null;
                      },
                    ),
                    Gap(height: 3.w),

                    CustomTextField(
                      title: "Option 1",
                      hintText: "Option 1",
                      controller: controller.option1Controller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter option 1';
                        }
                        return null;
                      },
                    ),
                    Gap(height: 3.w),

                    CustomTextField(
                      title: "Option 2",
                      hintText: "Option 2",
                      controller: controller.option2Controller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter option 2';
                        }
                        return null;
                      },
                    ),
                    Gap(height: 3.w),

                    CustomTextField(
                      title: "Option 3",
                      hintText: "Option 3",
                      controller: controller.option3Controller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter option 3';
                        }
                        return null;
                      },
                    ),
                    Gap(height: 3.w),

                    CustomTextField(
                      title: "Option 4",
                      hintText: "Option 4",
                      controller: controller.option4Controller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter option 4';
                        }
                        return null;
                      },
                    ),
                    Gap(height: 6.w),
                    CustomButton(
                      title: "Update Quiz",
                      onPressed: () {
                        controller.updateQuiz();
                      },
                    )
                    // ElevatedButton(
                    //   onPressed: () {
                    //     // if (_formKey.currentState!.validate()) {
                    //     //   _addQuiz();
                    //     // }
                    //   },
                    //   child: Text('Submit'),
                    // ),
                  ]),
            ),
          ),
        ));
  }
}

class NumberRangeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;
    final int number = int.tryParse(newValue.text) ?? 0;
    if (number < 1 || number > 4) {
      return oldValue;
    }
    return newValue;
  }
}
