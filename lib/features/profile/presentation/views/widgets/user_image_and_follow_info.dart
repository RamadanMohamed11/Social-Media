import 'package:cached_network_image/cached_network_image.dart';
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
          foregroundImage: userModel.profileImage.isNotEmpty
              ? CachedNetworkImageProvider(userModel.profileImage)
              : Image.asset(AssetsData.man).image,
        ),
        const Spacer(),
        FollowsAndFollowersWidget(userModel: userModel, isFollowers: true),
        const Gap(5),
        FollowsAndFollowersWidget(userModel: userModel, isFollowers: false),
      ],
    );
  }
}
