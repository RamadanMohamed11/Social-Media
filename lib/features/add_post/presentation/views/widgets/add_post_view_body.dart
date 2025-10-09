import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/core/utils/app_colors.dart';
import 'package:social_media/core/utils/assets_data.dart';
import 'package:social_media/core/utils/image_picker_method.dart';
import 'package:social_media/features/add_post/presentation/views/widgets/pick_image_button.dart';
import 'package:social_media/features/add_post/presentation/views/widgets/post_text_form_field.dart';

class AddPostViewBody extends StatefulWidget {
  const AddPostViewBody({super.key});

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

class PickedImage extends StatefulWidget {
  const PickedImage({super.key, required this.image, required this.onPressed});
  final Uint8List? image;
  final void Function()? onPressed;

  @override
  State<PickedImage> createState() => _PickedImageState();
}

class _PickedImageState extends State<PickedImage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(26),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: MemoryImage(widget.image!),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: IconButton(
            onPressed: widget.onPressed,
            icon: const Icon(Icons.close, size: 30, color: Colors.red),
          ),
        ),
      ],
    );
  }
}
