import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../app/utils/app_colors.dart';
import '../utils/app_assets.dart';
import 'default_app_bar_widget.dart';
class CustomAppBarImage extends StatelessWidget {
  const CustomAppBarImage({super.key,  this.controller});
 final PageController? controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250.h,
      decoration:const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
          image: DecorationImage(
              image: AssetImage(AppImages.appLogo),
              fit: BoxFit.cover
          )
      ),
      child: Column(
        children: [
          const DefaultAppBarWidget(
            backColor: Colors.transparent,
          ),
          Spacer(),
          controller!=null?
          SmoothPageIndicator(
            controller: controller!,
            count: 3,
            effect: ExpandingDotsEffect(
              activeDotColor: AppColors.mainColor,
              dotColor: AppColors.white,
              radius: 5,
              spacing: 10.w,
              expansionFactor: 1.5,
              dotHeight: 10.h,
              dotWidth: 30.w,
            ),
          ):0.horizontalSpace,
          14.verticalSpace
        ],
      ),
    );
  }
}
