import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:social_media/core/errors/failures.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/core/utils/cloud_service.dart';
import 'package:social_media/core/utils/storage_service.dart';
import 'package:social_media/features/edit_profile/data/repos/edit_profile_repo.dart';

class EditProfileRepoImpl implements EditProfileRepo {
  final CloudService cloudService;
  final StorageService storageService;
  EditProfileRepoImpl({
    required this.cloudService,
    required this.storageService,
  });
  Future<Uint8List?> _urlToBytes(String imageUrl) async {
    try {
      final response = await Dio().get(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );
      return Uint8List.fromList(response.data);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Either<Failure, void>> editProfile({
    required UserModel userModel,
  }) async {
    try {
      await cloudService.updateData(
        obj: userModel.toJson(),
        docId: userModel.uid,
      );

      // Convert URL to bytes if it's a URL
      if (userModel.profileImage.startsWith('http')) {
        final imageBytes = await _urlToBytes(userModel.profileImage);
        if (imageBytes != null) {
          await storageService.updateData(
            bucketId: 'avatars',
            fileName: userModel.uid,
            file: imageBytes,
          );
        }
      }

      return Right(null);
    } on FirebaseException catch (e) {
      return Left(CloudFailure.fromException(e));
    } catch (e) {
      return Left(CloudFailure(e.toString()));
    }
  }
}
