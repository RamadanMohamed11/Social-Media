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
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.kWhiteColor,
          backgroundImage: post != null
              ? (postUserModel!.profileImage.isNotEmpty
                    ? CachedNetworkImageProvider(postUserModel!.profileImage)
                    : const AssetImage(AssetsData.man))
              : null,
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
