import 'package:flutter/material.dart';
import 'package:social_media/features/add_post/presentation/views/widgets/add_post_view_body.dart';

class AddPostView extends StatelessWidget {
  const AddPostView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Row(
          children: [
            const Text("Add Post"),
            const Spacer(),
            TextButton(onPressed: () {}, child: const Text("Post")),
          ],
        ),
      ),
      body: const AddPostViewBody(),
    );
  }
}
