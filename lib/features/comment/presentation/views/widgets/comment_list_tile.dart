import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:redacted/redacted.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/core/helper/time_ago_from.dart';
import 'package:social_media/core/utils/app_colors.dart';
import 'package:social_media/core/utils/app_router.dart';
import 'package:social_media/core/utils/assets_data.dart';
import 'package:social_media/features/comment/data/models/comment_model.dart';
import 'package:social_media/features/profile/presentation/view_model/cubit/profile_cubit.dart';

class CommentListTile extends StatelessWidget {
  const CommentListTile({super.key, required this.commentModel});
  final CommentModel commentModel;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: BlocProvider.of<ProfileCubit>(
        context,
        listen: false,
      ).getUserData(uid: commentModel.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
            child: ListTile(
              isThreeLine: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              trailing: const Text('    '),
              tileColor: AppColors.kWhiteColor,
              leading: const CircleAvatar(
                backgroundColor: AppColors.kWhiteColor,
              ),
              title: const Text('                  '),
              subtitle: const Text('                      '),
            ),
          ).redacted(
            context: context,
            redact: true,
            configuration: RedactedConfiguration(
              animationDuration: const Duration(milliseconds: 500),
            ),
          );
        }

        if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
            child: ListTile(
              isThreeLine: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              trailing: Text(timeAgoFrom(commentModel.createdAt)),
              tileColor: AppColors.kWhiteColor,
              leading: const CircleAvatar(
                backgroundColor: AppColors.kWhiteColor,
                backgroundImage: AssetImage(AssetsData.man),
              ),
              title: const Text('Unknown User'),
              subtitle: Text(commentModel.comment),
            ),
          );
        }

        final user = snapshot.data!['userModel'];
        final posts = snapshot.data!['posts'];
        return InkWell(
          onTap: () {
            GoRouter.of(context).push(
              AppRouter.kProfile,
              extra: {'userModel': user, 'posts': posts},
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
            child: ListTile(
              isThreeLine: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              trailing: Text(timeAgoFrom(commentModel.createdAt)),
              tileColor: AppColors.kWhiteColor,
              leading: CircleAvatar(
                backgroundColor: AppColors.kWhiteColor,
                backgroundImage: user.profileImage.isNotEmpty
                    ? NetworkImage(user.profileImage)
                    : const AssetImage(AssetsData.man) as ImageProvider,
              ),
              title: Text(user.name),
              subtitle: Text(commentModel.comment),
            ),
          ),
        );
      },
    );
  }
}
