import 'package:flutter/material.dart';
import 'package:social_media/core/utils/app_colors.dart';
import 'package:social_media/core/utils/assets_data.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircleAvatar(
        radius: 117,
        backgroundColor: AppColors.ksecondaryColor,
        child: CircleAvatar(
          radius: 115,
          backgroundImage: AssetImage(AssetsData.icon),
        ),
      ),
    );
  }
}
