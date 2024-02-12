import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../utils/app_colors.dart';

class CustomPhoneFormField extends StatefulWidget {
   CustomPhoneFormField({super.key, this.intiValue="EG", this.controller, this.onSubmitted});
  String ?intiValue;
 final TextEditingController? controller;
 final void Function(String)? onSubmitted;
  @override
  State<CustomPhoneFormField> createState() => _CustomPhoneFormFieldState();
}

class _CustomPhoneFormFieldState extends State<CustomPhoneFormField> {

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 50.h,
      child: IntlPhoneField(
        autovalidateMode: AutovalidateMode.disabled,
        initialCountryCode: widget.intiValue,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: 'Phone Number',
          counterText: "",
          hintStyle: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
            color: AppColors.geryD8D8,
          ),
          filled: true,
          fillColor: AppColors.white,
          border: OutlineInputBorder(
              borderSide:const BorderSide(
                color: AppColors.black1A,
              ),
              borderRadius: BorderRadius.circular(8)
          ),
          enabledBorder: OutlineInputBorder(
              borderSide:const BorderSide(
                color: AppColors.black1A,
              ),
              borderRadius: BorderRadius.circular(8)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide:const BorderSide(
                color: AppColors.black1A,
              ),
              borderRadius: BorderRadius.circular(8)
          ),
          disabledBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular( 8),
              borderSide: const BorderSide(color: AppColors.black1A)
          ),
          errorBorder: OutlineInputBorder(
              borderRadius:
              BorderRadius.circular( 8),
              borderSide: const BorderSide(color: AppColors.red)
          ),
        ),
        onCountryChanged: (value) {
          setState(() {
            widget.intiValue = value.code ;
          });
        },
        onSubmitted: widget.onSubmitted??(val) {},
        onChanged: (phone) {},
      ),
    );
  }
}
