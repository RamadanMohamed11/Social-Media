import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String uid;
  final DateTime createdAt;
  final String comment;

  CommentModel({
    required this.uid,
    required this.createdAt,
    required this.comment,
  });

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      uid: map['uid'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      comment: map['comment'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'createdAt': createdAt,
    'comment': comment,
  };
}
