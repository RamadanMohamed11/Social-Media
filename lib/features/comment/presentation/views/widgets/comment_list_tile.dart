import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/core/helper/time_ago_from.dart';
import 'package:social_media/core/models/user_model.dart';
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
            padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
            child: ListTile(
              isThreeLine: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              trailing: Text(timeAgoFrom(commentModel.createdAt)),
              tileColor: AppColors.kWhiteColor,
              leading: CircleAvatar(
                backgroundColor: AppColors.kWhiteColor,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              title: Text('Loading...'),
              subtitle: Text(commentModel.comment),
            ),
          );
        }

        if (snapshot.hasError) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
            child: ListTile(
              isThreeLine: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              trailing: Text(timeAgoFrom(commentModel.createdAt)),
              tileColor: AppColors.kWhiteColor,
              leading: CircleAvatar(
                backgroundColor: AppColors.kWhiteColor,
                backgroundImage: AssetImage(AssetsData.man),
              ),
              title: Text('Unknown User'),
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
            padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
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
                    : AssetImage(AssetsData.man) as ImageProvider,
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
