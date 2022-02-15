import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trabcon_flutter/domain/candidatos/candidato.dart';

part 'my_data_form_state.freezed.dart';

@freezed
class MyDataFormState with _$MyDataFormState {
  factory MyDataFormState(Candidato candidato) = _Data;
  factory MyDataFormState.initial() = _Initial;
  factory MyDataFormState.loading() = _Loading;
  factory MyDataFormState.failure(String message) = _Failure;
}
