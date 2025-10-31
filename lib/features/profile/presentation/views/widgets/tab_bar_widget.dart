import 'package:flutter/material.dart';
import 'package:social_media/core/utils/app_colors.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key, required TabController tabController})
    : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: _tabController,
      indicatorColor: AppColors.ksecondaryColor,
      labelColor: AppColors.kPrimaryColor,
      unselectedLabelColor: Colors.grey,
      indicatorSize: TabBarIndicatorSize.tab,

      tabs: [
        const Tab(text: "Photos"),
        const Tab(text: "Posts"),
      ],
    );
  }
}
