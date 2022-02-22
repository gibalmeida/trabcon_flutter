import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRepository {
  Stream<User?> get authStateChanges;
  Future<void> signInWithUserAndEmail();
  User? getCurrentUser();
  Future<void> signOut();
}
