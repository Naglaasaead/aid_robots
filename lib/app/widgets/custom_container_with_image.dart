
import 'package:flutter/material.dart';

import '../utils/app_assets.dart';

class CustomContainerWithImage extends StatelessWidget {
  const CustomContainerWithImage({super.key, required this.widget, this.imageUrl});
 final Widget widget;
 final String ? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  imageUrl??AppImages.appLogo
              ),
              alignment: Alignment.center,
              opacity:.9,
              fit: BoxFit.cover
          )
      ),
      child: widget,
    );
  }
}
