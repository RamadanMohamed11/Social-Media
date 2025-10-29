import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_media/core/models/post_model.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/features/profile/data/repos/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;
  ProfileCubit({required this.profileRepo}) : super(ProfileInitial());

  Future<void> loadCurrentUserProfile() async {
    emit(ProfileLoading());
    try {
      UserModel userModel = await profileRepo.getCurrentUser();
      List<PostModel> posts = await profileRepo.getUserPosts(
        uid: userModel.uid,
      );
      emit(ProfileCurrentUserLoaded(userModel: userModel, posts: posts));
    } catch (e) {
      emit(ProfileFailure(message: e.toString()));
    }
  }

  Future<void> loadUserProfile({required String uid}) async {
    emit(ProfileLoading());
    try {
      UserModel userModel = await profileRepo.getUser(uid: uid);
      List<PostModel> posts = await profileRepo.getUserPosts(uid: uid);
      emit(ProfileOtherUserLoaded(userModel: userModel, posts: posts));
    } catch (e) {
      emit(ProfileFailure(message: e.toString()));
    }
  }

  /// Fetches user data without emitting states - for display purposes only
  Future<Map<String, dynamic>> getUserData({required String uid}) async {
    UserModel userModel = await profileRepo.getUser(uid: uid);
    List<PostModel> posts = await profileRepo.getUserPosts(uid: uid);
    return {'userModel': userModel, 'posts': posts};
  }

  Future<void> followUser({
    required UserModel followingUser,
    required UserModel followerUser,
    required bool isViewingCurrentUser,
  }) async {
    emit(ProfileLoading());
    try {
      await profileRepo.followUser(
        followingUser: followingUser,
        followerUser: followerUser,
      );
      emit(ProfileFollowSuccess());

      if (isViewingCurrentUser) {
        UserModel userModel = await profileRepo.getCurrentUser();
        List<PostModel> posts = await profileRepo.getUserPosts(
          uid: userModel.uid,
        );
        emit(ProfileCurrentUserLoaded(userModel: userModel, posts: posts));
      } else {
        UserModel userModel = await profileRepo.getUser(uid: followerUser.uid);
        List<PostModel> posts = await profileRepo.getUserPosts(
          uid: followerUser.uid,
        );
        emit(
          ProfileOtherUserLoaded(
            userModel: userModel,
            posts: posts,
            shouldNavigate: false,
          ),
        );
      }
    } catch (e) {
      emit(ProfileFailure(message: e.toString()));
    }
  }
}
