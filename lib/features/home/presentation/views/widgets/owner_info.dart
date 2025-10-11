import 'package:flutter/material.dart';
import 'package:social_media/core/models/post_model.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:gap/gap.dart';
import 'package:social_media/core/utils/app_colors.dart';
import 'package:social_media/core/utils/assets_data.dart';

class OwnerInfo extends StatelessWidget {
  const OwnerInfo({super.key, required this.post, required this.userModel});

  final PostModel? post;
  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.kWhiteColor,
          backgroundImage: post != null ? AssetImage(AssetsData.man) : null,
        ),
        Gap(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post?.name ?? "                    "),
            Text("@${post?.username ?? "     "}"),
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
