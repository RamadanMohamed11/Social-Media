import 'package:flutter/material.dart';
import 'package:social_media/core/models/post_model.dart';
import 'package:gap/gap.dart';
import 'package:social_media/core/utils/app_colors.dart';

class InteractionButtons extends StatelessWidget {
  const InteractionButtons({
    super.key,
    required this.post,
    this.onLoveTap,
    required this.currentUserId,
  });

  final PostModel? post;
  final VoidCallback? onLoveTap;
  final String currentUserId;

  @override
  Widget build(BuildContext context) {
    final isLiked = post?.likes.contains(currentUserId) ?? false;
    
    return Row(
      children: [
        IconButton(
          onPressed: onLoveTap,
          icon: isLiked
              ? Icon(Icons.favorite, color: AppColors.kPrimaryColor)
              : Icon(Icons.favorite_border_outlined),
        ),
        Text(post?.likes.length.toString() ?? "     "),
        Gap(20),
        IconButton(onPressed: () {}, icon: Icon(Icons.comment)),
        Text(post?.comments.length.toString() ?? "     "),
      ],
    );
  }
}
