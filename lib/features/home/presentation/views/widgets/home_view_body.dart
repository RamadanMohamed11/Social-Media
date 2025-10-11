import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:redacted/redacted.dart';
import 'package:social_media/constants.dart';
import 'package:social_media/core/models/post_model.dart';
import 'package:social_media/core/models/user_model.dart';
import 'package:social_media/core/utils/app_colors.dart';
import 'package:social_media/core/utils/assets_data.dart';
import 'package:social_media/features/home/presentation/view_model/home_view_cubit/home_view_cubit.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PostModel>>(
      stream: BlocProvider.of<HomeViewCubit>(context).getPosts(),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return PostWidget().redacted(
                  context: context,
                  redact: true,
                  configuration: RedactedConfiguration(
                    animationDuration: Duration(milliseconds: 500),
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
          return Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return PostWidget(userModel: userModel, post: post);
              },
            ),
          );
        } else {
          return const Center(child: Text("No Posts"));
        }
      },
    );
  }
}

class PostWidget extends StatelessWidget {
  const PostWidget({super.key, this.userModel, this.post});

  final UserModel? userModel;
  final PostModel? post;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: kDefaultPadding),
      decoration: BoxDecoration(
        color: AppColors.kWhiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.kWhiteColor,
                backgroundImage: post != null
                    ? AssetImage(AssetsData.man)
                    : null,
              ),
              Gap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userModel?.username ?? "                    "),
                  Text("@${post?.username ?? "     "}"),
                ],
              ),
              const Spacer(),
              Text(
                "${post?.createdAt.day}/${post?.createdAt.month}/${post?.createdAt.year}",
              ),
            ],
          ),
          Gap(10),
          InkWell(
            onTap: () {
              if (post != null) {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    backgroundColor: Colors.black,
                    child: Stack(
                      children: [
                        InteractiveViewer(
                          minScale: 0.5,
                          maxScale: 4.0,
                          child: Center(
                            child: Image.network(
                              post?.postImageURL ?? " ",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: AppColors.kWhiteColor,
                              size: 30,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
            child: Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  post?.postImageURL ?? " ",
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child:
                          Container(
                            color: Colors.grey,
                            width: 80,
                            height: 110,
                          ).redacted(
                            context: context,
                            redact: true,
                            configuration: RedactedConfiguration(
                              animationDuration: Duration(milliseconds: 450),
                            ),
                          ),
                    );
                  },
                ),
              ),
            ),
          ),
          Gap(10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              post?.caption ?? "                         ",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text(post != null ? "See More" : "           "),
            ),
          ),
          Gap(10),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite_border_outlined),
              ),
              Text(post?.likes.length.toString() ?? "     "),
              Gap(20),
              IconButton(onPressed: () {}, icon: Icon(Icons.comment)),
              Text(post?.comments.length.toString() ?? "     "),
            ],
          ),
        ],
      ),
    );
  }
}
