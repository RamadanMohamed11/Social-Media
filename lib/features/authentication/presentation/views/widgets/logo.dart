import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_media/core/utils/app_colors.dart';
import 'package:social_media/core/utils/assets_data.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        AssetsData.nLogo,
        width: 150,
        height: 150,
        colorFilter: ColorFilter.mode(AppColors.kPrimaryColor, BlendMode.srcIn),
      ),
    );
  }
}
