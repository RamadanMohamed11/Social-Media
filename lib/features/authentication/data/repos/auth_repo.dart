import 'package:social_media/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:social_media/core/models/user_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, int>> signUp({
    required String email,
    required String password,
    required String name,
    required String username,
  });

  Future<Either<Failure, UserModel>> signIn({
    required String email,
    required String password,
  });
}
