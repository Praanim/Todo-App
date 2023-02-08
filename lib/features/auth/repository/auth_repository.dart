import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hamro_app/constants/firebase_constants.dart';
import 'package:hamro_app/core/failure.dart';
import 'package:hamro_app/core/providers/firebase_providers.dart';
import 'package:hamro_app/core/type_defs.dart';
import 'package:hamro_app/model/user_model.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    firebaseFirestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider)));

class AuthRepository {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _auth;
  String noImage =
      'https://imgs.search.brave.com/vBMZftqd6_8IN0WpRUL7DZNKvW_1uQM3geK-pmAeoqc/rs:fit:304:225:1/g:ce/aHR0cHM6Ly90c2Uy/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC5v/VW1PSUJwVnZ4TS1K/WkJ5WkR0emx3QUFB/QSZwaWQ9QXBp';
  AuthRepository({
    required FirebaseFirestore firebaseFirestore,
    required FirebaseAuth auth,
  })  : _firebaseFirestore = firebaseFirestore,
        _auth = auth;

  CollectionReference get _users =>
      _firebaseFirestore.collection(FirebaseConstants.usersCollection);

  //to know the authentication state of the user we get a stream of user from
//firebase auth

  Stream<User?> get authStateChange => _auth.authStateChanges();

  //get userModel stream from the database
  Stream<UserModel> getUserData(String authUid) {
    return _users.doc(authUid).snapshots().map((docSnapshot) {
      final data = docSnapshot.data() as Map;
      return UserModel(
          uid: data['uid'],
          name: data['name'],
          email: data['email'],
          password: data['password'],
          imageUrl: data['imageUrl']);
    });
  }

  FutureEither<UserModel> createUser(
      String name, String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      print(userCredential.user!.uid);

      final userModel = UserModel(
          uid: userCredential.user!.uid,
          name: name,
          email: email,
          password: password,
          imageUrl: noImage);

      await _users.doc(userCredential.user!.uid).set(userModel.toMap());

      return right(userModel);
    } on FirebaseException catch (error) {
      return left(Failure(error.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<UserModel> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      final doc = await _users.doc(userCredential.user!.uid).get();
      final data = doc.data() as Map;
      final usermodel = UserModel(
          uid: data['uid'],
          name: data['name'],
          email: data['email'],
          password: data['password'],
          imageUrl: data['imageUrl']);
      return right(usermodel);
    } on FirebaseAuthException catch (error) {
      return left(Failure(error.message.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //logOut From the app
  void logOut() async {
    await _auth.signOut();
  }
}
