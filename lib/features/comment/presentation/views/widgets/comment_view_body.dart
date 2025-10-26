import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/core/models/post_model.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/core/utils/app_colors.dart';
import 'package:social_media/core/utils/authentication_service.dart';
import 'package:social_media/core/utils/service_locator.dart';
import 'package:social_media/features/comment/data/models/comment_model.dart';
import 'package:social_media/features/comment/presentation/view_models/comment_cubit/comment_cubit.dart';
import 'package:social_media/features/comment/presentation/views/widgets/comment_list_tile.dart';
import 'package:social_media/features/comment/presentation/views/widgets/comment_text_form_field.dart';
// import 'package:social_media/features/profile/presentation/view_model/cubit/profile_cubit.dart';

class CommentViewBody extends StatefulWidget {
  const CommentViewBody({super.key, required this.postModel});
  final PostModel postModel;

  @override
  State<CommentViewBody> createState() => _CommentViewBodyState();
}

class _CommentViewBodyState extends State<CommentViewBody> {
  late TextEditingController _commentController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommentCubit, CommentState>(
      listener: (context, state) {
        if (state is CommentAddFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Error: ${state.message}")));
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.postModel.comments.length,
                    // itemCount: 10,
                    itemBuilder: (context, index) {
                      return CommentListTile(
                        commentModel: widget.postModel.comments[index],
                      );
                    },
                  ),
                ),
                Gap(10),
                Row(
                  children: [
                    Expanded(
                      child: CommentTextFormField(
                        controller: _commentController,
                        onSaved: commentOnSavedMethod,
                      ),
                    ),
                    Gap(5),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.kPrimaryColor,
                        foregroundColor: AppColors.kWhiteColor,
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(12),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          UserModel currentUser = await getIt
                              .get<AuthenticationService>()
                              .getCurrentUser();
                          CommentModel commentModel = CommentModel(
                            uid: currentUser.uid,
                            comment: _commentController.text,
                            createdAt: DateTime.now(),
                          );
                          _commentController.clear();
                          PostModel updatedPost = widget.postModel;
                          updatedPost.comments.add(commentModel);
                          BlocProvider.of<CommentCubit>(
                            context,
                          ).addComment(postModel: widget.postModel);
                          // Handle comment submission logic here
                        }
                      },
                      child: const Icon(Icons.send, size: 27),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void commentOnSavedMethod(String? value) {
    _commentController.text = value ?? '';
  }
}
