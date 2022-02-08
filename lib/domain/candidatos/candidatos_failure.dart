import 'package:freezed_annotation/freezed_annotation.dart';

part 'candidatos_failure.freezed.dart';

@freezed
class CandidatosFailure with _$CandidatosFailure {
  factory CandidatosFailure.unexpected() = _Unexpected;
}
