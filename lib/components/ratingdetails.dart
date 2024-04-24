import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:e_learn/app/models/ratings.dart';
import 'package:e_learn/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/components/constants.dart';
import 'package:e_learn/components/delete_modal.dart';
import 'package:e_learn/components/ratingModal.dart';

class RatingDetails extends StatefulWidget {
  final Ratings rating;
  final bool isFromCourse;
  const RatingDetails(
      {Key? key, required this.rating, this.isFromCourse = false})
      : super(key: key);

  @override
  _RatingDetailsState createState() => _RatingDetailsState();
}

class _RatingDetailsState extends State<RatingDetails> {
  @override
  Widget build(BuildContext context) {
    var homepageController = Get.find<HomepageController>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Your existing widgets...
        Row(
          children: [
            SizedBox(
              width: 40.w,
              height: 5.5.w,
              child: Text(widget.rating.username ?? '',
                  style: TextStyle(
                      overflow: TextOverflow.clip,
                      color: Colors.black.withOpacity(0.8),
                      fontSize: widget.isFromCourse ? 11.5.sp : 13.sp,
                      fontWeight: FontWeight.w500)),
            ),
            Gap(width: widget.isFromCourse ? 28.w : 13.w),
            Text(
                "${widget.rating.ratingDate!.year.toString()}/${widget.rating.ratingDate!.month}/${widget.rating.ratingDate!.day}",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: widget.isFromCourse ? 10.sp : 13.sp,
                    fontWeight: FontWeight.w500)),
            Gap(width: 5.w),
            widget.isFromCourse
                ? SizedBox.shrink()
                : PopupMenuButton<String>(
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ), // Change to Icons.more_horiz if you prefer horizontal dots
                    onSelected: (String value) {
                      if (value == 'edit') {
                        homepageController
                            .oneditRatingButtonCicked(widget.rating);
                        showCupertinoDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (context) {
                            return RatingModal(
                                rating: widget.rating,
                                isEdit: true,
                                CourseId: widget.rating.courseId ?? '');
                          },
                        );
                      } else if (value == 'delete') {
                        showCupertinoDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (context) {
                            return DeleteModal(
                              question:
                                  "Are you sure you want to delete this rating?",
                              deleteFunction: () {
                                homepageController
                                    .onDeleteRatings(widget.rating);
                              },
                            );
                          },
                        );
                      }
                    },

                    itemBuilder: (context) => <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ],
                  )
          ],
        ),
        Gap(height: 1.w),
        RatingBar.builder(
          itemSize: widget.isFromCourse ? 15.sp : 20.sp,
          initialRating: double.parse(widget.rating.ratingNumber ?? '0.0'),
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

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 90.w,
              height: homepageController.isExpanded.value
                  ? widget.rating.ratingDescription!.length * 0.12.w
                  : 10.w,
              child: Text(
                widget.rating.ratingDescription ?? '',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: widget.isFromCourse ? 10.sp : 12.sp,
                  fontWeight:
                      widget.isFromCourse ? FontWeight.w400 : FontWeight.w500,
                ),
                maxLines: homepageController.isExpanded.value ? null : 3,
                overflow: homepageController.isExpanded.value
                    ? TextOverflow.visible
                    : TextOverflow.ellipsis,
              ),
            ),
            Gap(height: 2.w),
            GestureDetector(
              onTap: () {
                setState(() {
                  homepageController.isExpanded.value =
                      !homepageController.isExpanded.value;
                });
              },
              child: Text(
                homepageController.isExpanded.value ? "Read Less" : "Read More",
                style: TextStyle(color: bottomnavigationBarColor),
              ),
            ),
          ],
        ),

        // LayoutBuilder(
        //   builder: (BuildContext context, BoxConstraints constraints) {
        //     final textSpan = TextSpan(
        //       text: widget.rating.ratingDescription ?? '',
        //       style: TextStyle(
        //         color: Colors.black.withOpacity(0.8),
        //         fontSize: 12.sp,
        //         fontWeight: FontWeight.w500,
        //       ),
        //     );
        //     final textPainter = TextPainter(
        //       text: textSpan,
        //       maxLines: homepageController.isExpanded.value
        //           ? null
        //           : 2, // Limit to 2 lines initially
        //       textDirection: TextDirection.ltr,
        //     );
        //     textPainter.layout(maxWidth: constraints.maxWidth);

        //     final textHeight = textPainter.size.height;
        //     final containerHeight = 2.w; // Your container height

        //     return Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         SizedBox(
        //           width: 90.w,
        //           height: homepageController.isExpanded.value
        //               ? containerHeight
        //               : textHeight,
        //           child: Text(
        //             widget.rating.ratingDescription ?? '',
        //             style: TextStyle(
        //               color: Colors.black.withOpacity(0.8),
        //               fontSize: 12.sp,
        //               fontWeight: FontWeight.w500,
        //             ),
        //             maxLines: homepageController.isExpanded.value ? null : 3,
        //             overflow: homepageController.isExpanded.value
        //                 ? TextOverflow.visible
        //                 : TextOverflow.ellipsis,
        //           ),
        //         ),
        //         if (textHeight > containerHeight)
        //           TextButton(
        //             onPressed: () {
        //               setState(() {
        //                 homepageController.isExpanded.value =
        //                     !homepageController.isExpanded.value;
        //               });
        //             },
        //             child: Text(
        //               homepageController.isExpanded.value
        //                   ? "Read Less"
        //                   : "Read More",
        //               style: TextStyle(color: bottomnavigationBarColor),
        //             ),
        //           ),
        //       ],
        //     );
        //   },
        // )
      ],
    );
  }
}
