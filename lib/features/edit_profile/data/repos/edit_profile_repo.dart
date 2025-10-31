import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:social_media/core/errors/failures.dart';
import 'package:social_media/core/models/user_model.dart';

abstract class EditProfileRepo {
  Future<Either<Failure, UserModel>> editProfile({
    required UserModel userModel,
    Uint8List? userImage,
  });
}
