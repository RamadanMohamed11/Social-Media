import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/features/authentication/presentation/view_models/cubit/authentication_cubit.dart';
import 'package:social_media/features/profile/presentation/views/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await BlocProvider.of<AuthenticationCubit>(context).signOut();
            },
          ),
        ],
      ),
      body: ProfileViewBody(userModel: userModel),
    );
  }
}
