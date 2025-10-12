import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_stack/image_stack.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/core/utils/app_colors.dart';
import 'package:social_media/core/utils/assets_data.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: Image.asset(AssetsData.man).image,
              ),
              Spacer(),
              FollowsAndFollowersWidget(
                userModel: userModel,
                isFollowers: true,
              ),
              Gap(5),
              FollowsAndFollowersWidget(
                userModel: userModel,
                isFollowers: false,
              ),
            ],
          ),
          Gap(20),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    userModel.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("@${userModel.username}"),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.kPrimaryColor,
                  foregroundColor: AppColors.kWhiteColor,
                ),
                child: Row(children: [Text("Follow"), Gap(5), Icon(Icons.add)]),
              ),
              Gap(5),
              IconButton(
                onPressed: () {},
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.kWhiteColor,
                  foregroundColor: AppColors.kPrimaryColor,
                  shape: const CircleBorder(
                    side: BorderSide(color: AppColors.kPrimaryColor),
                  ),
                ),
                icon: Icon(Icons.message),
              ),
            ],
          ),
          Gap(5),
          Row(
            children: [
              userModel.bio.isNotEmpty
                  ? Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.kPrimaryColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            userModel.bio,
                            style: TextStyle(
                              color: AppColors.kPrimaryColor,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}

class FollowsAndFollowersWidget extends StatelessWidget {
  const FollowsAndFollowersWidget({
    super.key,
    required this.userModel,
    required this.isFollowers,
  });

  final UserModel userModel;
  final bool isFollowers;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.kWhiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          ImageStack(
            imageSource: ImageSource.Asset,
            imageRadius: 35,
            imageBorderColor: Colors.white,
            imageList: [AssetsData.man, AssetsData.woman],
            totalCount: 2,
          ),
          Gap(5),
          Row(
            children: [
              Text(
                isFollowers
                    ? userModel.followers.length.toString()
                    : userModel.following.length.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Gap(5),
              Text(
                isFollowers ? "Followers" : "Following",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
