import 'package:flutter/material.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/core/utils/app_colors.dart';

class BioWidget extends StatelessWidget {
  const BioWidget({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
