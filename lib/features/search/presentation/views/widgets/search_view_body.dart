import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/core/utils/app_colors.dart';
import 'package:social_media/core/utils/app_router.dart';
import 'package:social_media/core/utils/assets_data.dart';
import 'package:social_media/features/profile/presentation/view_model/cubit/profile_cubit.dart';
import 'package:social_media/features/search/presentation/view_model/search_cubit/search_cubit.dart';
import 'package:social_media/features/search/presentation/views/widgets/search_text_field.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key, required this.userModel});
  final UserModel userModel;

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  late TextEditingController _searchController;
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileOtherUserLoaded) {
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
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            SearchTextField(
              controller: _searchController,
              onChange: (value) {
                setState(() {});
              },
            ),
            Gap(10),
            Expanded(
              child: StreamBuilder<List<UserModel>>(
                stream: BlocProvider.of<SearchCubit>(context).searchUsers(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<UserModel> users = snapshot.data!
                        .where(
                          (user) =>
                              user.username.toLowerCase().contains(
                                _searchController.text.toLowerCase(),
                              ) &&
                              user.uid != widget.userModel.uid &&
                              _searchController.text.isNotEmpty,
                        )
                        .toList();
                    if (users.isNotEmpty) {
                      return ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              BlocProvider.of<ProfileCubit>(
                                context,
                              ).loadUserProfile(uid: users[index].uid);
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundImage: Image.asset(
                                  AssetsData.man,
                                ).image,
                              ),
                              title: Text(
                                users[index].name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text("@${users[index].username}"),
                            ),
                          );
                        },
                      );
                    } else if (_searchController.text.isEmpty) {
                      return Center(
                        child: Text(
                          'Search For Users',
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    }
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return const Center(
                    child: Text(
                      'No users found',
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.kPrimaryColor,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
