import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/core/models/post_model.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/core/utils/app_colors.dart';
import 'package:social_media/features/home/presentation/views/widgets/interaction_buttons.dart';
import 'package:social_media/features/home/presentation/views/widgets/owner_info.dart';
import 'package:social_media/features/home/presentation/views/widgets/posted_image.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({
    super.key,
    this.userModel,
    this.postUserModel,
    this.post,
    this.onOwnerTap,
    this.onLoveTap,
    this.onCommentTap,
  });

  final UserModel? userModel;
  final UserModel? postUserModel;
  final PostModel? post;
  final VoidCallback? onOwnerTap;
  final VoidCallback? onLoveTap;
  final VoidCallback? onCommentTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: kDefaultPadding),
      decoration: BoxDecoration(
        color: AppColors.kWhiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onOwnerTap,
            child: OwnerInfo(
              post: post,
              userModel: userModel,
              postUserModel: postUserModel,
            ),
          ),
          const Gap(10),
          post != null && post!.postImageURL.isNotEmpty
              ? InkWell(
                  onTap: () {
                    _openPostImageDialog(context);
                  },
                  child: PostedImage(post: post),
                )
              : const SizedBox(),
          const Gap(10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              post?.caption ?? "                         ",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          const Gap(10),
          InteractionButtons(
            post: post,
            onLoveTap: onLoveTap,
            currentUserId: userModel?.uid ?? "",
          ),
        ],
      ),
    );
  }

  void _openPostImageDialog(BuildContext context) {
    if (post != null) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          backgroundColor: Colors.black,
          child: Stack(
            children: [
              InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                child: Center(
                  child: Image.network(
                    post?.postImageURL ?? " ",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.kWhiteColor,
                    size: 30,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
