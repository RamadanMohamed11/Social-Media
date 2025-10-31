import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/models/post_model.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/features/home/presentation/view_model/home_view_cubit/home_view_cubit.dart';
import 'package:social_media/features/home/presentation/views/widgets/posted_image.dart';

class ProfilePhotosGridView extends StatelessWidget {
  const ProfilePhotosGridView({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PostModel>>(
      stream: BlocProvider.of<HomeViewCubit>(context).getPosts(),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.hasData ||
            asyncSnapshot.connectionState == ConnectionState.waiting) {
          final List<PostModel> data =
              asyncSnapshot.connectionState == ConnectionState.waiting
              ? []
              : asyncSnapshot.data!;
          final List<PostModel> posts = data
              .where((post) => post.uid == userModel.uid)
              .toList();

          if (posts.isNotEmpty) {
            return GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount:
                  asyncSnapshot.connectionState == ConnectionState.waiting
                  ? 9
                  : posts.length,
              itemBuilder: (context, index) {
                return asyncSnapshot.connectionState == ConnectionState.waiting
                    ? const PostedImage()
                    : PostedImage(post: posts[index]);
              },
            );
          } else {
            return const Center(child: Text("No Photos"));
          }
        } else {
          return Center(child: Text(asyncSnapshot.error.toString()));
        }
      },
    );
  }
}
