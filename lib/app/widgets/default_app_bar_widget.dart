import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';
import '../utils/app_fonts.dart';
import 'text_widget.dart';

class DefaultAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;
  final bool actions;
  final bool favourite;
  final bool notify;
  final bool? centerTitle;
  final Widget? leading;
  final bool  shapeBorder;
  final Widget? titleWidget;
  final VoidCallback? onPop;
  final VoidCallback? favouriteOnPressed;
  final VoidCallback? notificationOnPressed;
  final bool canBack;
  final Color ? backColor;
  final Color ? titleColor;
  final Color ?leadingColor;
  final double? leadingWidth;
  final SystemUiOverlayStyle? systemUiOverlayStyle;
  final List<Widget>? actionsWidgets;

  const DefaultAppBarWidget(
      {this.title,
      this.actions = false,
      Key? key,
      this.onPop,
      this.canBack = true, this.leading,  this.notify=true, this.favouriteOnPressed, this.titleWidget,
        this.leadingWidth,
        this.leadingColor,
        this.actionsWidgets, this.backColor,this.titleColor, this.systemUiOverlayStyle,
        this.centerTitle, this.shapeBorder = false, this.notificationOnPressed,  this.favourite = true,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      shape: shapeBorder?const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          )
      ):const RoundedRectangleBorder(),
      centerTitle: centerTitle,
      systemOverlayStyle: systemUiOverlayStyle??const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent
      ),
      backgroundColor:backColor??Colors.transparent ,
      leading: canBack
          ?
      IconButton(
              onPressed: onPop ??
                  () {
                    Navigator.pop(context);
                  },
              icon: Icon(
                Icons.arrow_back,
                color:leadingColor??AppColors.mainColor,
                size: 20.sp,
              ),
              ):0.verticalSpace,
      title: titleWidget?? TextWidget(
        title: title??"",
        fontFamily: "Itim",
        titleFontWeight: FontWeight.w400,
        titleSize: 24.sp,
          titleColor:titleColor ??AppColors.mainColor
      ),
      actions: actions
          ? [
            favourite ?
             Container(
            width: 31.w,
            height: 31.h,
            alignment: Alignment.center,
            margin: EdgeInsetsDirectional.symmetric(vertical: 5.h,),
            decoration:const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white
            ),
            child:
            InkWell(
              onTap:favouriteOnPressed?? (){},
              child: Icon(
                Icons.favorite_border,
                color: AppColors.gery70,
                size: 24.sp,
              ),
            )
        ):0.horizontalSpace,
             Container(
               width: 31.w,
               height: 31.h,
               alignment: Alignment.center,
               margin: EdgeInsetsDirectional.symmetric(vertical: 5.h,horizontal: 14.w),
               decoration:const BoxDecoration(
                shape: BoxShape.circle,
                 color: AppColors.white
               ),
               child:
               notify?
               Stack(
                 alignment: Alignment.topRight,
                 children: [
                   InkWell(
                       onTap:notificationOnPressed?? (){},
                       child: Icon(
                         Icons.notifications_none,
                         color: AppColors.gery70,
                         size: 24.sp,
                       ),
                   ),
                   Positioned(
                     right: 5.w,
                     top: 5.h,
                     child: CircleAvatar(
                       radius: 4.r,
                       backgroundColor: AppColors.red,
                     ),
                   )
                 ],
               )
                   :
               IconButton(
                 onPressed:notificationOnPressed?? (){},
                 icon: Icon(
                   Icons.notifications_none,
                   color: AppColors.gery70,
                   size: 25.sp,
                 ),
               ),
             ),

            ]
          : actionsWidgets,
      leadingWidth:leadingWidth ,

    );
  }

  @override
  Size get preferredSize => const Size(500, 66);
}
