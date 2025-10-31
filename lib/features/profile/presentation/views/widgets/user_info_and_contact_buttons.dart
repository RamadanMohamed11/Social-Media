import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/core/utils/app_colors.dart';
import 'package:gap/gap.dart';
import 'package:social_media/core/utils/authentication_service.dart';
import 'package:social_media/core/utils/service_locator.dart';
import 'package:social_media/features/profile/presentation/view_model/cubit/profile_cubit.dart';

class UserInfoAndContactButtons extends StatefulWidget {
  const UserInfoAndContactButtons({
    super.key,
    required this.userModel,
    this.isCurrentUser = false,
  });
  final bool isCurrentUser;

  final UserModel userModel;

  @override
  State<UserInfoAndContactButtons> createState() =>
      _UserInfoAndContactButtonsState();
}

class _UserInfoAndContactButtonsState extends State<UserInfoAndContactButtons> {
  late final Future<UserModel> _currentUserFuture;
  UserModel? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUserFuture = getIt.get<AuthenticationService>().getCurrentUser();
  }

  bool isFollowing(UserModel currentUser, UserModel viewedUser) {
    return currentUser.following.contains(viewedUser.uid);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel>(
      future: _currentUserFuture,
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.hasError || !asyncSnapshot.hasData) {
          return const SizedBox.shrink();
        }
        _currentUser ??= asyncSnapshot.data!;
        final UserModel currentUser = _currentUser!;
        return BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileCurrentUserLoaded && widget.isCurrentUser) {
              setState(() {
                _currentUser = state.userModel;
              });
            }
          },
          builder: (context, state) {
            return Row(
              children: [
                Expanded(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      widget.userModel.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("@${widget.userModel.username}"),
                  ),
                ),
                widget.isCurrentUser
                    ? const SizedBox()
                    : ElevatedButton(
                        onPressed: () async {
                          UserModel followingUser = currentUser;
                          UserModel followerUser = widget.userModel;
                          if (isFollowing(currentUser, widget.userModel)) {
                            followingUser.following.removeWhere(
                              (uid) => uid == followerUser.uid,
                            );
                            followerUser.followers.removeWhere(
                              (uid) => uid == followingUser.uid,
                            );
                          } else {
                            followerUser.followers.add((followingUser.uid));
                            followingUser.following.add((followerUser.uid));
                          }
                          setState(() {
                            _currentUser = followingUser;
                          });
                          await BlocProvider.of<ProfileCubit>(
                            context,
                          ).followUser(
                            followingUser: followingUser,
                            followerUser: followerUser,
                            isViewingCurrentUser: widget.isCurrentUser,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isFollowing(currentUser, widget.userModel)
                              ? AppColors.kWhiteColor
                              : AppColors.kPrimaryColor,
                          foregroundColor:
                              isFollowing(currentUser, widget.userModel)
                              ? AppColors.kPrimaryColor
                              : AppColors.kWhiteColor,
                        ),
                        child: Row(
                          children: [
                            Text(
                              isFollowing(currentUser, widget.userModel)
                                  ? "Unfollow"
                                  : "Follow",
                            ),
                            const Gap(5),
                            const Icon(Icons.add),
                          ],
                        ),
                      ),
                // const Gap(5),
                // widget.isCurrentUser
                //     ? const SizedBox()
                //     : IconButton(
                //         onPressed: () {},
                //         style: IconButton.styleFrom(
                //           backgroundColor: AppColors.kWhiteColor,
                //           foregroundColor: AppColors.kPrimaryColor,
                //           shape: const CircleBorder(
                //             side: BorderSide(color: AppColors.kPrimaryColor),
                //           ),
                //         ),
                //         icon: const Icon(Icons.message),
                //       ),
              ],
            );
          },
        );
      },
    );
  }
}
