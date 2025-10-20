import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/core/utils/authentication_service.dart';
import 'package:social_media/features/authentication/data/repos/auth_repo.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthRepo authRepo;
  final AuthenticationService authenticationService;
  AuthenticationCubit({
    required this.authRepo,
    required this.authenticationService,
  }) : super(AuthenticationInitial());

  void emitInitial() {
    emit(AuthenticationInitial());
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String username,
  }) async {
    emit(AuthenticationLoading());
    var result = await authRepo.signUp(
      email: email,
      password: password,
      name: name,
      username: username,
    );
    result.fold(
      (failure) {
        log('Authentication failed: ${failure.errorMessage}');
        emit(AuthenticationFailure(failure.errorMessage));
      },
      (success) {
        log('Authentication successful, emitting SignUpSuccess.');
        emit(AuthenticationSignUpSuccess());
      },
    );
  }

  Future<UserModel?> signIn({
    required String email,
    required String password,
  }) async {
    emit(AuthenticationLoading());
    var result = await authRepo.signIn(email: email, password: password);
    return result.fold(
      (failure) {
        emit(AuthenticationFailure(failure.errorMessage));
        return null;
      },
      (userResult) {
        emit(AuthenticationLoginSuccess());
        return userResult;
      },
    );
  }

  Future<void> signOut() async {
    emit(AuthenticationLoading());
    var result = await authRepo.signOut();
    result.fold(
      (failure) {
        emit(AuthenticationFailure(failure.errorMessage));
      },
      (success) {
        emit(AuthenticationSignOutSuccess());
      },
    );
  }
}
