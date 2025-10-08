import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String username;
  final String profileImage;
  final String bio;
  final List<dynamic> followers;
  final List<dynamic> following;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.username,
    required this.profileImage,
    required this.bio,
    required this.followers,
    required this.following,
  });

  factory UserModel.fromSnap(DocumentSnapshot snap) {
    return UserModel(
      uid: snap.id,
      name: snap['name'],
      email: snap['email'],
      username: snap['username'],
      profileImage: snap['profileImage'],
      bio: snap['bio'],
      followers: snap['followers'],
      following: snap['following'],
    );
  }

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'email': email,
    'username': username,
    'profileImage': profileImage,
    'bio': bio,
    'followers': followers,
    'following': following,
  };
}
