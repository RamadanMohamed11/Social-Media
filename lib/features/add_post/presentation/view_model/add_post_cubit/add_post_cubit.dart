import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:social_media/features/add_post/data/repos/add_post_repo.dart';
import 'package:social_media/core/models/post_model.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  final AddPostRepo addPostRepo;
  AddPostCubit({required this.addPostRepo}) : super(AddPostInitial());

  void emitInitial() {
    emit(AddPostInitial());
  }

  Future<void> addPost(PostModel post, Uint8List? postImage) async {
    emit(AddPostLoading());
    var result = await addPostRepo.addPost(post, postImage);
    result.fold((failure) => emit(AddPostError(failure.errorMessage)), (data) {
      emit(AddPostSuccess());
    });
  }
}
