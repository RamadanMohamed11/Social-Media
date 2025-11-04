import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_media/core/helper/text_form_filed_validations.dart';
import 'package:social_media/core/utils/app_colors.dart';

class UsernameTextFormField extends StatelessWidget {
  const UsernameTextFormField({
    super.key,
    required this.controller,
    required this.onSaved,
  });

  final TextEditingController controller;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onSaved: onSaved,
      validator: TextFormFiledValidations.usernameValidation,
      decoration: InputDecoration(
        prefixIcon: const Padding(
          padding: EdgeInsets.all(11.0),
          child: FaIcon(FontAwesomeIcons.user),
        ),
        hintText: 'Username',
        labelText: 'Username',
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
