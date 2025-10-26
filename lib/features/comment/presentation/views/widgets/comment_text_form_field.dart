import 'package:flutter/material.dart';
import 'package:social_media/core/helper/text_form_filed_validations.dart';
import 'package:social_media/core/utils/app_colors.dart';

class CommentTextFormField extends StatelessWidget {
  const CommentTextFormField({
    super.key,
    required this.controller,
    this.onSaved,
  });
  final TextEditingController controller;
  final void Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: TextFormFiledValidations.commentValidation,
      controller: controller,
      onSaved: onSaved,
      decoration: InputDecoration(
        labelText: 'Type your comment here...',
        labelStyle: TextStyle(color: AppColors.ksecondaryColor),
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
