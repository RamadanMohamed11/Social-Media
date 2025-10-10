import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String pid;
  final String uid;
  final String username;
  final String profileImage;
  // final String postImage;
  final String caption;
  final List<dynamic> likes;
  final List<dynamic> comments;
  final DateTime createdAt;

  PostModel({
    required this.pid,
    required this.uid,
    required this.username,
    required this.profileImage,
    // required this.postImage,
    required this.caption,
    required this.likes,
    required this.comments,
    required this.createdAt,
  });

  factory PostModel.fromSnap(DocumentSnapshot snap) {
    return PostModel(
      pid: snap['pid'],
      uid: snap['uid'],
      username: snap['username'],
      profileImage: snap['profileImage'],
      // postImage: snap['postImage'],
      caption: snap['caption'],
      likes: snap['likes'],
      comments: snap['comments'],
      createdAt: snap['createdAt'],
    );
  }

  Map<String, dynamic> toJson() => {
    'pid': pid,
    'uid': uid,
    'username': username,
    'profileImage': profileImage,
    // 'postImage': postImage,
    'caption': caption,
    'likes': likes,
    'comments': comments,
    'createdAt': createdAt,
  };
}
