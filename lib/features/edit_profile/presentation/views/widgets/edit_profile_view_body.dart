import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/core/utils/app_colors.dart';
import 'package:social_media/core/utils/assets_data.dart';
import 'package:social_media/core/utils/image_picker_method.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:redacted/redacted.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_media/features/authentication/presentation/views/widgets/custom_button.dart';
import 'package:social_media/features/authentication/presentation/views/widgets/name_text_form_field.dart';
import 'package:social_media/features/authentication/presentation/views/widgets/username_text_form_field.dart';
import 'package:social_media/features/edit_profile/presentation/view_model/cubit/edit_profile_cubit.dart';
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
  Uint8List? image;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

  ImageProvider<Object>? _backgroundImage() {
    // If the user selected a new image in-memory, show it immediately
    if (image != null) return MemoryImage(image!);

    // If user has a profile image URL, use cached network provider
    final String url = widget.userModel.profileImage;
    if (url.isNotEmpty) {
      return CachedNetworkImageProvider(url);
    }

    // Fallback to asset
    return const AssetImage(AssetsData.man);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Error: ${state.message}")));
        } else if (state is EditProfileSuccess) {
          // Clear the cache for the old profile image if it was changed
          if (image != null && widget.userModel.profileImage.isNotEmpty) {
            // Evict from CachedNetworkImage cache
            CachedNetworkImage.evictFromCache(widget.userModel.profileImage);
            // Also evict from Flutter's image cache
            final imageProvider = CachedNetworkImageProvider(
              widget.userModel.profileImage,
            );
            imageProvider.evict();
          }
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Profile updated successfully")),
          );
          // Go back to profile view
          GoRouter.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state is EditProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Gap(60),
                  Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundImage: _backgroundImage(),
                        ).redacted(
                          context: context,
                          redact:
                              image == null &&
                              widget.userModel.profileImage.isEmpty,
                          configuration: RedactedConfiguration(
                            animationDuration: const Duration(
                              milliseconds: 500,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -10,
                          right: -10,
                          child: IconButton(
                            onPressed: pickImageOnPressed,
                            style: IconButton.styleFrom(
                              backgroundColor: AppColors.ksecondaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: const FaIcon(
                              FontAwesomeIcons.pen,
                              color: AppColors.kWhiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(60),
                  NameTextFormField(
                    controller: nameController,
                    onSaved: nameOnSavedMethod,
                  ),
                  const Gap(30),
                  UsernameTextFormField(
                    controller: usernameController,
                    onSaved: usernameOnSavedMethod,
                  ),
                  const Gap(30),
                  BioTextField(controller: bioController),
                  const Gap(60),
                  CustomButton(text: "update", onPressed: onUpdatePressed),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void onUpdatePressed() async {
    if (formKey.currentState!.validate()) {
      UserModel updatedUser = widget.userModel;
      updatedUser.name = nameController.text;
      updatedUser.username = usernameController.text;
      updatedUser.bio = bioController.text;

      await BlocProvider.of<EditProfileCubit>(
        context,
      ).editProfile(updatedUser, image);
    }
  }

  void pickImageOnPressed() async {
    image = await imagePicker();
    setState(() {});
  }

  void removeImage() {
    image = null;
    setState(() {});
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
