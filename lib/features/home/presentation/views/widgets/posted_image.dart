import 'package:flutter/material.dart';
import 'package:redacted/redacted.dart';
import 'package:social_media/core/models/post_model.dart';

class PostedImage extends StatelessWidget {
  const PostedImage({super.key, required this.post});

  final PostModel? post;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          post?.postImageURL ?? " ",
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Container(color: Colors.grey, width: 80, height: 110)
                  .redacted(
                    context: context,
                    redact: true,
                    configuration: RedactedConfiguration(
                      animationDuration: Duration(milliseconds: 450),
                    ),
                  ),
            );
          },
        ),
      ),
    );
  }
}
