import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:trabcon_flutter/domain/candidatos/candidatos_failure.dart';
import 'package:trabcon_flutter/domain/candidatos/candidato.dart';
import 'package:dartz/dartz.dart';
import 'package:trabcon_flutter/domain/candidatos/i_candidatos_repository.dart';
import 'package:trabcon_flutter/infrastructure/candidatos/candidato_dtos.dart';

class CandidatoRepository implements ICandidatosRepository {
  final candidatosRef = FirebaseFirestore.instance
      .collection('candidatos')
      .withConverter<CandidatoDto>(
        fromFirestore: (snapshot, _) => CandidatoDto.fromJson(snapshot.data()!),
        toFirestore: (candidato, _) => candidato.toJson(),
      );

  @override
  Future<Either<CandidatosFailure, Unit>> createOrUpdate(
      Candidato candidato) async {
    try {
      await candidatosRef
          .doc(_userId())
          .set(CandidatoDto.fromDomain(candidato));

      return right(unit);
    } on PlatformException catch (_) {
      return left(CandidatosFailure.unexpected());
    }
  }

  @override
  Future<Either<CandidatosFailure, Unit>> delete(Candidato candidato) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<CandidatosFailure, Unit>> update(Candidato candidato) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<Either<CandidatosFailure, Option<Candidato>>> fetchCandidato() async {
    final snapshot = await candidatosRef.doc(_userId()).get();

    if (snapshot.exists && snapshot.data() != null) {
      return right(some(snapshot.data()!.toDomain()));
    } else {
      return right(none());
    }
  }

  String _userId() {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      throw Exception('O usuário deveria estar autenticado!');
    }
    return uid;
  }
}
