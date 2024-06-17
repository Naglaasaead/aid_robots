import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/ui_helpers.dart';

class ButtonWidget extends StatelessWidget {

  const ButtonWidget({super.key,
    this.borderRadius,this.borderRadiusObject,
    this.textSize = 18,this.text, this.icon,
    this.color , this.border,this.onPressed,
    this.width=double.infinity, this.height ,this.decoration ,
    this.textColor,this.loading =false,this.child ,
    this.horizontalPadding=0,this.verticalPadding=8,
    this.outlined=true, this.align,this.fontFamily, this.horizontalMargin= 0,  this.verticalMargin=0, this.mainAxisAlignment, this.fontWeight,
  });
  final String? text ;
  final Function()? onPressed ;
  final double? width ;
  final double? height ;
  final double? textSize ;
  final BoxDecoration? decoration;
  final Color? textColor ;
  final bool loading ;
  final Color? color ;
  final Border? border ;
  final TextAlign? align ;
  final Widget? icon ;
  final double? borderRadius;
  final double horizontalPadding;
  final double horizontalMargin;
  final double verticalPadding;
  final double verticalMargin;
  final BorderRadius? borderRadiusObject ;
  final Widget? child ;
  final bool outlined;
  final String? fontFamily;
  final FontWeight ? fontWeight;
  final MainAxisAlignment ?mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return loading ? const Center(child: CircularProgressIndicator(color: AppColors.mainColor ,))
        :
    InkWell(
      onTap: (){
        UIHelpers.removeKeyboard();
        if(onPressed!= null ){
          onPressed!();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal:horizontalPadding ,vertical:verticalPadding ),
        margin: EdgeInsets.symmetric(horizontal:horizontalMargin ,vertical:verticalMargin ),
         width: width??345.w,
          height: height ?? 66.h,
          decoration: decoration ?? BoxDecoration(
              color: color ??AppColors.mainColor ,
              borderRadius:borderRadiusObject ??BorderRadius.circular(borderRadius ?? 15),
              border: outlined?Border.all(color:color ??AppColors.mainColor,):border
          ),
          child:child??Row(
            mainAxisAlignment:mainAxisAlignment?? MainAxisAlignment.center,
            children: [
              icon??const SizedBox(),
              if (icon!= null && (text?.isNotEmpty??false)) const SizedBox(width: 8,) else Container(),
              Text(
                text??"" ,
                textAlign:align ,
                style: TextStyle(
                    color: textColor??AppColors.white ,
                    fontSize: textSize??20.sp ,
                    fontWeight: fontWeight??FontWeight.w400,
                    fontFamily: fontFamily
                ),
              ),
            ],
          ),
      ),
    );
  }
}