import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/core/models/post_model.dart';
import 'package:gap/gap.dart';
import 'package:social_media/core/utils/app_colors.dart';
import 'package:social_media/core/utils/app_router.dart';

class InteractionButtons extends StatelessWidget {
  const InteractionButtons({
    super.key,
    required this.post,
    this.onLoveTap,
    required this.currentUserId,
    this.onCommentTap,
  });

  final PostModel? post;
  final VoidCallback? onLoveTap;
  final VoidCallback? onCommentTap;
  final String currentUserId;

  @override
  Widget build(BuildContext context) {
    final isLiked = post?.likes.contains(currentUserId) ?? false;

    return Row(
      children: [
        IconButton(
          onPressed: onLoveTap,
          icon: isLiked
              ? const Icon(Icons.favorite, color: AppColors.kPrimaryColor)
              : const Icon(Icons.favorite_border_outlined),
        ),
        Text(post?.likes.length.toString() ?? "     "),
        const Gap(20),
        IconButton(
          onPressed: () {
            GoRouter.of(context).push(AppRouter.kCommentView, extra: post);
          },
          icon: const Icon(Icons.comment),
        ),
        Text(post?.comments.length.toString() ?? "     "),
      ],
    );
  }
}
