import 'package:flutter/material.dart';
import 'package:social_media/core/models/post_model.dart';
import 'package:social_media/features/comment/presentation/views/widgets/comment_view_body.dart';

class CommentView extends StatelessWidget {
  const CommentView({super.key, required this.post});
  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const FittedBox(fit: BoxFit.scaleDown, child: Text('Comments')),
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: CommentViewBody(postModel: post),
    );
  }
}
