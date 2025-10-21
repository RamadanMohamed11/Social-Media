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
  final bool? isCurrentUser;

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileCubit>(context).loadCurrentUserProfile();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileCurrentUserLoaded) {
            return Column(
              children: [
                UserImageAndFollowInfo(
                  userModel: widget.isCurrentUser!
                      ? state.userModel
                      : widget.userModel!,
                ),
                Gap(20),
                UserInfoAndContactButtons(
                  userModel: widget.isCurrentUser!
                      ? state.userModel
                      : widget.userModel!,
                  isCurrentUser:
                      state.userModel.uid ==
                      (widget.userModel?.uid ?? state.userModel.uid),
                ),
                Gap(5),
                BioWidget(
                  userModel: widget.isCurrentUser!
                      ? state.userModel
                      : widget.userModel!,
                ),
                Gap(10),
                TabBarWidget(tabController: _tabController),
                Gap(10),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ProfilePhotosGridView(
                        userModel: widget.isCurrentUser!
                            ? state.userModel
                            : widget.userModel!,
                      ),
                      ProfilePostsListView(
                        userModel: widget.isCurrentUser!
                            ? state.userModel
                            : widget.userModel!,
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is ProfileFailure) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
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
