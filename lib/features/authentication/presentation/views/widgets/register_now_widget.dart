import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/core/utils/app_colors.dart';
import 'package:social_media/core/utils/app_router.dart';

class RegisterNowWidget extends StatelessWidget {
  const RegisterNowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?", style: TextStyle(fontSize: 16)),
        Gap(10),
        InkWell(
          onTap: () {
            GoRouter.of(context).push(AppRouter.kRegister);
          },
          child: const Text(
            "Register now",
            style: TextStyle(fontSize: 16, color: AppColors.kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
