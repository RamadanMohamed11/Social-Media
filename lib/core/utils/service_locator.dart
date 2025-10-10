import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:social_media/core/utils/authentication_service.dart';
import 'package:social_media/core/utils/cloud_service.dart';
import 'package:social_media/core/utils/storage_service.dart';
import 'package:social_media/features/add_post/data/repos/add_post_repo.dart';
import 'package:social_media/features/add_post/data/repos/add_post_repo_impl.dart';
import 'package:social_media/features/authentication/data/repos/auth_repo.dart';
import 'package:social_media/features/authentication/data/repos/auth_repo_impl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Authentication Service
  getIt.registerSingleton<AuthenticationService>(AuthenticationService());
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(authenticationService: getIt.get<AuthenticationService>()),
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

  // Cloud Service for Users
  getIt.registerSingleton<CloudService>(
    CloudService(
      collectionReference: FirebaseFirestore.instance.collection('users'),
    ),
    instanceName: 'users',
  );
  // getIt.registerSingleton<UserRepo>(
  //   UserRepoImpl(cloudService: getIt.get<CloudService>(instanceName: 'users')),
  // );
}
