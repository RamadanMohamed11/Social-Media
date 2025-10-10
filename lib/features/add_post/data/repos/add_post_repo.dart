import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:social_media/core/errors/failures.dart';
import 'package:social_media/core/models/post_model.dart';

abstract class AddPostRepo {
  Future<Either<Failure, int>> addPost(PostModel post, Uint8List? postImage);
}
