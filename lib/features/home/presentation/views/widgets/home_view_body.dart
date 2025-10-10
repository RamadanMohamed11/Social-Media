import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/core/utils/app_colors.dart';
import 'package:social_media/core/utils/assets_data.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
            margin: const EdgeInsets.only(bottom: kDefaultPadding),
            decoration: BoxDecoration(
              color: AppColors.kWhiteColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(backgroundImage: AssetImage(AssetsData.man)),
                    Gap(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userModel.name),
                        Text("@${userModel.username}"),
                      ],
                    ),
                    const Spacer(),
                    const Text("20/10/2025"),
                  ],
                ),
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(AssetsData.man)),
                  ),
                ),
                Gap(10),
                Text(
                  "asdawdwasdwafsdklgdfjnbkcngfbklcgfnbkldf ksldfgmdlfk mlkdfn lkdfgm lkdfasdwasdawdasdawdasdas",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(onPressed: () {}, child: Text("See More")),
                ),
                Gap(10),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.favorite_border_outlined),
                    ),
                    Text("0"),
                    Gap(20),
                    IconButton(onPressed: () {}, icon: Icon(Icons.comment)),
                    Text("0"),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
