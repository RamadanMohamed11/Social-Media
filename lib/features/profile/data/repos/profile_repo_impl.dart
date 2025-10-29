import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/core/errors/failures.dart';
import 'package:social_media/core/models/post_model.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/core/utils/authentication_service.dart';
import 'package:social_media/core/utils/cloud_service.dart';
import 'package:social_media/features/profile/data/repos/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final CloudService cloudService;
  final AuthenticationService authService;

  ProfileRepoImpl({required this.cloudService, required this.authService});

  @override
  Future<List<PostModel>> getUserPosts({required String uid}) async {
    try {
      print("Getting posts for uid: $uid");
      final Stream<List<DocumentSnapshot>> res = cloudService.getData(
        orderBy: 'timestamp',
        isDescending: true,
      );
      final posts = await res.map((docs) {
        print("Received ${docs.length} documents from Firestore");
        final filtered = docs
            .map((doc) => PostModel.fromSnap(doc))
            .where((post) => post.uid == uid)
            .toList();
        print("Found ${filtered.length} posts for user $uid");
        return filtered;
      }).first;
      return posts;
    } on FirebaseException catch (e) {
      throw CloudFailure.fromException(e);
    } catch (e) {
      throw CloudFailure(e.toString());
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      String uid = (await authService.getCurrentUser())!.uid;
      DocumentSnapshot userDoc = await cloudService.getDocumentById(docId: uid);
      if (!userDoc.exists) {
        throw Exception('User not found');
      }
      return UserModel.fromSnap(userDoc);
    } on FirebaseException catch (e) {
      throw CloudFailure.fromException(e);
    } catch (e) {
      throw CloudFailure(e.toString());
    }
  }

  @override
  Future<UserModel> getUser({required String uid}) async {
    try {
      DocumentSnapshot userDoc = await cloudService.getDocumentById(docId: uid);
      if (!userDoc.exists) {
        throw Exception('User not found');
      }
      return UserModel.fromSnap(userDoc);
    } on FirebaseException catch (e) {
      throw CloudFailure.fromException(e);
    } catch (e) {
      throw CloudFailure(e.toString());
    }
  }
}
