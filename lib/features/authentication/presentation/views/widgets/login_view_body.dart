import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/core/utils/app_colors.dart';
import 'package:social_media/core/utils/app_router.dart';
import 'package:social_media/core/utils/assets_data.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 100),
            Center(
              child: SvgPicture.asset(
                AssetsData.nLogo,
                width: 150,
                height: 150,
                colorFilter: ColorFilter.mode(
                  AppColors.kPrimaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("06", style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  "16",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.kPrimaryColor,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Gap(20),
            const Text('Welcome Back', style: TextStyle(fontSize: 24)),
            Gap(30),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                hintText: 'Email',
                fillColor: AppColors.kWhiteColor,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.kPrimaryColor),
                ),
              ),
            ),
            Gap(20),

            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.password),
                hintText: 'Password',
                fillColor: AppColors.kWhiteColor,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.kPrimaryColor),
                ),
              ),
            ),
            Gap(30),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.kPrimaryColor,
                      padding: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      "Login".toUpperCase(),
                      style: TextStyle(
                        color: AppColors.kWhiteColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Gap(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(fontSize: 16),
                ),
                Gap(10),
                InkWell(
                  onTap: () {
                    GoRouter.of(context).push(AppRouter.kRegister);
                  },
                  child: const Text(
                    "Register now",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
