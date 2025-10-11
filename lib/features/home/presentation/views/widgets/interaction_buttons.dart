import 'package:flutter/material.dart';
import 'package:social_media/core/models/post_model.dart';
import 'package:gap/gap.dart';

class InteractionButtons extends StatelessWidget {
  const InteractionButtons({super.key, required this.post});

  final PostModel? post;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.favorite_border_outlined),
        ),
        Text(post?.likes.length.toString() ?? "     "),
        Gap(20),
        IconButton(onPressed: () {}, icon: Icon(Icons.comment)),
        Text(post?.comments.length.toString() ?? "     "),
      ],
    );
  }
}
