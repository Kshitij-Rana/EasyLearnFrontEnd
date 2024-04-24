import 'package:e_learn/app/models/category.dart';
import 'package:e_learn/app/modules/homepage/controllers/homepage_controller.dart';
import 'package:e_learn/app/routes/app_pages.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CategoryCard extends StatelessWidget {
  final Categories category;
  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    Get.find<HomepageController>();
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.DETAILED_CATEGORY_COURSES, arguments: category);
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 17, right: 17, top: 10, bottom: 10),
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.withOpacity(0.17)),
        child: Text(
          category.categoryName ?? '',
          style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: secondaryTextColor),
        ),
      ),
    );
  }
}
