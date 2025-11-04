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
import 'package:social_media/features/edit_profile/data/repos/edit_profile_repo.dart';
import 'package:social_media/features/edit_profile/presentation/view_model/cubit/edit_profile_cubit.dart';
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
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options.dart';

// Allow overriding the Supabase URL and anon key at build/run time using
// --dart-define. Defaults are the current values in repository so this
// change is non-breaking (you asked to keep values unchanged in the repo).
const String kSupabaseUrl = String.fromEnvironment(
  'SUPABASE_URL',
  defaultValue: 'https://bwqiemqchnuwherhpwqd.supabase.co',
);

const String kSupabaseAnonKey = String.fromEnvironment(
  'SUPABASE_ANON_KEY',
  defaultValue: '',
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load local environment (.env) if it exists. Developers should create a
  // local `.env` file (gitignored) with SUPABASE_ANON_KEY and optionally
  // SUPABASE_URL while developing. If not present, we fall back to
  // compile-time --dart-define values (kSupabaseAnonKey) or the hard-coded URL.
  try {
    await dotenv.load(fileName: '.env');
  } catch (_) {
    // ignore - .env is optional
  }

  // Access dotenv safely: if dotenv wasn't initialized or the package is not
  // available, fall back to compile-time values.
  String? envSupabaseUrl;
  String? envSupabaseAnonKey;
  try {
    envSupabaseUrl = dotenv.env['SUPABASE_URL'];
    envSupabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];
  } catch (_) {
    // dotenv not initialized or missing — ignore and use defaults
    envSupabaseUrl = null;
    envSupabaseAnonKey = null;
  }

  final supabaseUrl = (envSupabaseUrl != null && envSupabaseUrl.isNotEmpty)
      ? envSupabaseUrl
      : kSupabaseUrl;

  final supabaseAnonKey =
      (envSupabaseAnonKey != null && envSupabaseAnonKey.isNotEmpty)
      ? envSupabaseAnonKey
      : kSupabaseAnonKey;

  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
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
        BlocProvider(
          create: (context) =>
              EditProfileCubit(editProfileRepo: getIt.get<EditProfileRepo>()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _router,
      ),
    );
  }
}
