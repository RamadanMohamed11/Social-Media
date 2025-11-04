import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_media/core/utils/app_colors.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    super.key,
    required this.controller,
    required this.onSaved,
  });
  final TextEditingController controller;
  final void Function(String?)? onSaved;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObsecure,
      onSaved: widget.onSaved,
      controller: widget.controller,
      decoration: InputDecoration(
        // Center the lock icon vertically.
        prefixIcon: const Padding(
          padding: EdgeInsets.all(11.0),
          child: FaIcon(FontAwesomeIcons.lock),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 48,
          minHeight: 48,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            isObsecure = !isObsecure;
            setState(() {});
          },
          icon: FaIcon(
            isObsecure ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
          ),
        ),
        hintText: 'Password',
        labelText: 'Password',
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
