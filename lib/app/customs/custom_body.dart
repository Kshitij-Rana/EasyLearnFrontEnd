import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class customBody extends StatelessWidget {
  final Widget child;

  final bool showBackButton;
  final EdgeInsetsGeometry? padding;
  final bool isScrollable;
  final ScrollController? scrollController;
  const customBody(
      {super.key,
      required this.child,
      this.isScrollable = false,
      this.showBackButton = false,
      this.scrollController,
      this.padding});

  @override
  Widget build(BuildContext context) {
    var body = SafeArea(
      child: Padding(
        padding: padding ??
            EdgeInsets.symmetric(
              vertical: 5.w,
              horizontal: 5.w,
            ),
        child: SizedBox(
          width: 100.w,
          child: child,
        ),
      ),
    );

    return isScrollable
        ? SingleChildScrollView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(),
            child: body,
          )
        : body;
  }
}
