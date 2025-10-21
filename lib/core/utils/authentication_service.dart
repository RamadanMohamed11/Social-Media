import 'dart:developer';

import 'package:social_media/core/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media/core/utils/cloud_service.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference _usersCollection = FirebaseFirestore.instance
      .collection('users');

  final CloudService cloudService;

  AuthenticationService({required this.cloudService});

  Future<UserModel> getCurrentUser() async {
    User? currentUser = _firebaseAuth.currentUser;
    // DocumentSnapshot userDoc = await _usersCollection
    //     .doc(currentUser!.uid)
    //     .get();
    DocumentSnapshot userDoc = await cloudService.getDocumentById(
      docId: currentUser!.uid,
    );
    if (!userDoc.exists) {
      throw Exception('User not found');
    }
    return UserModel.fromSnap(userDoc);
  }

  Future<void> storeUser(
    UserCredential userCredential,
    String name,
    String email,
    String username,
  ) async {
    UserModel user = UserModel(
      uid: userCredential.user!.uid,
      email: email,
      name: name,
      profileImage: "",
      bio: "",
      username: username,
      followers: [],
      following: [],
    );
    log('Storing user: ${user.toJson()}');

    await cloudService.storeData(obj: user.toJson(), docId: user.uid);
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String username,
  }) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    await storeUser(userCredential, name, email, username);
  }

  Future<UserModel?> signIn({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    DocumentSnapshot userDoc = await _usersCollection
        .doc(_firebaseAuth.currentUser!.uid)
        .get();
    if (userDoc.exists) {
      return UserModel.fromSnap(userDoc);
    }
    return null;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
