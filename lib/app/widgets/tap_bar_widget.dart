import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key, this.onTap, required this.tabController, required this.tabs});
 final void Function(int)? onTap;
 final TabController tabController;
 final List<Widget> tabs;
  @override
  Widget build(BuildContext context) {
    return TabBar(
      onTap: onTap,
      controller: tabController,
      isScrollable: true,
      indicatorColor: Colors.transparent,
      unselectedLabelColor: AppColors.field,
      labelColor: AppColors.mainColor,
      indicatorWeight: 1,
      dividerColor:Colors.transparent ,
      indicatorSize: TabBarIndicatorSize.tab,
      tabs:tabs
    );
  }
}
