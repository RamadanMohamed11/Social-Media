import 'package:social_media/core/models/post_model.dart';

abstract class HomeRepo {
  Stream<List<PostModel>> getPosts();
  Future<void> lovePost({required PostModel newPost});
}
