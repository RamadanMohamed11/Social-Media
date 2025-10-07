import 'package:flutter/material.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: HomeViewBody(userModel: userModel));
  }
}
