import 'package:e_learn/app/customs/custom_body.dart';
import 'package:e_learn/app/customs/custom_button.dart';
import 'package:e_learn/app/modules/forgetPassword/controllers/forget_password_controller.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';

import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        // border: Border.all(color: Colors.black),
        color: const Color.fromRGBO(213, 212, 212, 0.871).withOpacity(0.8),
      ),
    );
    final focusedPinTheme = PinTheme(
        height: 60,
        width: 60,
        textStyle: const TextStyle(
          fontSize: 22,
          color: Color.fromRGBO(30, 60, 87, 1),
        ),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(206, 204, 211, 0.871),

          // border: Border.all(color: Color.fromRGBO(170, 114, 238, 1)),
          borderRadius: BorderRadius.circular(8),
        ));
    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(230, 223, 249, 1),
        // border: Border.all(color: Color.fromRGBO(170, 114, 238, 1)),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text('OtpView'),
          centerTitle: true,
        ),
        body: GetBuilder<OtpController>(
          builder: (controller) {
            var forgetPasswordcontroller = Get.find<ForgetPasswordController>();

            return customBody(
              child: Form(
                key: controller.otpformkey,
                child: Column(
                  children: [
                    Gap(height: 16.w),
                    Text(
                      "Verification",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 19.sp),
                    ),
                    Gap(height: 6.w),
                    Text(
                      "Enter the OTP code sent to the email",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          color: primaryTextColor.withOpacity(0.5)),
                    ),
                    Gap(height: 3.w),
                    Text(
                      forgetPasswordcontroller.forgotEmailController.text,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          color: primaryTextColor.withOpacity(0.9)),
                    ),
                    Gap(height: 5.w),
                    Pinput(
                      controller: controller.otpcontroller,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      length: 4,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      submittedPinTheme: submittedPinTheme,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter OTP";
                        }
                        return null;
                      },
                    ),
                    Gap(height: 6.w),
                    SizedBox(
                      width: 40.w,
                      child: Obx(
                        () => CustomButton(
                          isLoading: controller.isLoading.value,
                          title: "Verify",
                          onPressed: () {
                            controller.onOTPClicked();
                          },
                        ),
                      ),
                    ),
                    Gap(height: 4.w),
                    Text(
                      "Didn't receive code?",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 11.sp,
                          color: primaryTextColor.withOpacity(0.9)),
                    ),
                    Gap(height: 1.w),
                    GestureDetector(
                      onTap: () {
                        forgetPasswordcontroller.onFindProfileClicked();
                      },
                      child: Text(
                        '''Resend''',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 11.sp,
                            color: buttonColor.withOpacity(0.9)),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
