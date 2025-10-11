import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/core/errors/failures.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/core/utils/cloud_service.dart';
import 'package:social_media/features/search/data/repos/search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  @override
  final CloudService cloudService;

  SearchRepoImpl({required this.cloudService});

  @override
  Stream<List<UserModel>> searchUsers() {
    try {
      final Stream<List<DocumentSnapshot>> res = cloudService.getData();
      return res.map(
        (docs) => docs.map((doc) => UserModel.fromSnap(doc)).toList(),
      );
    } on FirebaseException catch (e) {
      throw CloudFailure.fromException(e);
    } catch (e) {
      throw CloudFailure(e.toString());
    }
  }
}
