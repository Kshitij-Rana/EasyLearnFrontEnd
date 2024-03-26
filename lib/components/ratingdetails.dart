import 'package:e_learn/app/models/ratings.dart';
import 'package:e_learn/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';

class RatingDetails extends StatelessWidget {
  final Ratings rating;
  const RatingDetails({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(rating.username ?? '',
                style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500)),
            Gap(width: 30.w),
            Text(
                "${rating.ratingDate!.year.toString()}/${rating.ratingDate!.month}/${rating.ratingDate!.day}",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500))
          ],
        ),
        Gap(height: 1.w),
        RatingBar.builder(
          itemSize: 20.sp,
          initialRating: double.parse(rating.ratingNumber ?? '0.0'),
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          unratedColor: primaryColor,
          itemPadding: EdgeInsets.symmetric(horizontal: 1.sp),
          itemBuilder: (context, index) => Icon(
            Icons.star,
            color: bottomnavigationBarColor,
          ),
          onRatingUpdate: (value) {},
          ignoreGestures: true,
        ),
        Gap(height: 2.w),
        Container(
          height: 20.w,
          width: 90.w,
          child: Text(rating.ratingDescription ?? '',
              style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500)),
        )
      ],
    );
  }
}
