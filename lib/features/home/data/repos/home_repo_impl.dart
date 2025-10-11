import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/core/errors/failures.dart';
import 'package:social_media/core/models/post_model.dart';
import 'package:social_media/core/utils/cloud_service.dart';
import 'package:social_media/core/utils/storage_service.dart';
import 'package:social_media/features/home/data/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final CloudService cloudService;
  final StorageService storageService;

  HomeRepoImpl({required this.cloudService, required this.storageService});

  @override
  Stream<List<PostModel>> getPosts() {
    try {
      final Stream<List<DocumentSnapshot>> res = cloudService.getData();
      return res.map(
        (docs) => docs.map((doc) => PostModel.fromSnap(doc)).toList(),
      );
    } on FirebaseException catch (e) {
      throw CloudFailure.fromException(e);
    } catch (e) {
      throw CloudFailure(e.toString());
    }
  }
}
