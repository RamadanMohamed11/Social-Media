import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media/core/errors/failures.dart';
import 'package:social_media/core/models/post_model.dart';
import 'package:social_media/core/utils/cloud_service.dart';
import 'package:social_media/core/utils/storage_service.dart';
import 'package:social_media/features/add_post/data/repos/add_post_repo.dart';

class AddPostRepoImpl implements AddPostRepo {
  final CloudService cloudService;
  final StorageService storageService;

  AddPostRepoImpl({required this.cloudService, required this.storageService});

  @override
  Future<Either<Failure, int>> addPost(
    PostModel post,
    Uint8List? postImage,
  ) async {
    try {
      await cloudService.storeData(obj: post.toJson(), docId: post.pid);
      if (postImage != null) {
        await storageService.uploadData(
          bucketId: 'posts',
          fileName: post.pid,
          file: postImage,
        );
      }
      return Right(1);
    } on FirebaseException catch (e) {
      return Left(CloudFailure.fromException(e));
    } catch (e) {
      return Left(CloudFailure(e.toString()));
    }
  }
}
