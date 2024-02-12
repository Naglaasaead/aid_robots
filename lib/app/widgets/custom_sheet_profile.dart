import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/helper.dart';
import 'custom_form_field.dart';
import 'text_button_widget.dart';
import 'text_widget.dart';

void showSheet({
  required BuildContext context ,
  required String text1,
  required String text2,
  void Function()? text1OnPressed,
  void Function()? text2OnPressed,
}){
  showModalBottomSheet(
    context: context,
    shape :RoundedRectangleBorder(
        borderRadius :BorderRadius.circular(20)
    ),
    isScrollControlled: true,
    builder:(context) => SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 30.h,
            left: 15.w,
            right: 15.w
        ),
        decoration:const BoxDecoration(
            color:Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )
        ),
        child: Column(
          children: [
            TextWidget(
                title: "Choose Number",
              titleFontWeight: FontWeight.bold,
              titleColor: AppColors.black,
              titleSize: 20.sp,
            ),
            20.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomTextButton(
                  onPressed: text1OnPressed,
                  title: text1,
                  textDecoration: TextDecoration.underline,
                ),
                CustomTextButton(
                  onPressed:text2OnPressed,
                  title: text2,
                  textDecoration: TextDecoration.underline,
                ),
              ],
            ),
            40.verticalSpace,
          ],
        ),
      ),
    ),
  );
}