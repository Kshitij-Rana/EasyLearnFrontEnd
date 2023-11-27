import 'package:e_learn/app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({super.key});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90.w,
      height: 10.w,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            padding:
                const EdgeInsets.only(left: 17, right: 17, top: 10, bottom: 10),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.17)),
            child: const Text(
              "category",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: secondaryTextColor),
            ),
          );
        },
      ),
    );
  }
}
