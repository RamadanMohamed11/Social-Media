import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/core/utils/app_colors.dart';
import 'package:social_media/core/utils/app_router.dart';

class RegisterNowWidget extends StatelessWidget {
  const RegisterNowWidget({super.key, required this.isLogin});
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isLogin ? "Don't have an account?" : "Already have an account?",
          style: TextStyle(fontSize: 16),
        ),
        Gap(10),
        InkWell(
          onTap: () {
            if (isLogin) {
              GoRouter.of(context).push(AppRouter.kRegister);
            } else {
              GoRouter.of(context).pop(AppRouter.kLogin);
            }
          },
          child: Text(
            isLogin ? "Register now" : "Login now",
            style: TextStyle(fontSize: 16, color: AppColors.ksecondaryColor),
          ),
        ),
      ],
    );
  }
}
