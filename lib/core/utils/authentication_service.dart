import 'package:social_media/features/authentication/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference _usersCollection = FirebaseFirestore.instance
      .collection('users');

  void storeUser(
    UserCredential userCredential,
    String name,
    String email,
    String username,
  ) {
    UserModel user = UserModel(
      id: userCredential.user!.uid,
      email: email,
      name: name,
      image: "",
      bio: "",
      username: username,
      followers: [],
      following: [],
    );
    _usersCollection.doc(user.id).set(user.toJson());
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String username,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      storeUser(userCredential, name, email, username);
    } catch (e) {
      print("Error signing up: $e");
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print("Error signing in: $e");
    }
  }
}
