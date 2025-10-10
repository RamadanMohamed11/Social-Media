import 'package:flutter/material.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/core/utils/app_colors.dart';
import 'package:social_media/features/authentication/presentation/views/widgets/widget_0616.dart';
import 'package:social_media/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.kWhiteColor.withValues(alpha: 0.9),
        elevation: 0,
        centerTitle: true,
        title: Widget0616(),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.message))],
      ),
      body: HomeViewBody(userModel: userModel),
    );
  }
}
