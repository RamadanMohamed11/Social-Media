import 'package:go_router/go_router.dart';
import 'package:social_media/core/models/post_model.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/features/authentication/presentation/views/login_view.dart';
import 'package:social_media/features/authentication/presentation/views/register_view.dart';
import 'package:social_media/features/comment/presentation/views/comment_view.dart';
import 'package:social_media/features/edit_profile/presentation/views/edit_profile_view.dart';
import 'package:social_media/features/home/presentation/views/home_view.dart';
import 'package:social_media/features/home/presentation/views/layout_view.dart';
import 'package:social_media/features/profile/presentation/views/profile_view.dart';

abstract class AppRouter {
  static const String kLogin = '/login';
  static const String kRegister = '/register';
  static const String kHome = '/home';
  static const String kLayoutView = '/layout';
  static const String kProfile = '/profile';
  static const String kEditProfile = '/edit_profile';
  static const String kCommentView = '/comment_view';

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
      GoRoute(
        path: kHome,
        builder: (context, state) {
          return HomeView(userModel: state.extra as UserModel);
        },
      ),
      GoRoute(
        path: kLayoutView,
        builder: (context, state) {
          return LayoutView(userModel: state.extra as UserModel);
        },
      ),
      GoRoute(
        path: kProfile,
        builder: (context, state) {
          final Map<String, dynamic> extras =
              state.extra as Map<String, dynamic>;
          return ProfileView(
            userModel: extras['userModel'] as UserModel,
            post: extras['posts'] as List<PostModel>,
          );
        },
      ),
      GoRoute(
        path: kEditProfile,
        builder: (context, state) {
          return EditProfileView(userModel: state.extra as UserModel);
        },
      ),
      GoRoute(
        path: kCommentView,
        builder: (context, state) {
          return CommentView(post: state.extra as PostModel);
        },
      ),
    ],
  );
}
