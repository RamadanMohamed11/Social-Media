import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_media/core/models/post_model.dart';
import 'package:social_media/features/home/data/repos/home_repo.dart';

part 'home_view_state.dart';

class HomeViewCubit extends Cubit<HomeViewState> {
  final HomeRepo homeRepo;
  HomeViewCubit({required this.homeRepo}) : super(HomeViewInitial());

  Stream<List<PostModel>> getPosts() {
    emit(HomeViewLoading());
    try {
      var result = homeRepo.getPosts();

      emit(HomeViewSuccess());
      return result;
    } catch (e) {
      emit(HomeViewError(e.toString()));
      return Stream<List<PostModel>>.empty();
    }
  }

  Future<void> lovePost({required PostModel newPost}) async {
    emit(HomeViewLoading());
    try {
      await homeRepo.lovePost(newPost: newPost);
      emit(HomeViewSuccess());
    } catch (e) {
      emit(HomeViewError(e.toString()));
    }
  }
}
