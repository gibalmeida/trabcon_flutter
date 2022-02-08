import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trabcon_flutter/application/my_data/my_data_form_state.dart';
import 'package:trabcon_flutter/domain/candidatos/candidato.dart';
import 'package:trabcon_flutter/domain/candidatos/i_candidatos_repository.dart';

class MyDataFormNotifier extends StateNotifier<MyDataFormState> {
  final ICandidatosRepository _candidatosRepository;
  MyDataFormNotifier(this._candidatosRepository)
      : super(MyDataFormState.loading());

  Future<void> fetchUserData() async {
    final candidato = await _candidatosRepository.fetchCandidato();
    state = candidato.fold(
      (failure) => MyDataFormState.failure('Error ao carregar os seus dados'),
      (optionCandidato) => optionCandidato.fold(
        () => MyDataFormState(
            Candidato.empty()), // ainda não há dados do usuários gravados
        (candidato) => MyDataFormState(candidato), // dados carregados
      ),
    );
  }

  Future<void> add(Candidato candidato) async {
    _candidatosRepository.create(candidato);
  }
}
