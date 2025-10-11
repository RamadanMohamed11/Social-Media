import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/core/utils/cloud_service.dart';

abstract class SearchRepo {
  final CloudService cloudService;

  SearchRepo({required this.cloudService});

  Stream<List<UserModel>> searchUsers();
}
