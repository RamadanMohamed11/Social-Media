import 'package:go_router/go_router.dart';
import 'package:social_media/features/authentication/presentation/views/login_view.dart';
import 'package:social_media/features/authentication/presentation/views/register_view.dart';

abstract class AppRouter {
  static const String kLogin = '/login';
  static const String kRegister = '/register';
  static final GoRouter routes = GoRouter(
    initialLocation: kLogin,
    routes: [
      GoRoute(
        path: kLogin,
        builder: (context, state) {
          return const LoginView();
        },
      ),
      GoRoute(
        path: kRegister,
        builder: (context, state) {
          return const RegisterView();
        },
      ),
    ],
  );
}
