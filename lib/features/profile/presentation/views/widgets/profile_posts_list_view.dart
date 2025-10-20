import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/models/post_model.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/features/home/presentation/view_model/home_view_cubit/home_view_cubit.dart';
import 'package:social_media/features/home/presentation/views/widgets/post_widget.dart';

class ProfilePostsListView extends StatelessWidget {
  const ProfilePostsListView({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PostModel>>(
      stream: BlocProvider.of<HomeViewCubit>(context).getPosts(),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (asyncSnapshot.hasData) {
          final List<PostModel> data = asyncSnapshot.data!;
          final List<PostModel> posts = data
              .where((post) => post.uid == userModel.uid)
              .toList();

          if (posts.isNotEmpty) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return PostWidget(userModel: userModel, post: posts[index]);
              },
            );
          } else {
            return Center(child: Text("No Photos"));
          }
        } else {
          return Center(child: Text(asyncSnapshot.error.toString()));
        }
      },
    );
  }
}
