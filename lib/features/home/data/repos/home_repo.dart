import 'package:dartz/dartz.dart';
import 'package:social_media/core/errors/failures.dart';
import 'package:social_media/core/models/post_model.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<PostModel>>> getPosts();
}
