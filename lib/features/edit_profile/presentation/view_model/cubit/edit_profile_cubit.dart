import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/features/edit_profile/data/repos/edit_profile_repo.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileRepo editProfileRepo;
  EditProfileCubit({required this.editProfileRepo})
    : super(EditProfileInitial());

  Future<void> editProfile(UserModel userModel, Uint8List? userImage) async {
    emit(EditProfileLoading());
    var result = await editProfileRepo.editProfile(
      userModel: userModel,
      userImage: userImage,
    );
    result.fold(
      (failure) => emit(EditProfileFailure(message: failure.errorMessage)),
      (updatedUser) => emit(EditProfileSuccess(updatedUser: updatedUser)),
    );
  }
}
