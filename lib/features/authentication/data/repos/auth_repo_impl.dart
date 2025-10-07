import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media/core/errors/failures.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/core/utils/authentication_service.dart';
import 'package:social_media/features/authentication/data/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthenticationService authenticationService;

  AuthRepoImpl({required this.authenticationService});

  @override
  Future<Either<Failure, int>> signUp({
    required String email,
    required String password,
    required String name,
    required String username,
  }) async {
    try {
      await authenticationService.signUp(
        email: email,
        password: password,
        name: name,
        username: username,
      );
      return Right(1);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure.fromFirebaseAuthException(e));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserModel? userModel = await authenticationService.signIn(
        email: email,
        password: password,
      );
      return Right(userModel!);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure.fromFirebaseAuthException(e));
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }
}
