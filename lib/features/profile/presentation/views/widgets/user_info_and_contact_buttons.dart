import 'package:flutter/material.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/core/utils/app_colors.dart';
import 'package:gap/gap.dart';

class UserInfoAndContactButtons extends StatelessWidget {
  const UserInfoAndContactButtons({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
