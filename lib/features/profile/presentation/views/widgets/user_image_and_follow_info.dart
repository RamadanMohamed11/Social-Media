import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/core/utils/assets_data.dart';
import 'package:social_media/features/profile/presentation/views/widgets/follows_and_followers_widget.dart';

class UserImageAndFollowInfo extends StatelessWidget {
  const UserImageAndFollowInfo({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: Image.asset(AssetsData.man).image,
        ),
        Spacer(),
        FollowsAndFollowersWidget(userModel: userModel, isFollowers: true),
        Gap(5),
        FollowsAndFollowersWidget(userModel: userModel, isFollowers: false),
      ],
    );
  }
}
