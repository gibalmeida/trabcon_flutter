import 'package:dartz/dartz.dart';
import 'package:trabcon_flutter/domain/candidatos/candidato.dart';
import 'package:trabcon_flutter/domain/candidatos/candidatos_failure.dart';

abstract class ICandidatosRepository {
  Future<Either<CandidatosFailure, Option<Candidato>>> fetchCandidato();
  Future<Either<CandidatosFailure, Unit>> create(Candidato candidato);
  Future<Either<CandidatosFailure, Unit>> update(Candidato candidato);
  Future<Either<CandidatosFailure, Unit>> delete(Candidato candidato);
}
