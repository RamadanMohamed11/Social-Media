import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/core/models/post_model.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/core/utils/app_router.dart';
import 'package:social_media/features/authentication/presentation/view_models/cubit/authentication_cubit.dart';
import 'package:social_media/features/edit_profile/presentation/view_model/cubit/edit_profile_cubit.dart';
import 'package:social_media/features/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:social_media/features/profile/presentation/views/widgets/profile_view_body.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key, this.userModel, this.post});
  final UserModel? userModel;
  final List<PostModel>? post;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool _shouldNavigateToEdit = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Error: ${state.message}")),
              );
            } else if (state is ProfileCurrentUserLoaded &&
                _shouldNavigateToEdit) {
              _shouldNavigateToEdit = false;
              GoRouter.of(
                context,
              ).push(AppRouter.kEditProfile, extra: state.userModel);
            }
          },
        ),
        BlocListener<EditProfileCubit, EditProfileState>(
          listener: (context, state) {
            if (state is EditProfileSuccess) {
              // Reload the profile to reflect updated information
              BlocProvider.of<ProfileCubit>(context).loadCurrentUserProfile();
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              widget.userModel == null
                  ? "Profile"
                  : "${widget.userModel!.name} Profile",
            ),
          ),
          surfaceTintColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: widget.userModel == null
                  ? const Icon(Icons.edit)
                  : const SizedBox(),
              onPressed: () async {
                _shouldNavigateToEdit = true;
                await BlocProvider.of<ProfileCubit>(
                  context,
                ).loadCurrentUserProfile();
              },
            ),
            IconButton(
              icon: widget.userModel == null
                  ? const Icon(Icons.logout)
                  : const SizedBox(),
              onPressed: () async {
                await BlocProvider.of<AuthenticationCubit>(context).signOut();
              },
            ),
          ],
        ),
        body: ProfileViewBody(
          userModel: widget.userModel,
          post: widget.post,
          isCurrentUser: widget.userModel == null,
        ),
      ),
    );
  }
}
