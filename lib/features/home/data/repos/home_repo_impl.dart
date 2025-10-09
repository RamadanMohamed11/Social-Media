import 'package:dartz/dartz.dart';
import 'package:social_media/core/errors/failures.dart';
import 'package:social_media/core/models/post_model.dart';
import 'package:social_media/features/home/data/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  @override
  Future<Either<Failure, List<PostModel>>> getPosts() {
    throw UnimplementedError();
  }
}
