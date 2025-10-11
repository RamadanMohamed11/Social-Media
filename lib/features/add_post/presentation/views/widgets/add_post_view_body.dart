import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/core/models/post_model.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/core/utils/assets_data.dart';
import 'package:social_media/core/utils/image_picker_method.dart';
import 'package:social_media/features/add_post/presentation/view_model/add_post_cubit/add_post_cubit.dart';
import 'package:social_media/features/add_post/presentation/views/widgets/pick_image_button.dart';
import 'package:social_media/features/add_post/presentation/views/widgets/picked_image.dart';
import 'package:social_media/features/add_post/presentation/views/widgets/post_text_form_field.dart';
import 'package:uuid/uuid.dart';

class AddPostViewBody extends StatefulWidget {
  const AddPostViewBody({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<AddPostViewBody> createState() => _AddPostViewBodyState();
}

class _AddPostViewBodyState extends State<AddPostViewBody> {
  Uint8List? image;
  late TextEditingController controller;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            Gap(20),
            Row(
              children: [
                const Text(
                  "Add Post",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                TextButton(
                  onPressed: onPostPressed,
                  child: const Text(
                    "Post",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Gap(20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(backgroundImage: AssetImage(AssetsData.man)),
                Gap(10),
                Expanded(
                  child: PostTextFormField(
                    controller: controller,
                    onSaved: postOnSave,
                  ),
                ),
              ],
            ),
            image == null
                ? Spacer()
                : Expanded(
                    child: PickedImage(image: image, onPressed: removeImage),
                  ),
            PickImageButton(onPressed: pickImageOnPressed),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void onPostPressed() {
    if (formKey.currentState!.validate()) {
      var pid = Uuid().v4();

      PostModel post = PostModel(
        pid: pid,
        uid: widget.userModel.uid,
        name: widget.userModel.name,
        username: widget.userModel.username,
        profileImage: widget.userModel.profileImage,
        caption: controller.text,
        postImageURL: "",
        likes: [],
        comments: [],
        createdAt: DateTime.now(),
      );
      BlocProvider.of<AddPostCubit>(context).addPost(post, image);
    }
  }

  void postOnSave(String? value) {
    if (formKey.currentState!.validate()) {
      controller.text = value ?? '';
    }
  }

  void pickImageOnPressed() async {
    image = await imagePicker();
    setState(() {});
  }

  void removeImage() {
    image = null;
    setState(() {});
  }
}
