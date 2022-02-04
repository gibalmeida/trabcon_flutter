import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trabcon_flutter/application/my_data/my_data_form_state.dart';
import 'package:trabcon_flutter/domain/my_data/my_data.dart';

class MyDataFormNotifier extends StateNotifier<MyDataFormState> {
  MyDataFormNotifier() : super(MyDataFormState(MyData.empty()));
}
