import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/core/utils/app_router.dart';
import 'package:social_media/core/utils/authentication_service.dart';
import 'package:social_media/core/utils/service_locator.dart';
import 'package:social_media/features/add_post/data/repos/add_post_repo.dart';
import 'package:social_media/features/comment/data/repos/comment_repo.dart';
import 'package:social_media/features/comment/presentation/view_models/comment_cubit/comment_cubit.dart';
import 'package:social_media/features/profile/data/repos/profile_repo.dart';
import 'package:social_media/features/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:social_media/features/add_post/presentation/view_model/add_post_cubit/add_post_cubit.dart';
import 'package:social_media/features/authentication/data/repos/auth_repo.dart';
import 'package:social_media/features/authentication/presentation/view_models/cubit/authentication_cubit.dart';
import 'package:social_media/features/home/data/repos/home_repo.dart';
import 'package:social_media/features/home/presentation/view_model/home_view_cubit/home_view_cubit.dart';
import 'package:social_media/features/search/data/repos/search_repo.dart';
import 'package:social_media/features/search/presentation/view_model/search_cubit/search_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://bwqiemqchnuwherhpwqd.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ3cWllbXFjaG51d2hlcmhwd3FkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjAwMzE2MjEsImV4cCI6MjA3NTYwNzYyMX0.uVA4auOVjBn1DJJkduicPPI7VnVI9Tq7dIYmlMYGiKY',
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupServiceLocator();

  final AuthenticationService authService = getIt.get<AuthenticationService>();
  final firebase_auth.User? currentUser =
      firebase_auth.FirebaseAuth.instance.currentUser;
  UserModel? cachedUserModel;
  String initialRoute = AppRouter.kLogin;

  if (currentUser != null) {
    try {
      cachedUserModel = await authService.getCurrentUser();
      initialRoute = AppRouter.kLayoutView;
    } catch (_) {
      // If fetching the profile fails fall back to login.
      initialRoute = AppRouter.kLogin;
    }
  }

  runApp(SocialMedia(initialRoute: initialRoute, initialUser: cachedUserModel));
}

class SocialMedia extends StatelessWidget {
  SocialMedia({super.key, required String initialRoute, UserModel? initialUser})
    : _router = AppRouter.createRouter(
        initialRoute: initialRoute,
        initialUser: initialUser,
      );

  final GoRouter _router;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationCubit(
            authRepo: getIt.get<AuthRepo>(),
            authenticationService: getIt.get<AuthenticationService>(),
          ),
        ),
        BlocProvider(
          create: (context) =>
              AddPostCubit(addPostRepo: getIt.get<AddPostRepo>()),
        ),
        BlocProvider(
          create: (context) => HomeViewCubit(homeRepo: getIt.get<HomeRepo>()),
        ),
        BlocProvider(
          create: (context) => SearchCubit(searchRepo: getIt.get<SearchRepo>()),
        ),
        BlocProvider(
          create: (context) =>
              ProfileCubit(profileRepo: getIt.get<ProfileRepo>()),
        ),
        BlocProvider(
          create: (context) =>
              CommentCubit(commentRepo: getIt.get<CommentRepo>()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
    );
  }
}
