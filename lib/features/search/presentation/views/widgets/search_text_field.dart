import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_media/core/utils/app_colors.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    super.key,
    required this.controller,
    required this.onChange,
  });
  final TextEditingController controller;
  final Function(String) onChange;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  bool isTextFieldPressed = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        setState(() {
          isTextFieldPressed = true;
        });
      },

      onSubmitted: (value) {
        setState(() {
          isTextFieldPressed = false;
        });
      },
      onChanged: widget.onChange,
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: Padding(
          padding: const EdgeInsets.all(11.0),
          child: FaIcon(
            FontAwesomeIcons.magnifyingGlass,
            color: isTextFieldPressed ? AppColors.kPrimaryColor : Colors.grey,
          ),
        ),
        hintText: 'Search by username',
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
