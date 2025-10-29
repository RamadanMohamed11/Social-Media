import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/core/models/post_model.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/features/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:social_media/features/profile/presentation/views/widgets/bio_widget.dart';
import 'package:social_media/features/profile/presentation/views/widgets/profile_photos_grid_view.dart';
import 'package:social_media/features/profile/presentation/views/widgets/profile_posts_list_view.dart';
import 'package:social_media/features/profile/presentation/views/widgets/tab_bar_widget.dart';
import 'package:social_media/features/profile/presentation/views/widgets/user_image_and_follow_info.dart';
import 'package:social_media/features/profile/presentation/views/widgets/user_info_and_contact_buttons.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({
    super.key,
    this.userModel,
    this.post,
    this.isCurrentUser = false,
  });

  final UserModel? userModel;
  final List<PostModel>? post;
  final bool isCurrentUser;

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    final profileCubit = context.read<ProfileCubit>();
    if (widget.isCurrentUser || widget.userModel == null) {
      profileCubit.loadCurrentUserProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool viewingCurrentUser = widget.isCurrentUser;

    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        buildWhen: (previous, current) => current is! ProfileFollowSuccess,
        builder: (context, state) {
          UserModel? displayUser;
          if (state is ProfileCurrentUserLoaded) {
            displayUser = state.userModel;
          } else if (state is ProfileOtherUserLoaded) {
            displayUser = state.userModel;
          } else if (!viewingCurrentUser) {
            displayUser = widget.userModel;
          }

          if (state is ProfileFailure) {
            return Center(child: Text(state.message));
          }

          if (displayUser == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final String currentUserId = state is ProfileCurrentUserLoaded
              ? state.userModel.uid
              : firebase_auth.FirebaseAuth.instance.currentUser?.uid ??
                    displayUser.uid;

          final bool isCurrentUserForButtons =
              viewingCurrentUser ||
              (state is ProfileCurrentUserLoaded &&
                  state.userModel.uid == displayUser.uid);

          return Column(
            children: [
              UserImageAndFollowInfo(userModel: displayUser),
              const Gap(20),
              UserInfoAndContactButtons(
                userModel: displayUser,
                isCurrentUser: isCurrentUserForButtons,
              ),
              const Gap(5),
              BioWidget(userModel: displayUser),
              const Gap(10),
              TabBarWidget(tabController: _tabController),
              const Gap(10),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ProfilePhotosGridView(userModel: displayUser),
                    ProfilePostsListView(
                      userModel: displayUser,
                      currentUserId: currentUserId,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
