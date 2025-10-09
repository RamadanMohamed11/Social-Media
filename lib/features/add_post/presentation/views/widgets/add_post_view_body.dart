import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/core/utils/app_colors.dart';
import 'package:social_media/core/utils/assets_data.dart';

class AddPostViewBody extends StatelessWidget {
  const AddPostViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kDefaultPadding),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(backgroundImage: AssetImage(AssetsData.man)),
              Gap(10),
              Expanded(
                child: TextFormField(
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "What's on your mind?",
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(10),
              shape: const CircleBorder(),
              backgroundColor: AppColors.ksecondaryColor,
            ),
            onPressed: () {},
            child: Icon(
              Icons.camera_alt_outlined,
              color: AppColors.kWhiteColor,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}
