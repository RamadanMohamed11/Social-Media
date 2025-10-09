import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media/core/errors/failures.dart';
import 'package:social_media/core/models/post_model.dart';
import 'package:social_media/core/utils/cloud_service.dart';
import 'package:social_media/features/add_post/data/repos/add_post_repo.dart';

class AddPostRepoImpl implements AddPostRepo {
  final CloudService cloudService;

  AddPostRepoImpl({required this.cloudService});

  @override
  Future<Either<Failure, int>> addPost(PostModel post) async {
    try {
      await cloudService.storeData(obj: post.toJson(), docId: post.pid);
      return Right(1);
    } on FirebaseException catch (e) {
      return Left(CloudFailure.fromException(e));
    } catch (e) {
      return Left(CloudFailure(e.toString()));
    }
  }
}
