import 'package:social_media/core/models/post_model.dart';

abstract class CommentRepo {
  Future<void> addComment({required PostModel newPost});
}
