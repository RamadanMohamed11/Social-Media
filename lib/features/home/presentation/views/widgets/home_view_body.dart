import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:redacted/redacted.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/core/models/post_model.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/core/utils/app_router.dart';
import 'package:social_media/core/utils/cloud_service.dart';
import 'package:social_media/core/utils/service_locator.dart';
import 'package:social_media/features/home/presentation/view_model/home_view_cubit/home_view_cubit.dart';
import 'package:social_media/features/home/presentation/views/widgets/post_widget.dart';
import 'package:social_media/features/profile/presentation/view_model/cubit/profile_cubit.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  late final ScrollController _scrollController;
  late final Stream<List<PostModel>> _postsStream;
  final Map<String, Future<UserModel>> _userFutureCache = {};

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _postsStream = context.read<HomeViewCubit>().getPosts();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<UserModel> _fetchPostUser(String uid) async {
    final DocumentSnapshot doc = await getIt
        .get<CloudService>(instanceName: 'users')
        .getDataById(docId: uid);
    return UserModel.fromSnap(doc);
  }

  Future<UserModel> _getPostUserFuture(String uid) {
    return _userFutureCache.putIfAbsent(uid, () => _fetchPostUser(uid));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileOtherUserLoaded && state.shouldNavigate) {
          GoRouter.of(context).push(
            AppRouter.kProfile,
            extra: {'userModel': state.userModel, 'posts': state.posts},
          );
        } else if (state is ProfileFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Error: ${state.message}")));
        }
      },
      child: StreamBuilder<List<PostModel>>(
        stream: _postsStream,
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: ListView.builder(
                key: const PageStorageKey('home_skeleton_list'),
                controller: _scrollController,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const PostWidget().redacted(
                    context: context,
                    redact: true,
                    configuration: RedactedConfiguration(
                      animationDuration: const Duration(milliseconds: 500),
                    ),
                  );
                },
              ),
            );
          }
          if (asyncSnapshot.hasError) {
            return Center(child: Text(asyncSnapshot.error.toString()));
          } else if (asyncSnapshot.hasData) {
            final List<PostModel> posts = asyncSnapshot.data!;
            if (posts.isEmpty) {
              return const Center(
                child: Text(
                  "No Posts",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: ListView.builder(
                  key: const PageStorageKey('home_posts_list'),
                  controller: _scrollController,
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return FutureBuilder(
                      future: _getPostUserFuture(post.uid),
                      builder: (context, asyncSnapshot) {
                        if (asyncSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const PostWidget().redacted(
                            context: context,
                            redact: true,
                            configuration: RedactedConfiguration(
                              animationDuration: const Duration(
                                milliseconds: 500,
                              ),
                            ),
                          );
                        } else if (asyncSnapshot.hasData) {
                          final UserModel postUserModel = asyncSnapshot.data!;
                          return PostWidget(
                            userModel: widget.userModel,
                            postUserModel: postUserModel,
                            post: post,
                            onOwnerTap: () {
                              BlocProvider.of<ProfileCubit>(
                                context,
                              ).loadUserProfile(uid: post.uid);
                            },
                            onLoveTap: () async {
                              final profileCubit =
                                  BlocProvider.of<ProfileCubit>(context);
                              final currentUser = await profileCubit.profileRepo
                                  .getCurrentUser();

                              setState(() {
                                if (post.likes.contains(currentUser.uid)) {
                                  post.likes.remove(currentUser.uid);
                                } else {
                                  post.likes.add(currentUser.uid);
                                }
                              });
                              await BlocProvider.of<HomeViewCubit>(
                                context,
                              ).lovePost(newPost: post);
                            },
                          );
                        } else {
                          return Center(
                            child: Text(asyncSnapshot.error.toString()),
                          );
                        }
                      },
                    );
                  },
                ),
              );
            }
          } else {
            return const Center(child: Text("No Posts"));
          }
        },
      ),
    );
  }
}
