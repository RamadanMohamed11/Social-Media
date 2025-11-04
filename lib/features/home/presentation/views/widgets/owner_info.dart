import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media/core/models/post_model.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:gap/gap.dart';
import 'package:social_media/core/utils/app_colors.dart';
import 'package:social_media/core/utils/assets_data.dart';

class OwnerInfo extends StatelessWidget {
  const OwnerInfo({
    super.key,
    required this.post,
    required this.userModel,
    required this.postUserModel,
  });

  final PostModel? post;
  final UserModel? userModel;
  final UserModel? postUserModel;

  @override
  Widget build(BuildContext context) {
    final ImageProvider<Object>? avatarImage;
    if (post != null) {
      final profileImage = postUserModel?.profileImage;
      if (profileImage != null && profileImage.isNotEmpty) {
        avatarImage = CachedNetworkImageProvider(profileImage);
      } else {
        avatarImage = const AssetImage(AssetsData.man);
      }
    } else if (userModel?.profileImage.isNotEmpty ?? false) {
      avatarImage = CachedNetworkImageProvider(userModel!.profileImage);
    } else {
      avatarImage = const AssetImage(AssetsData.man);
    }

    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.kWhiteColor,
          backgroundImage: avatarImage,
        ),
        const Gap(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              postUserModel?.name ?? "                    ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text("@${postUserModel?.username ?? "     "}"),
          ],
        ),
        const Spacer(),
        Text(
          "${post?.createdAt.day}/${post?.createdAt.month}/${post?.createdAt.year}",
        ),
      ],
    );
  }
}
