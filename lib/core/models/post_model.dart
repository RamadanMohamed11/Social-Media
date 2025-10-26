import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/features/comment/data/models/comment_model.dart';

class PostModel {
  final String pid;
  final String uid;
  final String name;
  final String username;
  final String profileImage;
  String postImageURL;
  final String caption;
  final List<dynamic> likes;
  final List<CommentModel> comments;
  final DateTime createdAt;

  PostModel({
    required this.pid,
    required this.uid,
    required this.name,
    required this.username,
    required this.profileImage,
    required this.postImageURL,
    required this.caption,
    required this.likes,
    required this.comments,
    required this.createdAt,
  });

  factory PostModel.fromSnap(DocumentSnapshot snap) {
    return PostModel(
      pid: snap['pid'],
      uid: snap['uid'],
      name: snap['name'],
      username: snap['username'],
      profileImage: snap['profileImage'],
      postImageURL: snap['postImageURL'],
      caption: snap['caption'],
      likes: snap['likes'],
      comments: (snap['comments'] as List<dynamic>)
          .map(
            (commentMap) =>
                CommentModel.fromMap(commentMap as Map<String, dynamic>),
          )
          .toList(),
      createdAt: (snap['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() => {
    'pid': pid,
    'uid': uid,
    'name': name,
    'username': username,
    'profileImage': profileImage,
    'postImageURL': postImageURL,
    'caption': caption,
    'likes': likes,
    'comments': comments.map((comment) => comment.toJson()).toList(),
    'createdAt': createdAt,
  };
}
