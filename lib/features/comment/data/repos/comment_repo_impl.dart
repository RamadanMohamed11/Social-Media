import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/core/errors/failures.dart';
import 'package:social_media/core/models/post_model.dart';
import 'package:social_media/core/utils/cloud_service.dart';
import 'package:social_media/features/comment/data/repos/comment_repo.dart';

class CommentRepoImpl implements CommentRepo {
  final CloudService cloudService;
  CommentRepoImpl({required this.cloudService});
  @override
  Future<void> addComment({required PostModel newPost}) async {
    try {
      await cloudService.updateData(obj: newPost.toJson(), docId: newPost.pid);
    } on FirebaseException catch (e) {
      throw CloudFailure.fromException(e);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
