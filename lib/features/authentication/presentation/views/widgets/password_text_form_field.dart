import 'package:flutter/material.dart';
import 'package:social_media/core/utils/app_colors.dart';

class PasswordTextFormField extends StatelessWidget {
  const PasswordTextFormField({
    super.key,
    required this.controller,
    required this.onSaved,
  });
  final TextEditingController controller;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      controller: controller,
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
    );
  }
}
