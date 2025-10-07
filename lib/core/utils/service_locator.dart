import 'package:get_it/get_it.dart';
import 'package:social_media/core/utils/authentication_service.dart';
import 'package:social_media/features/authentication/data/repos/auth_repo.dart';
import 'package:social_media/features/authentication/data/repos/auth_repo_impl.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<AuthenticationService>(AuthenticationService());
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(authenticationService: getIt.get<AuthenticationService>()),
  );
}
