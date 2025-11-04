import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_media/core/utils/app_colors.dart';

class BioTextField extends StatelessWidget {
  const BioTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: (value) {
        controller.text = value;
      },

      decoration: InputDecoration(
        prefixIcon: const Padding(
          padding: EdgeInsets.all(11.0),
          child: FaIcon(FontAwesomeIcons.circleInfo),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 48,
          minHeight: 48,
        ),
        hintText: 'Bio',
        labelText: 'Bio',
        labelStyle: const TextStyle(color: AppColors.ksecondaryColor),

        fillColor: AppColors.kWhiteColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.kPrimaryColor),
        ),
      ),
    );
  }
}
