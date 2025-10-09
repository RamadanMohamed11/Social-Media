import 'package:flutter/material.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/core/utils/app_colors.dart';
import 'package:social_media/features/add_post/presentation/views/add_post_view.dart';
import 'package:social_media/features/home/presentation/views/home_view.dart';
import 'package:social_media/features/profile/presentation/views/profile_view.dart';
import 'package:social_media/features/search/presentation/views/search_view.dart';

class LayoutView extends StatefulWidget {
  const LayoutView({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<LayoutView> createState() => _LayoutViewState();
}

class _LayoutViewState extends State<LayoutView> {
  int selectedIndex = 0;
  late List<Widget> myPages;
  late PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
    myPages = [
      HomeView(userModel: widget.userModel),
      AddPostView(),
      SearchView(),
      ProfileView(),
    ];
  }

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
          pageController.jumpToPage(value);
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
      body: PageView(
        controller: pageController,
        onPageChanged: (value) {
          selectedIndex = value;
          setState(() {});
        },
        children: myPages,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }
}
