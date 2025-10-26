import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:social_media/core/utils/authentication_service.dart';
import 'package:social_media/core/utils/cloud_service.dart';
import 'package:social_media/core/utils/storage_service.dart';
import 'package:social_media/features/add_post/data/repos/add_post_repo.dart';
import 'package:social_media/features/add_post/data/repos/add_post_repo_impl.dart';
import 'package:social_media/features/authentication/data/repos/auth_repo.dart';
import 'package:social_media/features/authentication/data/repos/auth_repo_impl.dart';
import 'package:social_media/features/comment/data/repos/comment_repo.dart';
import 'package:social_media/features/comment/data/repos/comment_repo_impl.dart';
import 'package:social_media/features/home/data/repos/home_repo.dart';
import 'package:social_media/features/home/data/repos/home_repo_impl.dart';
import 'package:social_media/features/profile/data/repos/profile_repo.dart';
import 'package:social_media/features/profile/data/repos/profile_repo_impl.dart';
import 'package:social_media/features/search/data/repos/search_repo.dart';
import 'package:social_media/features/search/data/repos/search_repo_impl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<CloudService>(
    CloudService(
      collectionReference: FirebaseFirestore.instance.collection('users'),
    ),
    instanceName: 'users',
  );

  // Authentication Service
  getIt.registerSingleton<AuthenticationService>(
    AuthenticationService(
      cloudService: getIt.get<CloudService>(instanceName: 'users'),
    ),
  );
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(authenticationService: getIt.get<AuthenticationService>()),
  );

  getIt.registerSingleton<ProfileRepo>(
    ProfileRepoImpl(
      cloudService: getIt.get<CloudService>(instanceName: 'users'),
      authService: getIt.get<AuthenticationService>(),
    ),
  );

  // Cloud Service for Posts
  getIt.registerSingleton<StorageService>(
    StorageService(supabase: Supabase.instance.client),
  );
  getIt.registerSingleton<CloudService>(
    CloudService(
      collectionReference: FirebaseFirestore.instance.collection('posts'),
    ),
    instanceName: 'posts',
  );
  getIt.registerSingleton<AddPostRepo>(
    AddPostRepoImpl(
      cloudService: getIt.get<CloudService>(instanceName: 'posts'),
      storageService: getIt.get<StorageService>(),
    ),
  );
  getIt.registerSingleton<HomeRepo>(
    HomeRepoImpl(
      cloudService: getIt.get<CloudService>(instanceName: 'posts'),
      storageService: getIt.get<StorageService>(),
    ),
  );

  getIt.registerSingleton<CommentRepo>(
    CommentRepoImpl(
      cloudService: getIt.get<CloudService>(instanceName: 'posts'),
    ),
  );

  // Cloud Service for Users

  getIt.registerSingleton<SearchRepo>(
    SearchRepoImpl(
      cloudService: getIt.get<CloudService>(instanceName: 'users'),
    ),
  );
}
