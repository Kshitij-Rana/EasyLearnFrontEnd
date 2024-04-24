import 'package:e_learn/app/utils/Assets.dart';
import 'package:e_learn/app/utils/colors.dart';
import 'package:e_learn/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatefulWidget {
  final String? title;
  final String hintText;
  final bool isMultiline;
  final bool isPassword;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool isSelectCity;
  final bool readOnly;
  final bool isDate;
  final bool isValidated;

  const CustomTextField({
    super.key,
    this.title,
    required this.hintText,
    this.isPassword = false,
    this.textInputAction,
    this.keyboardType,
    required this.controller,
    this.validator,
    this.inputFormatters,
    this.isSelectCity = false,
    this.readOnly = false,
    this.isDate = false,
    this.isMultiline = false,
    this.isValidated = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  var isObsecure = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 1.w),
          child: widget.title == null
              ? const SizedBox.shrink()
              : Text(
                  widget.title ?? '',
                  style: TextStyle(
                    fontSize: isTablet() ? 10.sp : 11.sp,
                    fontWeight: FontWeight.w500,
                    color: primaryTextColor.withOpacity(0.7),
                  ),
                ),
        ),
        Gap(height: 1.w),
        TextFormField(
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          style: TextStyle(fontSize: isTablet() ? 9.sp : 12.sp),
          maxLines: widget.isMultiline ? 5 : 1,
          minLines: widget.isMultiline ? 5 : 1,
          maxLength: widget.isMultiline ? 500 : null,
          inputFormatters: widget.inputFormatters,
          readOnly: widget.readOnly
              ? widget.readOnly
              : widget.isSelectCity
                  ? true
                  : false,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          obscureText: widget.isPassword ? !isObsecure : false,
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            alignLabelWithHint: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0.5.w,
                color: primaryColor,
              ),
            ),
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              color: primaryTextColor,
            ),
            labelText: null,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
              width: 0.3.w,
              color: Colors.grey.withOpacity(0.7),
            )),

            errorStyle: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w400,
              fontSize: 10.sp,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0.3.w,
                color: Colors.red,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0.3.w,
                color: Colors.red,
              ),
            ),
            suffixIcon: widget.isDate
                ? IconButton(
                    icon: SvgPicture.asset(
                      Assets.calenderIcon,
                      height: 5.w,
                      width: 5.w,
                    ),
                    onPressed: () async {
                      var date = await showDatePicker(
                        context: context,
                        initialDate: DateTime(2000),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) {
                        widget.controller.text = date.toString().split(' ')[0];
                      }
                    },
                    splashRadius: 0.1,
                  )
                : widget.isPassword
                    ? IconButton(
                        icon: SvgPicture.asset(
                          isObsecure ? Assets.openEye : Assets.closeEye,
                          height: 5.w,
                          width: 5.w,
                        ),
                        onPressed: () {
                          setState(() {
                            isObsecure = !isObsecure;
                          });
                        },
                        splashRadius: 0.1,
                      )
                    : null,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w400,
              fontSize: isTablet() ? 10.sp : 12.sp,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: !isTablet() ? 5.w : 2.w,
              vertical: !isTablet() ? 4.5.w : 2.w,
            ),
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(
            //     1.w,
            //   ),
            // ),
          ),
          validator: widget.validator ??
              (value) {
                if (value != null) {
                  if (value.isEmpty) {
                    return 'This field can\'t be empty!';
                  }
                  if (widget.validator != null) {
                    return widget.validator!(value);
                  }
                }
                return null;
              },
        ),
        // if (widget.validator != null &&
        //     widget.validator!(widget.controller.text) != null)
        //   Positioned(
        //       right: 12.0,
        //       top: 12.0,
        //       child: Container(
        //         decoration: BoxDecoration(
        //           color: Colors.transparent,
        //           borderRadius: BorderRadius.circular(8.0),
        //         ),
        //         padding: EdgeInsets.all(8.0),
        //         child: Text(
        //           widget.validator!(widget.controller.text)!,
        //           style: TextStyle(
        //             color: Colors.red,
        //           ),
        //         ),
        //       ))
      ],
    );
  }
}
