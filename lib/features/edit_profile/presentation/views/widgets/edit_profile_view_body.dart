import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/core/utils/app_colors.dart';
import 'package:social_media/core/utils/assets_data.dart';
import 'package:social_media/features/authentication/presentation/views/widgets/custom_button.dart';
import 'package:social_media/features/authentication/presentation/views/widgets/name_text_form_field.dart';
import 'package:social_media/features/authentication/presentation/views/widgets/username_text_form_field.dart';
import 'package:social_media/features/edit_profile/presentation/views/widgets/bio_text_form_field.dart';

class EditProfileViewBody extends StatefulWidget {
  const EditProfileViewBody({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<EditProfileViewBody> createState() => _EditProfileViewBodyState();
}

class _EditProfileViewBodyState extends State<EditProfileViewBody> {
  late TextEditingController usernameController;
  late TextEditingController nameController;
  late TextEditingController bioController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    usernameController.text = widget.userModel.username;
    nameController = TextEditingController();
    nameController.text = widget.userModel.name;
    bioController = TextEditingController();
    bioController.text = widget.userModel.bio;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Gap(60),
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage(AssetsData.man),
                  ),
                  Positioned(
                    bottom: -10,
                    right: -10,
                    child: IconButton(
                      onPressed: () {},
                      style: IconButton.styleFrom(
                        backgroundColor: AppColors.ksecondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: Icon(Icons.edit, color: AppColors.kWhiteColor),
                    ),
                  ),
                ],
              ),
            ),
            Gap(60),
            NameTextFormField(
              controller: nameController,
              onSaved: nameOnSavedMethod,
            ),
            Gap(30),
            UsernameTextFormField(
              controller: usernameController,
              onSaved: usernameOnSavedMethod,
            ),
            Gap(30),
            BioTextField(controller: bioController),
            Gap(60),
            CustomButton(text: "update", onPressed: () {}),
          ],
        ),
      ),
    );
  }

  void nameOnSavedMethod(String? value) {
    nameController.text = value ?? '';
  }

  void usernameOnSavedMethod(String? value) {
    usernameController.text = value ?? '';
  }

  void bioOnSavedMethod(String? value) {
    bioController.text = value ?? '';
  }

  @override
  void dispose() {
    usernameController.dispose();
    nameController.dispose();
    bioController.dispose();
    super.dispose();
  }
}
