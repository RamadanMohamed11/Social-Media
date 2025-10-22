import 'package:flutter/material.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/features/edit_profile/presentation/views/widgets/edit_profile_view_body.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: EditProfileViewBody(userModel: userModel),
    );
  }
}
