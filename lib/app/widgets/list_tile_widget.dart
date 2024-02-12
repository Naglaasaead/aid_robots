import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';
import '../utils/app_fonts.dart';
import 'image_widget.dart';
import 'text_widget.dart';

class ListTileWidget extends StatelessWidget {
  final void Function() onTap;
  final IconData? icon;
  final bool trailingIcon;
  final String title;
  final String imageUrl;
  final Color? tralingColor;
  final Color? textColor;
  final Color? iconColor;
  final bool arrowIcon;
  final bool image;

  const ListTileWidget({
    super.key,
    required this.onTap,
     this.icon,
     this.trailingIcon=false,
    this.tralingColor,
    this.arrowIcon = true, required this.title, this.textColor, this.iconColor, this.image= false,  this.imageUrl="",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey8080),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 55.h,
      child: ListTile(
        tileColor: AppColors.grey8080,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onTap: onTap,
        minLeadingWidth: 8.w,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16,vertical: 0),
        dense: true,
        leading:image?
            ImageWidget(
                imageUrl: imageUrl,
              width: 21.w,
              height: 21.h,
              color: AppColors.mainColor,
            )
            :
        Icon(
          icon,
          size: 26.sp,
          color:iconColor?? AppColors.mainColor,
        ),
        title: TextWidget(
          title: title,
          titleSize: 15.sp,
          titleFontWeight: FontWeight.w500,
          titleColor:textColor?? AppColors.gery455,
          titleAlign: TextAlign.start,
        ),
        trailing:trailingIcon? Icon(
          Icons.arrow_forward_ios,
          color:tralingColor?? AppColors.black,
          size: 16.sp,
        ):0.verticalSpace,

      ),
    );
  }
}
