import 'package:social_media/core/models/post_model.dart';
import 'package:social_media/core/models/user_model.dart';

abstract class ProfileRepo {
  Future<List<PostModel>> getUserPosts({required String uid});
  Future<UserModel> getCurrentUser();

  Future<UserModel> getUser({required String uid});
  Future<void> followUser({
    required UserModel followingUser,
    required UserModel followerUser,
  });
}
