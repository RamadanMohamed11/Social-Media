import 'dart:typed_data';

import 'package:flutter/material.dart';

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
