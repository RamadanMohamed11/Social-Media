import 'package:flutter/material.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/features/profile/presentation/views/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
          IconButton(icon: const Icon(Icons.logout), onPressed: () {}),
        ],
      ),
      body: ProfileViewBody(userModel: userModel),
    );
  }
}
