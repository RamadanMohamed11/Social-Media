import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_stack/image_stack.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/core/utils/app_colors.dart';
import 'package:social_media/core/utils/assets_data.dart';

class FollowsAndFollowersWidget extends StatelessWidget {
  const FollowsAndFollowersWidget({
    super.key,
    required this.userModel,
    required this.isFollowers,
  });

  final UserModel userModel;
  final bool isFollowers;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.kWhiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          ImageStack(
            imageSource: ImageSource.Asset,
            imageRadius: 35,
            imageBorderColor: Colors.white,
            imageList: [AssetsData.man, AssetsData.woman],
            totalCount: 2,
          ),
          Gap(5),
          Row(
            children: [
              Text(
                isFollowers
                    ? userModel.followers.length.toString()
                    : userModel.following.length.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Gap(5),
              Text(
                isFollowers ? "Followers" : "Following",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
