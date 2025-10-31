part of 'edit_profile_cubit.dart';

@immutable
sealed class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}

final class EditProfileLoading extends EditProfileState {}

final class EditProfileSuccess extends EditProfileState {
  final UserModel updatedUser;
  EditProfileSuccess({required this.updatedUser});
}

final class EditProfileFailure extends EditProfileState {
  final String message;
  EditProfileFailure({required this.message});
}
