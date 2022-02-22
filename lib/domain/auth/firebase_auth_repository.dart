import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trabcon_flutter/domain/auth/custom_exception.dart';
import 'package:trabcon_flutter/domain/auth/i_auth_repository.dart';
import 'package:trabcon_flutter/providers.dart';

final authRepositoryProvider =
    Provider<IAuthRepository>((ref) => FirebaseAuthRepository(ref.read));

class FirebaseAuthRepository implements IAuthRepository {
  const FirebaseAuthRepository(this._read);
  final Reader _read;

  @override
  Stream<User?> get authStateChanges =>
      _read(firebaseAuthProvider).authStateChanges();

  @override
  User? getCurrentUser() {
    try {
      return _read(firebaseAuthProvider).currentUser;
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> signInWithUserAndEmail() {
    // TODO: implement signInWithUserAndEmail
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    try {
      await _read(firebaseAuthProvider).signOut();
      // await _read(firebaseAuthProvider)
      // .signInAnonymously(); //TODO: Será que isso é útil?
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
