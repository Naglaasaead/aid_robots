import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/utils/app_colors.dart';
import '../../app/utils/helper.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final String? header;
  final double? width;
  final double? height;
  final bool? obscure;
  final String? labelText;
  final String? validateText;
  final IconData? suffixIcon;
  final Widget? suffixIconWidget;
  final IconData? prefixIcon;
  final Color? prefixIconColor;
  final Widget? prefixIconWidget;
  final Color? labelColor;
  final Function(String)? onChange;
  final Function()? iconPressed;
  final GestureTapCallback? onPressed;
  final VoidCallback? onTap;
  final Function(String)? onFieldSubmitted;
  final bool? enabled;
  final bool? filled;
  final TextAlign? align;
  final FocusNode? focusNode;
  final int? maxLines;
  final int? minLines;
  final Color? color;
  final Color? suffixColor;
  final Color? fillColor;
  final Color? hintColor;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String? value)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final BorderRadiusGeometry? borderRadius;
  final double? borderRadiusValue;
  final InputBorder? enabledBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedBorder;
  final InputBorder? disableBorder;

  const CustomFormField({
    super.key,
    this.controller,
    this.hint = "",
    this.width,
    this.height,
    this.obscure = false,
    this.header,
    this.labelText,
    this.suffixIcon,
    this.suffixIconWidget,
    this.enabled = true,
    this.labelColor,
    this.hintColor,
    this.onPressed,
    this.align,
    this.prefixIcon,
    this.prefixIconWidget,
    this.focusNode,
    this.maxLines,
    this.minLines,
    this.iconPressed,
    this.color,
    this.onChange,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.contentPadding,
    this.borderRadius,
    this.borderRadiusValue,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder, this.disableBorder, this.filled, this.fillColor, this.prefixIconColor, this.onFieldSubmitted, this.validateText, this.suffixColor, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        header == null
            ? const SizedBox()
            : Text(
                header ?? "",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColors.black5252,
                    fontSize: 14.sp,
                ),
              ),
        SizedBox(
          height: header == null ? 0 : 5.h,
        ),
        SizedBox(
          height: height??60.h,
          child: InkWell(
            onTap: onPressed,
            child: TextFormField(
              cursorColor: AppColors.black,
              onTap:onTap?? () {},
              onFieldSubmitted:onFieldSubmitted??(st){} ,
              validator: validator ??
                  (value) {
                    if (value!.isEmpty) {
                      return validateText?? "Field Must not be Empty";
                    }
                    return null;
                  },
              textInputAction: textInputAction,
              controller: controller,
              minLines: minLines ?? 1,
              maxLines: maxLines ?? 1,
              enabled: enabled,
              keyboardType: keyboardType,
              focusNode: focusNode,
              onChanged: onChange,
              obscureText: obscure ?? false,
              textAlign: align ?? TextAlign.start,
              style: TextStyle(
                height: 1.2.h,
                fontFamily: fontMedium,
                color: AppColors.black,
                fontSize: 17.sp,
              ),
              cursorHeight: 20.h,
              decoration: InputDecoration(
                fillColor: fillColor??Color(0xffFAFAFA),
                filled:filled??true ,
                isDense: true,
                contentPadding: contentPadding ??
                    const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20
                    ),
                errorStyle: TextStyle(
                  fontSize: 14.sp,
                  height: 2.h,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadiusValue ?? 15),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    )
                ),
                enabledBorder: enabledBorder ?? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadiusValue ?? 15),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        )
                ),
                disabledBorder:disableBorder?? OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(borderRadiusValue ?? 15),
                    borderSide: const BorderSide(color: Colors.transparent,)
                ),
                errorBorder: errorBorder ?? OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(borderRadiusValue ?? 15),
                      borderSide: const BorderSide(color: AppColors.red)
                    ),
                focusedBorder: focusedBorder ?? OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(borderRadiusValue ?? 15),
                        borderSide:
                        const BorderSide(
                          color: AppColors.black1A,
                        )),
                hintText: hint ?? "",
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                  color:hintColor?? AppColors.geryD8D8,
                ),
                labelText: labelText,
                labelStyle: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.field,
                  fontFamily: fontRegular,
                ),
                suffixIcon: suffixIconWidget == null
                    ? (suffixIcon == null
                        ? null
                        : InkWell(
                            onTap: iconPressed ?? () {},
                            child:
                            Icon(
                              suffixIcon,
                              size: 18.sp,
                              color:suffixColor?? AppColors.gery455,
                            )))
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          suffixIconWidget!,
                        ],
                      ),
                prefixIcon: prefixIconWidget == null
                    ? (prefixIcon == null
                        ? null
                        : Icon(
                            prefixIcon,
                            size: 23.sp,
                            color:prefixIconColor?? AppColors.field,
                          ))
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          prefixIconWidget!,
                          SizedBox(
                            width: 16.h,
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
