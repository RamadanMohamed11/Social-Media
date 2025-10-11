import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/features/search/data/repos/search_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo searchRepo;
  SearchCubit({required this.searchRepo}) : super(SearchInitial());

  Stream<List<UserModel>> searchUsers() {
    try {
      emit(SearchLoading());
      return searchRepo.searchUsers().map((users) {
        emit(SearchSuccess());
        return users;
      });
    } catch (e) {
      emit(SearchFailure(message: e.toString()));
      return Stream<List<UserModel>>.empty();
    }
  }
}
