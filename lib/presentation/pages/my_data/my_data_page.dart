import 'package:auto_route/auto_route.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trabcon_flutter/application/my_data/my_data_form_notifier.dart';
import 'package:trabcon_flutter/application/my_data/my_data_form_state.dart';
import 'package:trabcon_flutter/domain/core/enums.dart';
import 'package:trabcon_flutter/domain/core/value_objects.dart';
import 'package:trabcon_flutter/domain/candidatos/candidato.dart';
import 'package:trabcon_flutter/domain/candidatos/value_objects.dart';

import 'package:intl/intl.dart';
import 'package:trabcon_flutter/presentation/routes/app_router.gr.dart';
import 'package:trabcon_flutter/providers.dart';

final myDataProvider =
    StateNotifierProvider<MyDataFormNotifier, MyDataFormState>(
  (ref) {
    return MyDataFormNotifier(ref.watch(candidatoRepositoryProvider));
  },
);

class MyDataPage extends StatelessWidget {
  const MyDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meu dados"),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                AutoRouter.of(context).push(
                    const MyDataPageRoute()); //TODO: enviar para a página inicial onde o usuário não está autenticado
              },
              icon: const Icon(
                Icons.logout_outlined,
              )),
        ],
      ),
      body: MyDataForm(),
    );
  }
}

class MyDataForm extends HookConsumerWidget {
  MyDataForm({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(myDataProvider);

    return state.maybeWhen(
      (Candidato myData) => buildForm(state, myData, ref),
      loading: () {
        ref.read(myDataProvider.notifier).fetchUserData();
        return const Center(child: CircularProgressIndicator());
      },
      orElse: () => Container(),
    );
  }

  LayoutBuilder buildForm(
      MyDataFormState state, Candidato myData, WidgetRef ref) {
    // TODO: Mudar o layout para telas maiores (web desktop)
    // TODO: Retirar a lógica de negócios de dentro dos Widgets e passar para o state
    final nomeCompleto = useState(myData.nomeCompleto);
    final genero = useState(myData.genero);

    final dataDeNascimento = useState(myData.dataDeNascimento);
    final _dataDeNascimentoController = useTextEditingController();

    final profissao = useState(myData.profissao);
    final endereco = useState(myData.endereco);
    final bairro = useState(myData.bairro);
    final cidade = useState(myData.cidade);
    final uf = useState(myData.uf);
    final cep = useState(myData.cep);

    final telefonePrincipal = useState(myData.telefonePrincipal);
    final telefoneAlternativo = useState(myData.telefoneAlternativo);

    final categoriasCnh = useState(myData.categoriasCnh);
    final veiculoAutomotorProprio = useState(myData.veiculoAutomotorProprio);

    final estadoCivil = useState(myData.estadoCivil);
    final conjuge = useState(myData.conjuge);
    final conjugeController =
        useTextEditingController(text: myData.conjuge.getOrNull() ?? '');
    final numeroDeFilhos = useState(myData.numeroDeFilhos);

    final portadorDeNecessidadesEspeciais =
        useState(myData.portadorDeNecessidadesEspeciais);

    final necessidadesEspeciais = useState(myData.necessidadesEspeciais);
    final necessidadesEspeciaisController = useTextEditingController(
        text: myData.necessidadesEspeciais.getOrNull() ?? '');

    final temParentesNaEmpresa = useState(myData.temParentesNaEmpresa);
    final nomeDoParente = useState(myData.nomeDoParente);
    final nomeDoParenteController =
        useTextEditingController(text: myData.nomeDoParente.getOrNull() ?? '');
    final tipoDeParentesco = useState(myData.tipoDeParentesco);
    final tipoDeParentescoController = useTextEditingController(
        text: myData.tipoDeParentesco.getOrNull() ?? '');

    final temConhecidosNaEmpresa = useState(myData.temConhecidosNaEmpresa);
    final nomesDasPessoasConhecidas =
        useState(myData.nomesDasPessoasConhecidas);
    final nomesDasPessoasConhecidasController = useTextEditingController(
        text: myData.nomesDasPessoasConhecidas.value
            .fold((l) => '', (r) => r ?? ''));

    final autoDescricaoDaPersonalidade =
        useState(myData.autoDescricaoDaPersonalidade);
    final motivacaoParaTrabalharNaEmpresa =
        useState(myData.motivacaoParaTrabalharNaEmpresa);
    final outrasInformacoesPessoais =
        useState(myData.outrasInformacoesPessoais);

    final facebookUrl = useState(myData.facebookUrl);
    final instagramUrl = useState(myData.instagramUrl);
    final twitterUrl = useState(myData.twitterUrl);
    final linkedInUrl = useState(myData.linkedInUrl);
    final gitHubUrl = useState(myData.gitHubUrl);

    final isCasado = useState<bool>(
      estadoCivil.value.value.fold(
        (failure) => false, // se o estado civil estiver vazio (não selecionado)
        (value) => value == EstadoCivilEnum.casado,
      ),
    );
    final labelForConjuge =
        useState(_labelForConjuge(genero.value.getOrNull()));

    final dateFormat = DateFormat.yMd();
    _dataDeNascimentoController.text = dataDeNascimento.value.value.fold(
      (failure) => '',
      (value) => dateFormat.format(value),
    );

    useEffect(
      () {
        genero.addListener(() {
          labelForConjuge.value = _labelForConjuge(genero.value.getOrCrash());
        });
        estadoCivil.addListener(() {
          isCasado.value =
              estadoCivil.value.getOrCrash() == EstadoCivilEnum.casado;
          if (!isCasado.value) {
            conjuge.value = Conjuge(null);
            conjugeController.text = '';
          } else {
            conjuge.value = myData.conjuge;
            conjugeController.text = conjuge.value.getOrNull() ?? '';
          }
        });
        //TODO:colocar a atribuição do controller para o estado na chamada do validate de cada campo e não aqui.
        portadorDeNecessidadesEspeciais.addListener(() {
          if (portadorDeNecessidadesEspeciais.value.getOrCrash() == true) {
            necessidadesEspeciais.value = myData.necessidadesEspeciais;
            necessidadesEspeciaisController.text =
                necessidadesEspeciais.value.getOrNull() ?? '';
          } else {
            necessidadesEspeciais.value = NecessidadesEspeciais(null);
            necessidadesEspeciaisController.text = '';
          }
        });
        temParentesNaEmpresa.addListener(() {
          if (temParentesNaEmpresa.value.getOrCrash() == true) {
            tipoDeParentesco.value = myData.tipoDeParentesco;
            tipoDeParentescoController.text =
                tipoDeParentesco.value.getOrNull() ?? '';
            nomeDoParente.value = myData.nomeDoParente;
            nomeDoParenteController.text =
                nomeDoParente.value.getOrNull() ?? '';
          } else {
            tipoDeParentesco.value = TipoDeParentesco(null);
            tipoDeParentescoController.text = '';
            nomeDoParente.value = NomeDoParente(null);
            nomeDoParenteController.text = '';
          }
        });
        temConhecidosNaEmpresa.addListener(() {
          if (temConhecidosNaEmpresa.value.getOrCrash() == true) {
            nomesDasPessoasConhecidas.value = myData.nomesDasPessoasConhecidas;
            nomesDasPessoasConhecidasController.text =
                nomesDasPessoasConhecidas.value.getOrNull() ?? '';
          } else {
            nomesDasPessoasConhecidas.value = NomesDasPessoasConhecidas(null);
            nomesDasPessoasConhecidasController.text = '';
          }
        });
      },
    );

    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  autofocus: true,
                  initialValue: _initialValue(nomeCompleto),
                  maxLength: NomeCompleto.maxLength,
                  decoration: InputDecoration(
                      label: const Text('Nome Completo'),
                      suffixIcon: _feedbackIcon(nomeCompleto)),
                  textCapitalization: TextCapitalization.words,
                  validator: (_) => _validateField(nomeCompleto),
                  onChanged: (value) =>
                      nomeCompleto.value = NomeCompleto(value),
                ),
                TextFormField(
                  controller: _dataDeNascimentoController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    DataInputFormatter()
                  ],
                  decoration: InputDecoration(
                    label: const Text('Data de nascimento'),
                    prefixIcon: const Icon(Icons.cake),
                    suffixIcon: _feedbackIcon(dataDeNascimento),
                  ),
                  onTap: () {
                    // Below line stops keyboard from appearing
                    FocusScope.of(context).requestFocus(FocusNode());
                    _selectDataDeNascimento(
                      context,
                      _dataDeNascimentoController,
                    ).then((dataSelecionada) {
                      if (dataSelecionada != null) {
                        _dataDeNascimentoController.text =
                            dateFormat.format(dataSelecionada);
                        dataDeNascimento.value =
                            DataDeNascimento(dataSelecionada);
                      }
                    });
                  },
                  keyboardType: TextInputType.datetime,
                  validator: (_) => _validateField(dataDeNascimento),
                ),
                DropdownButtonFormField<GeneroEnum>(
                  hint: const Text('Gênero'),
                  value: genero.value.getOrNull(),
                  items: GeneroEnum.values.map<DropdownMenuItem<GeneroEnum>>(
                    (value) {
                      return DropdownMenuItem<GeneroEnum>(
                        value: value,
                        child: Text(value.toStringCapitalized()),
                      );
                    },
                  ).toList(),
                  validator: (_) => _validateField(genero),
                  onChanged: (value) => genero.value = Genero(value!),
                ),
                TextFormField(
                  initialValue: _initialValue(profissao),
                  maxLength: Profissao.maxLength,
                  decoration: InputDecoration(
                    labelText: 'Profissão',
                    hintText: 'Informe sua profissão principal.',
                    helperText:
                        'Caso seja apenas estudante, informe "Estudante"',
                    suffixIcon: _feedbackIcon(profissao),
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (_) => _validateField(profissao),
                  onChanged: (value) => profissao.value = Profissao(value),
                ),
                TextFormField(
                  initialValue: _initialValue(endereco),
                  maxLength: Endereco.maxLength,
                  decoration: InputDecoration(
                    labelText: 'Endereço',
                    hintText: 'Preencha com o seu endereço de residência',
                    suffixIcon: _feedbackIcon(endereco),
                  ),
                  validator: (_) => _validateField(endereco),
                  keyboardType: TextInputType.streetAddress,
                  textCapitalization: TextCapitalization.words,
                  onChanged: (value) => endereco.value = Endereco(value),
                ),
                TextFormField(
                  initialValue: _initialValue(bairro),
                  maxLength: Bairro.maxLength,
                  decoration: InputDecoration(
                    label: const Text('Bairro'),
                    hintText:
                        'Preencha com o nome do seu bairro de residência.',
                    suffixIcon: _feedbackIcon(bairro),
                  ),
                  validator: (_) => _validateField(bairro),
                  textCapitalization: TextCapitalization.words,
                  onChanged: (value) => bairro.value = Bairro(value),
                ),
                TextFormField(
                  initialValue: _initialValue(cidade),
                  maxLength: Cidade.maxLength,
                  decoration: InputDecoration(
                    label: const Text('Cidade'),
                    hintText: 'Informe o nome da sua cidade de residência.',
                    suffixIcon: _feedbackIcon(cidade),
                  ),
                  validator: (_) => _validateField(cidade),
                  textCapitalization: TextCapitalization.words,
                  onChanged: (value) => cidade.value = Cidade(value),
                ),
                DropdownButtonFormField<UnidadeFederativaDoBrasilEnum>(
                  hint: const Text('Estado de Residência'),
                  value: uf.value.getOrNull(),
                  items: UnidadeFederativaDoBrasilEnum.values
                      .map<DropdownMenuItem<UnidadeFederativaDoBrasilEnum>>(
                    (value) {
                      return DropdownMenuItem<UnidadeFederativaDoBrasilEnum>(
                        value: value,
                        child: Text(value.toStringCapitalized()),
                      );
                    },
                  ).toList(),
                  validator: (_) => _validateField(uf),
                  onChanged: (value) =>
                      uf.value = UnidadeFederativaDoBrasil(value!),
                ),
                TextFormField(
                  initialValue: _initialValue(cep),
                  maxLength: Cep.maxLength,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CepInputFormatter(),
                  ],
                  decoration: InputDecoration(
                      label: const Text('CEP'),
                      hintText: 'Informe o nome da sua CEP de residência.',
                      suffixIcon: _feedbackIcon(cep)),
                  validator: (_) => _validateField(cep),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => cep.value = Cep(value),
                ),
                TextFormField(
                  initialValue: _initialValue(telefonePrincipal),
                  maxLength: TelefonePrincipal.maxLength,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter(),
                  ],
                  decoration: InputDecoration(
                      label: const Text('Telefone principal'),
                      hintText: 'Número de telefone principal para contato',
                      suffixIcon: _feedbackIcon(telefonePrincipal),
                      helperText:
                          'Se precisarmos contactá-lo, vamos ligar nesse nº.'),
                  onChanged: (value) =>
                      telefonePrincipal.value = TelefonePrincipal(value),
                  validator: (_) => _validateField(telefonePrincipal),
                  keyboardType: TextInputType.phone,
                ),
                TextFormField(
                  initialValue: _initialValue(telefoneAlternativo),
                  maxLength: TelefoneAlternativo.maxLength,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter(),
                  ],
                  decoration: InputDecoration(
                    suffixIcon: _feedbackIcon(telefoneAlternativo),
                    label: const Text('Telefone alternativo'),
                    hintText: 'Número de telefone alternativo para contato.',
                    helperText:
                        'Se o nº principal não der certo, tentamos nesse.',
                  ),
                  validator: (_) => _validateField(telefoneAlternativo),
                  keyboardType: TextInputType.phone,
                  onChanged: (value) =>
                      telefoneAlternativo.value = TelefoneAlternativo(value),
                ),
                const Divider(),
                const Text(
                  "Marque as categorias da sua CNH",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...categoriasCnh.value.getOrCrash().entries.map<Widget>(
                      (categoria) {
                        return CheckboxListTile(
                          title: Text("Categoria ${categoria.key}"),
                          value: categoria.value,
                          onChanged: (newValue) {
                            // Tem que fazer essa roleira toda ai com map
                            // senão ao alterar o valor de categoriasCnh
                            // não atualiza a UI
                            categoriasCnh.value = CategoriasCnh(
                              categoriasCnh.value
                                  .getOrCrash()
                                  .map<String, bool>(
                                (key, currentValue) {
                                  if (key == categoria.key) {
                                    return MapEntry(key, newValue ?? false);
                                  }
                                  return MapEntry(key, currentValue);
                                },
                              ),
                            );
                          },
                        );
                      },
                    ).toList(),
                  ],
                ),
                DropdownButtonFormField<VeiculoAutomotorProprioEnum>(
                  hint: const Text('Possui veículo automotor próprio?'),
                  value: veiculoAutomotorProprio.value.getOrNull(),
                  items: VeiculoAutomotorProprioEnum.values
                      .map<DropdownMenuItem<VeiculoAutomotorProprioEnum>>(
                    (value) {
                      return DropdownMenuItem<VeiculoAutomotorProprioEnum>(
                        value: value,
                        child: Text(value.toStringCapitalized()),
                      );
                    },
                  ).toList(),
                  validator: (_) => _validateField(veiculoAutomotorProprio),
                  onChanged: (value) => veiculoAutomotorProprio.value =
                      VeiculoAutomotorProprio(value!),
                ),
                const Divider(),
                DropdownButtonFormField<EstadoCivilEnum>(
                  hint: const Text('Estado Civil'),
                  value: estadoCivil.value.getOrNull(),
                  items: EstadoCivilEnum.values
                      .map<DropdownMenuItem<EstadoCivilEnum>>(
                    (value) {
                      return DropdownMenuItem<EstadoCivilEnum>(
                        value: value,
                        child: Text(value.toStringCapitalized()),
                      );
                    },
                  ).toList(),
                  validator: (_) => _validateField(estadoCivil),
                  onChanged: (value) => estadoCivil.value = EstadoCivil(value!),
                ),
                TextFormField(
                  controller: conjugeController,
                  maxLength: Conjuge.maxLength,
                  decoration: InputDecoration(
                      label: Text(labelForConjuge.value),
                      hintText: 'Nome do conjuge',
                      suffix: _feedbackIcon(conjuge)),
                  enabled: isCasado.value,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  onChanged: (value) => conjuge.value = Conjuge(value),
                  validator: (_) => _validateField(conjuge),
                ),
                TextFormField(
                  initialValue: numeroDeFilhos.value.value.fold(
                    (failure) => '',
                    (value) => value.toString(),
                  ),
                  maxLength: 2,
                  decoration: InputDecoration(
                    label: const Text('Número de filhos'),
                    hintText: 'Número de filhos que você possui',
                    helperText: 'Se não tiver filhos, coloque 0 no campo',
                    suffixIcon: _feedbackIcon(numeroDeFilhos),
                  ),
                  validator: (_) => _validateField(numeroDeFilhos),
                  keyboardType: TextInputType.number,
                  onChanged: (value) =>
                      numeroDeFilhos.value = NumeroDeFilhos.fromString(value),
                ),
                const Divider(),
                SwitchListTile(
                  title: const Text('É portador de necessidades especias?'),
                  value: portadorDeNecessidadesEspeciais.value.getOrElse(false),
                  onChanged: (value) => portadorDeNecessidadesEspeciais.value =
                      PortadorDeNecessidadesEspeciais(value),
                ),
                TextFormField(
                  controller: necessidadesEspeciaisController,
                  maxLength: NecessidadesEspeciais.maxLength,
                  decoration: InputDecoration(
                    label: const Text('Necessidades Especiais'),
                    hintText: 'Preencha com as suas necessidades especiais',
                    suffixIcon: _feedbackIcon(necessidadesEspeciais),
                  ),
                  enabled:
                      portadorDeNecessidadesEspeciais.value.getOrElse(false),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  onChanged: (value) => necessidadesEspeciais.value =
                      NecessidadesEspeciais(value),
                  validator: (_) => _validateField(necessidadesEspeciais),
                ),
                const Divider(),
                SwitchListTile(
                  title: const Text(
                      'Tem algum parente ou namorada(o) trabalhando na empresa?'),
                  value: temParentesNaEmpresa.value.getOrElse(false),
                  onChanged: (value) =>
                      temParentesNaEmpresa.value = TemParentesNaEmpresa(value),
                ),
                TextFormField(
                  controller: nomeDoParenteController,
                  maxLength: NomeDoParente.maxLength,
                  decoration: InputDecoration(
                    label: const Text('Nome do parente ou namorada(o)'),
                    hintText: 'Informe o nome da pessoa',
                    suffixIcon: _feedbackIcon(nomeDoParente),
                  ),
                  enabled: temParentesNaEmpresa.value.getOrElse(false),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  onChanged: (value) =>
                      nomeDoParente.value = NomeDoParente(value),
                  validator: (_) => _validateField(nomeDoParente),
                ),
                TextFormField(
                  controller: tipoDeParentescoController,
                  maxLength: TipoDeParentesco.maxLength,
                  decoration: InputDecoration(
                    label: const Text('Tipo de parentesco'),
                    hintText: 'Informe a relação de parentesco',
                    helperText:
                        'Ex: pai, mãe, irmão(ã), namorado(a), tio(a), primo(a), etc.',
                    suffixIcon: _feedbackIcon(tipoDeParentesco),
                  ),
                  enabled: temParentesNaEmpresa.value.getOrElse(false),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  onChanged: (value) =>
                      tipoDeParentesco.value = TipoDeParentesco(value),
                  validator: (_) => _validateField(tipoDeParentesco),
                ),
                const Divider(),
                SwitchListTile(
                  title: const Text(
                      'É amigo/conhecido de alguem que trabalha na empresa?'),
                  value: temConhecidosNaEmpresa.value.getOrElse(false),
                  onChanged: (value) => temConhecidosNaEmpresa.value =
                      TemConhecidosNaEmpresa(value),
                ),
                TextFormField(
                  controller: nomesDasPessoasConhecidasController,
                  maxLength: NomesDasPessoasConhecidas.maxLength,
                  decoration: InputDecoration(
                    label: const Text('Nome das pessoas conhecidas'),
                    hintText:
                        'Informe alguns nomes de pessoas conhecidas que trabalham na empresa',
                    suffixIcon: _feedbackIcon(nomesDasPessoasConhecidas),
                  ),
                  enabled: temConhecidosNaEmpresa.value.getOrElse(false),
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  onChanged: (value) => nomesDasPessoasConhecidas.value =
                      NomesDasPessoasConhecidas(value),
                  validator: (_) => _validateField(nomesDasPessoasConhecidas),
                ),
                const Divider(),
                TextFormField(
                  initialValue: _initialValue(autoDescricaoDaPersonalidade),
                  maxLength: AutoDescricaoDaPersonalidade.maxLength,
                  maxLines: 5,
                  decoration: InputDecoration(
                    label: const Text('Autodescrição da sua personalidade'),
                    hintText: 'Faça uma autodescrição da sua personalidade',
                    suffixIcon: _feedbackIcon(autoDescricaoDaPersonalidade),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) => autoDescricaoDaPersonalidade.value =
                      AutoDescricaoDaPersonalidade(value),
                  validator: (_) =>
                      _validateField(autoDescricaoDaPersonalidade),
                ),
                TextFormField(
                  initialValue: _initialValue(motivacaoParaTrabalharNaEmpresa),
                  maxLength: MotivacaoParaTrabalharNaEmpresa.maxLength,
                  maxLines: 5,
                  decoration: InputDecoration(
                    label: const Text(
                      'Por que você gostaria de trabalhar em nossa empresa?',
                    ),
                    hintText:
                        'Diga-nos porque você gostaria de trabalhar em nossa empresa.',
                    suffixIcon: _feedbackIcon(motivacaoParaTrabalharNaEmpresa),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) => motivacaoParaTrabalharNaEmpresa.value =
                      MotivacaoParaTrabalharNaEmpresa(value),
                  validator: (_) =>
                      _validateField(motivacaoParaTrabalharNaEmpresa),
                ),
                TextFormField(
                  initialValue: _initialValue(outrasInformacoesPessoais),
                  maxLength: OutrasInformacoesPessoais.maxLength,
                  maxLines: 5,
                  decoration: InputDecoration(
                    label: const Text('Outras informações pessoais'),
                    hintText:
                        'Caso queira coloque aqui outras informações a seu respeito.',
                    suffixIcon: _feedbackIcon(outrasInformacoesPessoais),
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) => outrasInformacoesPessoais.value =
                      OutrasInformacoesPessoais(value),
                  validator: (_) => _validateField(outrasInformacoesPessoais),
                ),
                const Divider(),
                TextFormField(
                  initialValue: _initialValue(facebookUrl),
                  maxLength: FacebookUrl.maxLength,
                  decoration: InputDecoration(
                    icon: const FaIcon(FontAwesomeIcons.facebook),
                    label: const Text('Facebook'),
                    prefixText: 'https://www.facebook.com/',
                    hintText: 'seu id no facebook',
                    suffixIcon: _feedbackIcon(facebookUrl),
                  ),
                  keyboardType: TextInputType.url,
                  validator: (_) => _validateField(facebookUrl),
                  onChanged: (value) => facebookUrl.value = FacebookUrl(value),
                ),
                TextFormField(
                  initialValue: _initialValue(instagramUrl),
                  maxLength: InstagramUrl.maxLength,
                  decoration: InputDecoration(
                    icon: const FaIcon(FontAwesomeIcons.instagram),
                    label: const Text('Instagram'),
                    prefixText: '@',
                    hintText: 'seu id nome no Instagram',
                    suffixIcon: _feedbackIcon(instagramUrl),
                  ),
                  keyboardType: TextInputType.url,
                  validator: (_) => _validateField(instagramUrl),
                  onChanged: (value) =>
                      instagramUrl.value = InstagramUrl(value),
                ),
                TextFormField(
                  initialValue: _initialValue(twitterUrl),
                  maxLength: TwitterUrl.maxLength,
                  decoration: InputDecoration(
                    icon: const FaIcon(FontAwesomeIcons.twitter),
                    label: const Text('Twitter'),
                    prefixText: '@',
                    hintText: 'seu id nome no Twitter',
                    suffixIcon: _feedbackIcon(twitterUrl),
                  ),
                  keyboardType: TextInputType.url,
                  validator: (_) => _validateField(twitterUrl),
                  onChanged: (value) => twitterUrl.value = TwitterUrl(value),
                ),
                TextFormField(
                  initialValue: _initialValue(linkedInUrl),
                  maxLength: LinkedInUrl.maxLength,
                  decoration: InputDecoration(
                    icon: const FaIcon(FontAwesomeIcons.linkedin),
                    label: const Text('LinkedIn'),
                    prefixText: 'https://www.linkedin.com/in/',
                    hintText: 'seu id nome no LinkedIn',
                    suffixIcon: _feedbackIcon(linkedInUrl),
                  ),
                  keyboardType: TextInputType.url,
                  validator: (_) => _validateField(linkedInUrl),
                  onChanged: (value) => linkedInUrl.value = LinkedInUrl(value),
                ),
                TextFormField(
                  initialValue: _initialValue(gitHubUrl),
                  maxLength: GitHubUrl.maxLength,
                  decoration: InputDecoration(
                      icon: const FaIcon(FontAwesomeIcons.github),
                      label: const Text('GitHub'),
                      prefixText: 'https://github.com/',
                      hintText: 'seu id nome no GitHub',
                      suffixIcon: _feedbackIcon(gitHubUrl)),
                  keyboardType: TextInputType.url,
                  validator: (_) => _validateField(gitHubUrl),
                  onChanged: (value) => gitHubUrl.value = GitHubUrl(value),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Salvando seus dados...'),
                        ),
                      );
                      ref
                          .read(myDataProvider.notifier)
                          .add(
                            myData.copyWith(
                              nomeCompleto: nomeCompleto.value,
                              genero: genero.value,
                              dataDeNascimento: dataDeNascimento.value,
                              profissao: profissao.value,
                              endereco: endereco.value,
                              bairro: bairro.value,
                              cidade: cidade.value,
                              uf: uf.value,
                              cep: cep.value,
                              telefonePrincipal: telefonePrincipal.value,
                              telefoneAlternativo: telefoneAlternativo.value,
                              veiculoAutomotorProprio:
                                  veiculoAutomotorProprio.value,
                              categoriasCnh: categoriasCnh.value,
                              estadoCivil: estadoCivil.value,
                              conjuge: conjuge.value,
                              numeroDeFilhos: numeroDeFilhos.value,
                              portadorDeNecessidadesEspeciais:
                                  portadorDeNecessidadesEspeciais.value,
                              necessidadesEspeciais:
                                  necessidadesEspeciais.value,
                              temParentesNaEmpresa: temParentesNaEmpresa.value,
                              nomeDoParente: nomeDoParente.value,
                              tipoDeParentesco: tipoDeParentesco.value,
                              temConhecidosNaEmpresa:
                                  temConhecidosNaEmpresa.value,
                              nomesDasPessoasConhecidas:
                                  nomesDasPessoasConhecidas.value,
                              autoDescricaoDaPersonalidade:
                                  autoDescricaoDaPersonalidade.value,
                              motivacaoParaTrabalharNaEmpresa:
                                  motivacaoParaTrabalharNaEmpresa.value,
                              outrasInformacoesPessoais:
                                  outrasInformacoesPessoais.value,
                              facebookUrl: facebookUrl.value,
                              instagramUrl: instagramUrl.value,
                              twitterUrl: twitterUrl.value,
                              linkedInUrl: linkedInUrl.value,
                              gitHubUrl: gitHubUrl.value,
                            ),
                          )
                          .then(
                        (value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Dados salvos com sucesso'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                      );
                    }
                    print(conjuge);
                    print(necessidadesEspeciais);
                    print(nomeDoParente);
                  },
                  child: const Text('Salvar'),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  String _labelForConjuge(GeneroEnum? genero) {
    switch (genero) {
      case GeneroEnum.masculino:
        return 'Nome da esposa';
      case GeneroEnum.feminino:
        return 'Nome do marido';

      default:
        return 'Nome do Conjuge';
    }
  }

  String _initialValue<T extends ValueObject>(ValueNotifier<T> valueNotifier) {
    final valueObject = valueNotifier.value;
    return valueObject.value.fold(
      (failure) => failure.maybeWhen(
        empty: (_) => '',
        orElse: () => failure.failedValue,
      ),
      (value) => value ?? '',
    );
  }

  Icon? _feedbackIcon<T extends ValueObject>(ValueNotifier<T?> valueNotifier) {
    final valueObject = valueNotifier.value;

    if (valueObject == null) {
      return null;
    }

    return valueObject.value.fold(
      (failure) => failure.maybeWhen(
        empty: (_) => null,
        orElse: () => _notOkFeedbackIcon(),
      ),
      (_) => _okFeedbackIcon(),
    );
  }

  Icon _okFeedbackIcon() {
    return const Icon(
      Icons.check_circle,
      color: Colors.green,
    );
  }

  Icon _notOkFeedbackIcon() {
    return const Icon(
      Icons.error,
      color: Colors.red,
    );
  }

  String? _validateField<T extends ValueObject>(
      ValueNotifier<T> valueNotifier) {
    return valueNotifier.value.failureOrUnit.fold(
      (f) => f.maybeWhen(
        exceedingLength: (_, max) =>
            "O tamanho do campo excedeu o limite de $max caracteres.",
        empty: (_) => 'O preenchimento deste campo é obrigatório.',
        optionNotSelected: (_) => 'É obrigatória a seleção de uma opção.',
        notAInteger: (_) => 'Este campo deve ser preenchido com um número.',
        outOfRange: (_, min, max) => 'O número deve estar entre $min e $max.',
        invalidCep: (_) =>
            'Formato do CEP inválido. Deve ser no formato XX.XXX-XXX',
        orElse: () => null,
      ),
      (r) => null,
    );
  }

  Future<DateTime?> _selectDataDeNascimento(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final anoCorrente = DateTime.now().year;
    final primeiroAno = anoCorrente -
        80; // dificilmente será contratado alguém com mais de 80 anos
    final ultimoAno = anoCorrente -
        14; // também não será contratado ninguém com menos de 14 anos (estou levando em consideração o menor aprendiz).
    DateTime initialDate;
    try {
      initialDate = DateFormat.yMd().parse(controller.text);
    } on FormatException catch (_) {
      initialDate = DateTime(ultimoAno);
    }

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(primeiroAno),
      lastDate: DateTime(ultimoAno),
    );
    return pickedDate;
  }
}
