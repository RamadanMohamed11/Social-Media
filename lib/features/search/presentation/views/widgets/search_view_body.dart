import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/core/utils/app_colors.dart';
import 'package:social_media/core/utils/assets_data.dart';
import 'package:social_media/core/utils/authentication_service.dart';
import 'package:social_media/core/utils/service_locator.dart';
import 'package:social_media/features/search/presentation/view_model/search_cubit/search_cubit.dart';

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
    return Padding(
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
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 20,
                            backgroundImage: Image.asset(AssetsData.man).image,
                          ),
                          title: Text(users[index].username),
                          subtitle: Text(users[index].email),
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
    );
  }
}

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    super.key,
    required this.controller,
    required this.onChange,
  });
  final TextEditingController controller;
  final Function(String) onChange;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  bool isTextFieldPressed = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: () {
        setState(() {
          isTextFieldPressed = true;
        });
      },

      onSubmitted: (value) {
        setState(() {
          isTextFieldPressed = false;
        });
      },
      onChanged: widget.onChange,
      controller: widget.controller,
      decoration: InputDecoration(
        suffixIcon: Icon(
          Icons.search,
          color: isTextFieldPressed ? AppColors.kPrimaryColor : Colors.grey,
        ),
        hintText: 'Search by username',
        fillColor: AppColors.kWhiteColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.kPrimaryColor),
        ),
      ),
    );
  }
}
