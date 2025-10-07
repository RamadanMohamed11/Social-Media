import 'package:flutter/material.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/core/utils/app_colors.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        elevation: 0,
        selectedIndex: selectedIndex,
        backgroundColor: AppColors.kWhiteColor.withValues(alpha: 0.2),
        indicatorColor: AppColors.kPrimaryColor.withValues(alpha: 0.2),
        onDestinationSelected: (value) {
          selectedIndex = value;
          setState(() {});
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home),
            selectedIcon: Icon(Icons.home, color: AppColors.kPrimaryColor),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.add),
            selectedIcon: Icon(Icons.add, color: AppColors.kPrimaryColor),

            label: "Add",
          ),
          NavigationDestination(
            icon: Icon(Icons.search),

            selectedIcon: Icon(Icons.search, color: AppColors.kPrimaryColor),
            label: "Search",
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            selectedIcon: Icon(Icons.person, color: AppColors.kPrimaryColor),

            label: "Profile",
          ),
        ],
      ),
    );
  }
}
