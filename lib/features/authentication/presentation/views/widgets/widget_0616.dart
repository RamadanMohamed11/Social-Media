import 'package:flutter/material.dart';
import 'package:social_media/core/utils/app_colors.dart';

class Widget0616 extends StatelessWidget {
  const Widget0616({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "Post",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          "ly",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.kPrimaryColor,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
