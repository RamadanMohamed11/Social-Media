import 'package:flutter/material.dart';
import 'package:social_media/core/utils/app_colors.dart';

class Widget0616 extends StatelessWidget {
  const Widget0616({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("06", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        Text(
          "16",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.kPrimaryColor,
          ),
        ),
      ],
    );
  }
}
