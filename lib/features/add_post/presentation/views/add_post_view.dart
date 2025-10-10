import 'package:flutter/material.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/features/add_post/presentation/views/widgets/add_post_view_body.dart';

class AddPostView extends StatelessWidget {
  const AddPostView({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AddPostViewBody(userModel: userModel));
  }
}
