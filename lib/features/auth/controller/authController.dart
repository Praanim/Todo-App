import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_app/features/auth/repository/auth_repository.dart';
import 'package:hamro_app/model/user_model.dart';

import '../../../core/utils.dart';

//authstateprovider

final authStateProvider = StreamProvider<User?>((ref) {
  final streamofNullableUser =
      ref.watch(authControllerProvider).authStateChange;
  return streamofNullableUser;
});

final userProvider = StateProvider<UserModel?>(
  (ref) => null,
);

//authcontroller provider
final authControllerProvider = Provider((ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider), ref: ref));

class AuthController {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({
    required AuthRepository authRepository,
    required Ref ref,
  })  : _authRepository = authRepository,
        _ref = ref;

  void createUser(
      String name, String email, String password, BuildContext context) async {
    final customUser = await _authRepository.createUser(name, email, password);
    customUser.fold(
        (failure) => showSnackBar(context, failure.message),
        (userModel) =>
            _ref.read(userProvider.notifier).update((state) => userModel));
  }
  //signIn user ko lagi pani same logic rakhna parxa
  //just like in signup

  void signInUser(String email, String password, BuildContext context) async {
    final customUser = await _authRepository.signIn(email, password);
    customUser.fold((l) => showSnackBar(context, l.message),
        (r) => _ref.read(userProvider.notifier).update((state) => r));
  }

  //aba stream vayexi tah stream provider setup garna milyo using riverpod

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  //get stream of usermodel

  Stream<UserModel> getUserdata(String authUid) =>
      _authRepository.getUserData(authUid);

  //logging Out

  void logOut() {
    _authRepository.logOut();
  }
}
