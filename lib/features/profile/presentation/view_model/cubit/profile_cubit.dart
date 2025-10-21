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
    print("ProfileCubit: Starting loadUserProfile with uid: $uid");
    emit(ProfileLoading());
    try {
      print("ProfileCubit: Fetching user data");
      UserModel userModel = await profileRepo.getUser(uid: uid);
      print("ProfileCubit: User data fetched successfully");

      print("ProfileCubit: Fetching user posts");
      List<PostModel> posts = await profileRepo.getUserPosts(uid: uid);
      print("ProfileCubit: Posts fetched successfully");

      print("ProfileCubit: Emitting ProfileOtherUserLoaded");
      emit(ProfileOtherUserLoaded(userModel: userModel, posts: posts));
    } catch (e) {
      print("ProfileCubit: Error occurred: $e");
      emit(ProfileFailure(message: e.toString()));
    }
  }
}
