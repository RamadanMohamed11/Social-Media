import 'package:flutter/material.dart';
import 'package:social_media/features/add/presentation/views/widgets/add_view_model.dart';

class AddView extends StatelessWidget {
  const AddView({super.key});

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
      body: const AddViewModel(),
    );
  }
}
