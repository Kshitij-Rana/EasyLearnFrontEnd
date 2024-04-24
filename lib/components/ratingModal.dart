import 'package:e_learn/app/customs/customTextField.dart';
import 'package:e_learn/app/customs/custom_button.dart';
import 'package:e_learn/app/models/ratings.dart';
import 'package:e_learn/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class RatingModal extends StatelessWidget {
  final isEdit;
  final Ratings? rating;
  final String CourseId;
  const RatingModal(
      {super.key, required this.CourseId, this.isEdit = false, this.rating});

  @override
  Widget build(BuildContext context) {
    var homepageController = Get.find<HomepageController>();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Dialog(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.w)),
        child: Container(
          width: 90.w,
          height: isTablet() ? 40.w : 106.w,
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                "Rate this course",
                style: TextStyle(color: Colors.black, fontSize: 14.sp),
              ),
              Obx(
                () => RatingBar.builder(
                  initialRating: homepageController.ratingNumber.value,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  unratedColor: primaryColor,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: bottomnavigationBarColor,
                  ),
                  onRatingUpdate: (value) {
                    homepageController.ratingNumber.value = value;
                  },
                ),
              ),
              Gap(height: 4.w),
              Text(
                "Add some review",
                style: TextStyle(color: Colors.black, fontSize: 14.sp),
              ),
              CustomTextField(
                  isMultiline: true,
                  hintText: "Add some review",
                  controller: homepageController.ratingDescriptionController),
              Gap(height: 2.w),
              CustomButton(
                color: bottomnavigationBarColor,
                title: isEdit ? "Edit" : "Submit",
                onPressed: isEdit
                    ? () {
                        homepageController
                            .onRatingEditCLicked(rating ?? Ratings());
                        Get.back();
                      }
                    : () {
                        homepageController.ratingCourses(CourseId);
                      },
              ),
              Gap(height: 5.w),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Center(
                    child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    // fontFamily: Assets.jakartaFont,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
