import 'package:flutter/material.dart';
import 'package:social_media/core/utils/app_colors.dart';

class PickImageButton extends StatelessWidget {
  const PickImageButton({super.key, required this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(10),
        shape: const CircleBorder(),
        backgroundColor: AppColors.ksecondaryColor,
      ),
      onPressed: onPressed,
      child: const Icon(
        Icons.camera_alt_outlined,
        color: AppColors.kWhiteColor,
        size: 25,
      ),
    );
  }
}
