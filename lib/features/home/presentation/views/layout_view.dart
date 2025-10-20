import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/core/utils/app_colors.dart';
import 'package:social_media/core/utils/app_router.dart';

import 'package:social_media/features/add_post/presentation/view_model/add_post_cubit/add_post_cubit.dart';
import 'package:social_media/features/add_post/presentation/views/add_post_view.dart';
import 'package:social_media/features/authentication/presentation/view_models/cubit/authentication_cubit.dart';
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
  late int selectedIndex;
  late List<Widget> myPages;
  late PageController pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex = 0;
    pageController = PageController();
    myPages = [
      HomeView(userModel: widget.userModel),
      AddPostView(userModel: widget.userModel),
      SearchView(userModel: widget.userModel),
      ProfileView(userModel: widget.userModel),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationSignOutSuccess) {
          GoRouter.of(context).pushReplacement(AppRouter.kLogin);
        }
      },
      builder: (context, state) {
        if (state is AuthenticationLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          return Scaffold(
            extendBody: selectedIndex == 0,
            bottomNavigationBar: BlocConsumer<AddPostCubit, AddPostState>(
              listener: (context, state) {
                if (state is AddPostSuccess) {
                  selectedIndex = 0;
                  BlocProvider.of<AddPostCubit>(context).emitInitial();
                }
              },
              builder: (context, state) {
                return NavigationBar(
                  elevation: 0,
                  selectedIndex: selectedIndex,
                  backgroundColor: AppColors.kWhiteColor.withValues(
                    alpha: 0.95,
                  ),
                  indicatorColor: AppColors.kPrimaryColor.withValues(
                    alpha: 0.2,
                  ),
                  onDestinationSelected: (value) {
                    selectedIndex = value;
                    pageController.animateToPage(
                      value,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    setState(() {});
                  },
                  destinations: [
                    NavigationDestination(
                      icon: Icon(Icons.home),
                      selectedIcon: Icon(
                        Icons.home,
                        color: AppColors.kPrimaryColor,
                      ),
                      label: "Home",
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.add),
                      selectedIcon: Icon(
                        Icons.add,
                        color: AppColors.kPrimaryColor,
                      ),

                      label: "Add",
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.search),

                      selectedIcon: Icon(
                        Icons.search,
                        color: AppColors.kPrimaryColor,
                      ),
                      label: "Search",
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.person),
                      selectedIcon: Icon(
                        Icons.person,
                        color: AppColors.kPrimaryColor,
                      ),

                      label: "Profile",
                    ),
                  ],
                );
              },
            ),
            body: BlocConsumer<AddPostCubit, AddPostState>(
              listener: (context, state) {
                if (state is AddPostSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          "Post added successfully",
                          style: TextStyle(color: AppColors.kWhiteColor),
                        ),
                      ),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is AddPostInitial || state is AddPostSuccess) {
                  return PageView(
                    controller: pageController,
                    onPageChanged: (value) {
                      if (state is AddPostSuccess) {
                        selectedIndex = 0;
                        pageController.animateToPage(
                          0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                        BlocProvider.of<AddPostCubit>(context).emitInitial();
                      }
                      selectedIndex = value;
                      setState(() {});
                    },
                    children: myPages,
                  );
                } else if (state is AddPostLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const Center(child: Text("Something went wrong"));
                }
              },
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }
}
