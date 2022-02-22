import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trabcon_flutter/domain/candidatos/i_candidatos_repository.dart';
import 'package:trabcon_flutter/infrastructure/candidatos/candidato_repository.dart';

final firebaseAuthProvider =
    Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final firebaseFirestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final firebaseStorageProvider =
    Provider<FirebaseStorage>((ref) => FirebaseStorage.instance);

final candidatoRepositoryProvider =
    Provider<ICandidatosRepository>((ref) => CandidatoRepository());

final userProvider =
    StreamProvider<User?>((ref) => FirebaseAuth.instance.authStateChanges());
