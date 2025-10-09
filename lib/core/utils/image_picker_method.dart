import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

Future<Uint8List?> imagePicker() async {
  try {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      return image.readAsBytes();
    }
  } catch (e) {
    return null;
  }
  return null;
}
