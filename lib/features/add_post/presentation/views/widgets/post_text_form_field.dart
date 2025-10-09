import 'package:flutter/material.dart';
import 'package:social_media/core/helper/text_form_filed_validations.dart';

class PostTextFormField extends StatelessWidget {
  const PostTextFormField({
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
      validator: TextFormFiledValidations.postValidation,
      maxLines: 5,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: "What's on your mind?",
      ),
    );
  }
}
