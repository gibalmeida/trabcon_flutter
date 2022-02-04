import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trabcon_flutter/domain/my_data/my_data.dart';

part 'my_data_form_state.freezed.dart';

@freezed
class MyDataFormState with _$MyDataFormState {
  factory MyDataFormState.initial() = _Initial;
  factory MyDataFormState.loading() = _Loading;
  factory MyDataFormState(MyData myData) = _Data;
  factory MyDataFormState.failure(String message) = _Failure;
}
