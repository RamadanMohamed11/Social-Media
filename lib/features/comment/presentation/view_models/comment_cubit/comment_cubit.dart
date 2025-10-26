import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_media/features/comment/data/repos/comment_repo.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  final CommentRepo commentRepo;
  CommentCubit({required this.commentRepo}) : super(CommentInitial());
  Future<void> addComment({required postModel}) async {
    emit(CommentLoading());
    try {
      await commentRepo.addComment(newPost: postModel);
      emit(CommentAddedSuccess());
    } catch (e) {
      emit(CommentAddFailure(message: e.toString()));
    }
  }
}
