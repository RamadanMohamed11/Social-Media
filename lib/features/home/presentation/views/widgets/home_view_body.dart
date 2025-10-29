import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:redacted/redacted.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/core/models/post_model.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/core/utils/app_router.dart';
import 'package:social_media/features/home/presentation/view_model/home_view_cubit/home_view_cubit.dart';
import 'package:social_media/features/home/presentation/views/widgets/post_widget.dart';
import 'package:social_media/features/profile/presentation/view_model/cubit/profile_cubit.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileOtherUserLoaded) {
          GoRouter.of(context).push(
            AppRouter.kProfile,
            extra: {'userModel': state.userModel, 'posts': state.posts},
          );
        } else if (state is ProfileFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Error: ${state.message}")));
        }
      },
      child: StreamBuilder<List<PostModel>>(
        stream: BlocProvider.of<HomeViewCubit>(context).getPosts(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const PostWidget().redacted(
                    context: context,
                    redact: true,
                    configuration: RedactedConfiguration(
                      animationDuration: const Duration(milliseconds: 500),
                    ),
                  );
                },
              ),
            );
          }
          if (asyncSnapshot.hasError) {
            return Center(child: Text(asyncSnapshot.error.toString()));
          } else if (asyncSnapshot.hasData) {
            final List<PostModel> posts = asyncSnapshot.data!;
            if (posts.isEmpty) {
              return const Center(
                child: Text(
                  "No Posts",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return PostWidget(
                      userModel: userModel,
                      post: post,
                      onOwnerTap: () {
                        BlocProvider.of<ProfileCubit>(
                          context,
                        ).loadUserProfile(uid: post.uid);
                      },
                      onLoveTap: () async {
                        final profileCubit = BlocProvider.of<ProfileCubit>(
                          context,
                        );
                        final currentUser = await profileCubit.profileRepo
                            .getCurrentUser();

                        if (post.likes.contains(currentUser.uid)) {
                          post.likes.remove(currentUser.uid);
                        } else {
                          post.likes.add(currentUser.uid);
                        }

                        await BlocProvider.of<HomeViewCubit>(
                          context,
                        ).lovePost(newPost: post);
                      },
                    );
                  },
                ),
              );
            }
          } else {
            return const Center(child: Text("No Posts"));
          }
        },
      ),
    );
  }
}
