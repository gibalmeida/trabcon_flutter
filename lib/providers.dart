import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trabcon_flutter/domain/candidatos/i_candidatos_repository.dart';
import 'package:trabcon_flutter/infrastructure/candidatos/candidato_repository.dart';

final candidatoRepositoryProvider =
    Provider<ICandidatosRepository>((ref) => CandidatoRepository());

final userProvider =
    StreamProvider<User?>((ref) => FirebaseAuth.instance.authStateChanges());
