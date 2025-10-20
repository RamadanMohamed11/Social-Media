import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/features/profile/presentation/views/widgets/bio_widget.dart';
import 'package:social_media/features/profile/presentation/views/widgets/profile_photos_grid_view.dart';
import 'package:social_media/features/profile/presentation/views/widgets/profile_posts_list_view.dart';
import 'package:social_media/features/profile/presentation/views/widgets/tab_bar_widget.dart';
import 'package:social_media/features/profile/presentation/views/widgets/user_image_and_follow_info.dart';
import 'package:social_media/features/profile/presentation/views/widgets/user_info_and_contact_buttons.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        children: [
          UserImageAndFollowInfo(userModel: widget.userModel),
          Gap(20),
          UserInfoAndContactButtons(userModel: widget.userModel),
          Gap(5),
          BioWidget(userModel: widget.userModel),
          Gap(10),
          TabBarWidget(tabController: _tabController),
          Gap(10),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ProfilePhotosGridView(userModel: widget.userModel),
                ProfilePostsListView(userModel: widget.userModel),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
