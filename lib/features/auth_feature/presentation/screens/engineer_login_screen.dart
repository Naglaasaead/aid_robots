import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../app/utils/app_assets.dart';
import '../../../../app/utils/app_colors.dart';
import '../../../../app/widgets/button_widget.dart';
import '../../../../app/widgets/custom_form_field.dart';
import '../../../../app/widgets/image_widget.dart';
import '../../../../app/widgets/text_button_widget.dart';
import '../../../../app/widgets/text_widget.dart';

class EngineerLoginScreen extends StatelessWidget {
  const EngineerLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 21.sp,vertical: 50),
        children: [
          ImageWidget(
            imageUrl: AppImages.appLogo,
            width: 163.w,
            height: 82.h,
          ),
          35.verticalSpace,
          TextWidget(
            title: "sign in",
            titleSize: 24.sp,
            titleColor: AppColors.mainColor,
            titleFontWeight: FontWeight.w400,
          ),
          40.verticalSpace,
          const CustomFormField(
            header: "your Email",
            keyboardType: TextInputType.emailAddress,
          ),
          25.verticalSpace,
          CustomFormField(
            header: "your password",
            suffixIcon:Icons.visibility_off,
            //cubit.passObscure==false?Icons.visibility:Icons.visibility_off,
            //obscure:cubit.passObscure,
            iconPressed: () {
              //cubit.changeVisible();
            },
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: CustomTextButton(
              onPressed: () {
                //navigateTo(EngineerForgetPasswordScreen());
              },
              title: "forget password?",
              titleColor: AppColors.mainColor,
              titleFontWeight: FontWeight.w400,
              titleSize: 14.sp,
            ),
          ),
          19.verticalSpace,
          ButtonWidget(
            onPressed: () {
              //navigateTo(BNBScreen());
            },
            text: "login",
          ),
          57.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(
                title: "Don’t have account before?",
                titleSize: 20.sp,
                titleColor: AppColors.mainColor,
                titleFontWeight: FontWeight.w400,
              ),
              CustomTextButton(
                onPressed: () {
                 // navigateTo(EngineerRegisterScreen());
                },
                title: "sign up",
                titleColor: AppColors.black,
                titleFontWeight: FontWeight.w400,
                titleSize: 20.sp,
              ),
            ],
          )
        ],
      ),
    );
  }
}
