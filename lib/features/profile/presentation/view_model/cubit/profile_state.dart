part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileCurrentUserLoaded extends ProfileState {
  final UserModel userModel;
  final List<PostModel> posts;

  ProfileCurrentUserLoaded({required this.userModel, required this.posts});
}

final class ProfileOtherUserLoaded extends ProfileState {
  final UserModel userModel;
  final List<PostModel> posts;
  final bool shouldNavigate;

  ProfileOtherUserLoaded({
    required this.userModel,
    required this.posts,
    this.shouldNavigate = true,
  });
}

final class ProfileFailure extends ProfileState {
  final String message;

  ProfileFailure({required this.message});
}

final class ProfileFollowSuccess extends ProfileState {}
