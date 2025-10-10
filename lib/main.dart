import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/utils/app_router.dart';
import 'package:social_media/core/utils/authentication_service.dart';
import 'package:social_media/core/utils/service_locator.dart';
import 'package:social_media/features/add_post/data/repos/add_post_repo.dart';
import 'package:social_media/features/add_post/presentation/view_model/add_post_cubit/add_post_cubit.dart';
import 'package:social_media/features/authentication/data/repos/auth_repo.dart';
import 'package:social_media/features/authentication/presentation/view_models/cubit/authentication_cubit.dart';
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
  runApp(const SocialMedia());
}

class SocialMedia extends StatelessWidget {
  const SocialMedia({super.key});

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
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.routes,
      ),
    );
  }
}
