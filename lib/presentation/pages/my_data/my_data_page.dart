import 'package:brasil_fields/brasil_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:trabcon_flutter/domain/candidatos/value_objects.dart';
import 'package:trabcon_flutter/domain/core/enums.dart';
import 'package:trabcon_flutter/domain/core/value_objects.dart';
import 'package:trabcon_flutter/domain/candidatos/candidato.dart';

import 'package:intl/intl.dart';
import 'package:trabcon_flutter/presentation/pages/auth_gate/auth_gate.dart';
import 'package:trabcon_flutter/providers.dart';

final myDataFormProvider = FutureProvider<Candidato>(
  (ref) async {
    final candidatosRepository = ref.watch(candidatoRepositoryProvider);
    final user = ref.watch(userProvider);

    return user.when(
      data: (user) async {
        // ainda não fez autenticação
        if (user == null) {
          return Candidato.empty();
        } else {
          return (await candidatosRepository.fetchCandidato()).fold(
            (failure) => throw Exception(failure.toString()),
            (optionCandidato) => optionCandidato.fold(
              () =>
                  Candidato.empty(), // ainda não há dados do usuários gravados
              (candidato) => candidato, // dados carregados
            ),
          );
        }
      },
      error: (err, stack) => throw Exception(err.toString()),
      loading: () => Candidato.empty(),
    );
  },
);

class MyDataPage extends ConsumerWidget {
  const MyDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AuthGate(
      child: ref.watch(myDataFormProvider).when(
            data: (candidato) => MyDataForm(candidato),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (err, _stack) => Center(
              child: Text(err.toString()),
            ),
          ),
    );
  }
}

class MyDataForm extends HookConsumerWidget {
  MyDataForm(this.candidato, {Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final Candidato candidato;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Mudar o layout para telas maiores (web desktop)
    // TODO: Retirar a lógica de negócios de dentro dos Widgets e passar para o state
    // TODO: Nos campos de texto está sendo possível dar ENTER e escrever mais de uma linha
    final dateFormat = DateFormat.yMd();

    final nomeCompletoController =
        useTextEditingController(text: candidato.nomeCompleto.getOrNull());
    final dataDeNascimentoController = useTextEditingController(
      text: candidato.dataDeNascimento.value.fold(
        (failure) => '',
        (value) => dateFormat.format(value),
      ),
    );
    final genero = useState(candidato.genero.getOrNull());
    final profissaoController =
        useTextEditingController(text: candidato.profissao.getOrNull());
    final enderecoController =
        useTextEditingController(text: candidato.endereco.getOrNull());
    final bairroController =
        useTextEditingController(text: candidato.bairro.getOrNull());
    final cidadeController =
        useTextEditingController(text: candidato.cidade.getOrNull());
    final uf = useState(candidato.uf.getOrNull());
    final cepController =
        useTextEditingController(text: candidato.cep.getOrNull());
    final telefonePrincipalController =
        useTextEditingController(text: candidato.telefonePrincipal.getOrNull());
    final telefoneAlternativoController = useTextEditingController(
        text: candidato.telefoneAlternativo.getOrNull());
    final categoriasCnh = useState(candidato.categoriasCnh.getOrCrash());
    final veiculoAutomotorProprio =
        useState(candidato.veiculoAutomotorProprio.getOrNull());
    final estadoCivil = useState(candidato.estadoCivil.getOrNull());
    final conjugeController =
        useTextEditingController(text: candidato.conjuge.getOrNull());
    final numeroDeFilhosController = useTextEditingController(
        text: (candidato.numeroDeFilhos.getOrNull() ?? '').toString());
    final portadorDeNecessidadesEspeciais =
        useState(candidato.portadorDeNecessidadesEspeciais.getOrElse(false));
    final necessidadesEspeciaisController = useTextEditingController(
        text: candidato.necessidadesEspeciais.getOrNull());
    final temParentesNaEmpresa =
        useState(candidato.temParentesNaEmpresa.getOrCrash());
    final nomeDoParenteController =
        useTextEditingController(text: candidato.nomeDoParente.getOrNull());
    final tipoDeParentescoController =
        useTextEditingController(text: candidato.tipoDeParentesco.getOrNull());
    final temConhecidosNaEmpresa =
        useState(candidato.temConhecidosNaEmpresa.getOrCrash());
    final nomesDasPessoasConhecidasController = useTextEditingController(
        text: candidato.nomesDasPessoasConhecidas.getOrNull());
    final autoDescricaoDaPersonalidadeController = useTextEditingController(
        text: candidato.autoDescricaoDaPersonalidade.getOrNull());
    final motivacaoParaTrabalharNaEmpresaController = useTextEditingController(
        text: candidato.motivacaoParaTrabalharNaEmpresa.getOrNull());
    final outrasInformacoesPessoaisController = useTextEditingController(
        text: candidato.outrasInformacoesPessoais.getOrNull());
    final facebookUrlController =
        useTextEditingController(text: candidato.facebookUrl.getOrCrash());
    final instagramUrlController =
        useTextEditingController(text: candidato.instagramUrl.getOrCrash());
    final twitterUrlController =
        useTextEditingController(text: candidato.twitterUrl.getOrCrash());
    final linkedInUrlController =
        useTextEditingController(text: candidato.linkedInUrl.getOrCrash());
    final gitHubUrlController =
        useTextEditingController(text: candidato.gitHubUrl.getOrCrash());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Meu dados"),
        actions: [
          IconButton(
            // TODO: Esse botão vai sair daqui e vai para menu de gaveta
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: const Icon(
              Icons.logout_outlined,
            ),
          ),
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Salvando seus dados...'),
                  ),
                );
                final candidato = Candidato(
                  id: UniqueId(),
                  nomeCompleto: NomeCompleto(nomeCompletoController.text),
                  dataDeNascimento: DataDeNascimento.fromString(
                      dataDeNascimentoController.text),
                  genero: Genero(genero.value),
                  profissao: Profissao(profissaoController.text),
                  endereco: Endereco(enderecoController.text),
                  bairro: Bairro(bairroController.text),
                  cidade: Cidade(cidadeController.text),
                  uf: UnidadeFederativaDoBrasil(uf.value!),
                  cep: Cep(cepController.text),
                  telefonePrincipal:
                      TelefonePrincipal(telefonePrincipalController.text),
                  telefoneAlternativo:
                      TelefoneAlternativo(telefoneAlternativoController.text),
                  categoriasCnh: CategoriasCnh(categoriasCnh.value),
                  veiculoAutomotorProprio:
                      VeiculoAutomotorProprio(veiculoAutomotorProprio.value!),
                  estadoCivil: EstadoCivil(estadoCivil.value!),
                  conjuge: Conjuge(estadoCivil.value == EstadoCivilEnum.casado
                      ? conjugeController.text
                      : null),
                  numeroDeFilhos:
                      NumeroDeFilhos.fromString(numeroDeFilhosController.text),
                  portadorDeNecessidadesEspeciais:
                      PortadorDeNecessidadesEspeciais(
                          portadorDeNecessidadesEspeciais.value),
                  necessidadesEspeciais: NecessidadesEspeciais(
                      portadorDeNecessidadesEspeciais.value
                          ? necessidadesEspeciaisController.text
                          : null),
                  temParentesNaEmpresa:
                      TemParentesNaEmpresa(temParentesNaEmpresa.value),
                  nomeDoParente: NomeDoParente(temParentesNaEmpresa.value
                      ? nomeDoParenteController.text
                      : null),
                  tipoDeParentesco: TipoDeParentesco(temParentesNaEmpresa.value
                      ? tipoDeParentescoController.text
                      : null),
                  temConhecidosNaEmpresa:
                      TemConhecidosNaEmpresa(temConhecidosNaEmpresa.value),
                  nomesDasPessoasConhecidas: NomesDasPessoasConhecidas(
                      temConhecidosNaEmpresa.value
                          ? nomesDasPessoasConhecidasController.text
                          : null),
                  autoDescricaoDaPersonalidade: AutoDescricaoDaPersonalidade(
                      autoDescricaoDaPersonalidadeController.text),
                  motivacaoParaTrabalharNaEmpresa:
                      MotivacaoParaTrabalharNaEmpresa(
                          motivacaoParaTrabalharNaEmpresaController.text),
                  outrasInformacoesPessoais: OutrasInformacoesPessoais(
                      outrasInformacoesPessoaisController.text),
                  facebookUrl: FacebookUrl(facebookUrlController.text),
                  instagramUrl: InstagramUrl(instagramUrlController.text),
                  twitterUrl: TwitterUrl(twitterUrlController.text),
                  linkedInUrl: LinkedInUrl(linkedInUrlController.text),
                  gitHubUrl: GitHubUrl(gitHubUrlController.text),
                );

                ref
                    .read(candidatoRepositoryProvider)
                    .createOrUpdate(candidato)
                    .then(
                  (result) {
                    result.fold(
                      (l) => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Falha ao gravar os seus dados!'),
                          backgroundColor: Colors.red,
                        ),
                      ),
                      (_) => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Dados salvos com sucesso'),
                          backgroundColor: Colors.green,
                        ),
                      ),
                    );
                  },
                );
              }
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MyDataFormTextField(
                      controller: nomeCompletoController,
                      label: 'Nome completo',
                      autofocus: true,
                      maxLength: NomeCompleto.maxLength,
                      validator: (value) =>
                          _errorMessage(NomeCompleto(value ?? '')),
                    ),
                    TextFormField(
                      controller: dataDeNascimentoController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        DataInputFormatter()
                      ],
                      decoration: const InputDecoration(
                        label: Text('Data de nascimento'),
                        prefixIcon: Icon(Icons.cake),
                      ),
                      onTap: () {
                        // Below line stops keyboard from appearing
                        FocusScope.of(context).requestFocus(FocusNode());
                        _selectDataDeNascimento(
                          context,
                          dataDeNascimentoController,
                        ).then(
                          (dataSelecionada) {
                            if (dataSelecionada != null) {
                              dataDeNascimentoController.text =
                                  dateFormat.format(dataSelecionada);
                            }
                          },
                        );
                      },
                      keyboardType: TextInputType.datetime,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => _errorMessage(
                          DataDeNascimento.fromString(value ?? '')),
                      // onSaved: (value) =>  ,
                    ),
                    DropdownButtonFormField<GeneroEnum>(
                      hint: const Text('Gênero'),
                      value: genero.value,
                      items:
                          GeneroEnum.values.map<DropdownMenuItem<GeneroEnum>>(
                        (value) {
                          return DropdownMenuItem<GeneroEnum>(
                            value: value,
                            child: Text(value.toStringCapitalized()),
                          );
                        },
                      ).toList(),
                      onChanged: (value) => genero.value = value,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value == null
                          ? 'Você deve selecionar uma opção'
                          : _errorMessage(Genero(value)),
                    ),
                    MyDataFormTextField(
                      controller: profissaoController,
                      maxLength: Profissao.maxLength,
                      label: 'Profissão',
                      hintText: 'Informe sua profissão principal.',
                      helperText:
                          'Caso seja apenas estudante, informe "Estudante"',
                      validator: (value) =>
                          _errorMessage(Profissao(value ?? '')),
                    ),
                    const Divider(),
                    MyDataFormTextField(
                      controller: enderecoController,
                      maxLength: Endereco.maxLength,
                      label: 'Endereço',
                      hintText: 'Preencha com o seu endereço de residência',
                      keyboardType: TextInputType.streetAddress,
                      validator: (value) =>
                          _errorMessage(Endereco(value ?? '')),
                    ),
                    MyDataFormTextField(
                      controller: bairroController,
                      maxLength: Bairro.maxLength,
                      label: 'Bairro',
                      hintText:
                          'Preencha com o nome do seu bairro de residência.',
                      validator: (value) => _errorMessage(Bairro(value ?? '')),
                    ),
                    MyDataFormTextField(
                      controller: cidadeController,
                      maxLength: Cidade.maxLength,
                      label: 'Cidade',
                      hintText: 'Informe o nome da sua cidade de residência.',
                      validator: (value) => _errorMessage(Cidade(value ?? '')),
                    ),
                    DropdownButtonFormField<UnidadeFederativaDoBrasilEnum>(
                      hint: const Text('Estado/UF'),
                      value: uf.value,
                      items: UnidadeFederativaDoBrasilEnum.values
                          .map<DropdownMenuItem<UnidadeFederativaDoBrasilEnum>>(
                        (value) {
                          return DropdownMenuItem<
                              UnidadeFederativaDoBrasilEnum>(
                            value: value,
                            child: Text(value.toStringCapitalized()),
                          );
                        },
                      ).toList(),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value == null
                          ? 'Você deve selecionar um Estado'
                          : _errorMessage(UnidadeFederativaDoBrasil(value)),
                      onChanged: (value) => uf.value = value!,
                    ),
                    MyDataFormTextField(
                      controller: cepController,
                      maxLength: Cep.maxLength,
                      label: 'CEP',
                      hintText: 'Informe o nome da sua CEP de residência.',
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CepInputFormatter(),
                      ],
                      keyboardType: TextInputType.number,
                      validator: (value) => _errorMessage(Cep(value ?? '')),
                    ),
                    MyDataFormTextField(
                      controller: telefonePrincipalController,
                      maxLength: TelefonePrincipal.maxLength,
                      label: 'Telefone principal',
                      hintText: 'Número de telefone principal para contato',
                      helperText:
                          'Se precisarmos contactá-lo, vamos ligar nesse nº.',
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        TelefoneInputFormatter(),
                      ],
                      keyboardType: TextInputType.phone,
                      validator: (value) =>
                          _errorMessage(TelefonePrincipal(value ?? '')),
                    ),
                    MyDataFormTextField(
                      controller: telefoneAlternativoController,
                      maxLength: TelefoneAlternativo.maxLength,
                      label: 'Telefone alternativo',
                      hintText: 'Número de telefone alternativo para contato.',
                      helperText:
                          'Se o nº principal não der certo, tentamos nesse.',
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        TelefoneInputFormatter(),
                      ],
                      keyboardType: TextInputType.phone,
                      validator: (value) =>
                          _errorMessage(TelefoneAlternativo(value ?? '')),
                    ),
                    const Divider(),
                    const Text(
                      'Marque as categorias da sua CNH',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...categoriasCnh.value.entries.map<Widget>(
                          (categoria) {
                            return CheckboxListTile(
                              title: Text("Categoria ${categoria.key}"),
                              value: categoria.value,
                              onChanged: (newValue) {
                                categoriasCnh.value[categoria.key] =
                                    newValue ?? false;
                                categoriasCnh
                                    .notifyListeners(); // Tem que chamar notifyListeners senão a UI não é atualizada
                              },
                            );
                          },
                        ).toList(),
                      ],
                    ),
                    DropdownButtonFormField<VeiculoAutomotorProprioEnum>(
                      hint: const Text('Possui veículo automotor'),
                      value: veiculoAutomotorProprio.value,
                      items: VeiculoAutomotorProprioEnum.values
                          .map<DropdownMenuItem<VeiculoAutomotorProprioEnum>>(
                        (value) {
                          return DropdownMenuItem<VeiculoAutomotorProprioEnum>(
                            value: value,
                            child: Text(value.toStringCapitalized()),
                          );
                        },
                      ).toList(),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value == null
                          ? 'Você deve selecionar uma opção'
                          : _errorMessage(VeiculoAutomotorProprio(value)),
                      onChanged: (value) =>
                          veiculoAutomotorProprio.value = value,
                    ),
                    const Divider(),
                    DropdownButtonFormField<EstadoCivilEnum>(
                      hint: const Text('Estado civil'),
                      value: estadoCivil.value,
                      items: EstadoCivilEnum.values
                          .map<DropdownMenuItem<EstadoCivilEnum>>(
                        (value) {
                          return DropdownMenuItem<EstadoCivilEnum>(
                            value: value,
                            child: Text(value.toStringCapitalized()),
                          );
                        },
                      ).toList(),
                      validator: (value) => value == null
                          ? 'Você deve selecionar uma opção'
                          : _errorMessage(EstadoCivil(value)),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        estadoCivil.value = value;
                      },
                    ),
                    MyDataFormTextField(
                      maxLength: Conjuge.maxLength,
                      controller: conjugeController,
                      enabled: estadoCivil.value == EstadoCivilEnum.casado,
                      label: genero.value == GeneroEnum.masculino
                          ? 'Nome da esposa'
                          : genero.value == GeneroEnum.feminino
                              ? 'Nome do marido'
                              : 'Nome do conjuge',
                      hintText: 'Nome do conjuge',
                      validator: (value) =>
                          estadoCivil.value == EstadoCivilEnum.casado
                              ? _errorMessage(Conjuge(value))
                              : null,
                    ),
                    MyDataFormTextField(
                      maxLength: 2,
                      controller: numeroDeFilhosController,
                      label: 'Número de filhos',
                      hintText: 'Número de filhos que você possui',
                      helperText: 'Se não tiver filhos, coloque 0 no campo',
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          _errorMessage(NumeroDeFilhos.fromString(value ?? '')),
                    ),
                    const Divider(),
                    SwitchListTile(
                      title: const Text('É portador de necessidades especiais'),
                      value: portadorDeNecessidadesEspeciais.value,
                      onChanged: (value) =>
                          portadorDeNecessidadesEspeciais.value = value,
                    ),
                    MyDataFormTextField(
                      controller: necessidadesEspeciaisController,
                      maxLength: NecessidadesEspeciais.maxLength,
                      enabled: portadorDeNecessidadesEspeciais.value,
                      label: 'Necessidades especiais',
                      hintText: 'Preencha com as suas necessidades especiais',
                      keyboardType: TextInputType.text,
                      validator: (value) => portadorDeNecessidadesEspeciais
                              .value
                          ? _errorMessage(NecessidadesEspeciais(value ?? ''))
                          : null,
                    ),
                    const Divider(),
                    SwitchListTile(
                      title: const Text(
                          'Possui parente ou namorado(a) trabalhando na empresa'),
                      value: temParentesNaEmpresa.value,
                      onChanged: (value) => temParentesNaEmpresa.value = value,
                    ),
                    MyDataFormTextField(
                      maxLength: NomeDoParente.maxLength,
                      controller: nomeDoParenteController,
                      enabled: temParentesNaEmpresa.value,
                      label: 'Nome do parente ou namorada(o)',
                      hintText: 'Informe o nome da pessoa',
                      keyboardType: TextInputType.text,
                      validator: (value) => temParentesNaEmpresa.value
                          ? _errorMessage(NomeDoParente(value))
                          : null,
                    ),
                    MyDataFormTextField(
                      maxLength: TipoDeParentesco.maxLength,
                      controller: tipoDeParentescoController,
                      enabled: temParentesNaEmpresa.value,
                      label: 'Tipo de parentesco',
                      hintText: 'Informe a relação de parentesco',
                      helperText:
                          'Ex: pai, mãe, irmão(ã), namorado(a), tio(a), primo(a), etc.',
                      keyboardType: TextInputType.text,
                      validator: (value) => temParentesNaEmpresa.value
                          ? _errorMessage(TipoDeParentesco(value))
                          : null,
                    ),
                    const Divider(),
                    SwitchListTile(
                      title: const Text(
                          'Possui amigos/conhecidos que trabalha na empresa'),
                      value: temConhecidosNaEmpresa.value,
                      onChanged: (value) =>
                          temConhecidosNaEmpresa.value = value,
                    ),
                    MyDataFormTextField(
                      maxLength: NomesDasPessoasConhecidas.maxLength,
                      controller: nomesDasPessoasConhecidasController,
                      enabled: temConhecidosNaEmpresa.value,
                      label:
                          'Nomes dos amigos/conhecidos que trabalham na empresa',
                      hintText:
                          'Informe alguns nomes de pessoas conhecidas que trabalham na empresa',
                      keyboardType: TextInputType.text,
                      validator: (value) => temConhecidosNaEmpresa.value
                          ? _errorMessage(NomesDasPessoasConhecidas(value))
                          : null,
                    ),
                    const Divider(),
                    MyDataFormTextField(
                      controller: autoDescricaoDaPersonalidadeController,
                      maxLength: AutoDescricaoDaPersonalidade.maxLength,
                      label: 'Autodescrição da personalidade',
                      hintText: 'Faça uma autodescrição da sua personalidade',
                      maxLines: 5,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) => _errorMessage(
                          AutoDescricaoDaPersonalidade(value ?? '')),
                    ),
                    MyDataFormTextField(
                      controller: motivacaoParaTrabalharNaEmpresaController,
                      maxLength: MotivacaoParaTrabalharNaEmpresa.maxLength,
                      label: 'Por que gostaria de trabalhar conosco',
                      hintText:
                          'Diga-nos porque você gostaria de trabalhar em nossa empresa.',
                      maxLines: 5,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) => _errorMessage(
                          MotivacaoParaTrabalharNaEmpresa(value ?? '')),
                    ),
                    MyDataFormTextField(
                      controller: outrasInformacoesPessoaisController,
                      maxLength: OutrasInformacoesPessoais.maxLength,
                      label: 'Outras informações',
                      hintText:
                          'Caso queira coloque aqui outras informações a seu respeito.',
                      maxLines: 5,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) =>
                          _errorMessage(OutrasInformacoesPessoais(value ?? '')),
                    ),
                    const Divider(),
                    MyDataFormTextField(
                      controller: facebookUrlController,
                      maxLength: FacebookUrl.maxLength,
                      label: 'Facebook',
                      hintText: 'seu id no facebook',
                      prefixText: 'https://www.facebook.com/',
                      icon: const FaIcon(FontAwesomeIcons.facebook),
                      keyboardType: TextInputType.url,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) =>
                          _errorMessage(FacebookUrl(value ?? '')),
                    ),
                    MyDataFormTextField(
                      controller: instagramUrlController,
                      maxLength: InstagramUrl.maxLength,
                      label: 'Instagram',
                      hintText: 'seu id nome no Instagram',
                      icon: const FaIcon(FontAwesomeIcons.instagram),
                      prefixText: '@',
                      keyboardType: TextInputType.url,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) =>
                          _errorMessage(InstagramUrl(value ?? '')),
                    ),
                    MyDataFormTextField(
                      controller: twitterUrlController,
                      maxLength: TwitterUrl.maxLength,
                      label: 'Twitter',
                      hintText: 'seu id nome no Twitter',
                      prefixText: '@',
                      icon: const FaIcon(FontAwesomeIcons.twitter),
                      keyboardType: TextInputType.url,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) =>
                          _errorMessage(TwitterUrl(value ?? '')),
                    ),
                    MyDataFormTextField(
                      controller: linkedInUrlController,
                      maxLength: LinkedInUrl.maxLength,
                      label: 'LinkedIn',
                      hintText: 'seu id nome no LinkedIn',
                      prefixText: 'https://www.linkedin.com/in/',
                      icon: const FaIcon(FontAwesomeIcons.linkedin),
                      keyboardType: TextInputType.url,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) =>
                          _errorMessage(LinkedInUrl(value ?? '')),
                    ),
                    MyDataFormTextField(
                      controller: gitHubUrlController,
                      maxLength: GitHubUrl.maxLength,
                      label: 'GitHub',
                      hintText: 'seu id nome no GitHub',
                      prefixText: 'https://github.com/',
                      icon: const FaIcon(FontAwesomeIcons.github),
                      keyboardType: TextInputType.url,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) =>
                          _errorMessage(GitHubUrl(value ?? '')),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String? _errorMessage<T extends ValueObject<U>, U>(T field) {
    return field.failureOrUnit.fold(
      (failure) => failure.whenOrNull(
        exceedingLength: (_, max) =>
            "O tamanho do campo excedeu o limite de $max caracteres.",
        empty: (_) => 'O preenchimento deste campo é obrigatório.',
        optionNotSelected: (_) => 'É obrigatória a seleção de uma opção.',
        notAInteger: (_) => 'Este campo deve ser preenchido com um número.',
        outOfRange: (_, min, max) => 'O número deve estar entre $min e $max.',
        invalidCep: (_) =>
            'Formato do CEP inválido. Deve ser no formato XX.XXX-XXX',
      ),
      (_) => null,
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

class MyDataFormTextField<T extends ValueObject> extends HookWidget {
  const MyDataFormTextField({
    Key? key,
    this.controller,
    bool autofocus = false,
    this.enabled = true,
    required this.label,
    this.hintText,
    this.helperText,
    this.prefixText,
    this.icon,
    this.maxLines = 1,
    required this.maxLength,
    this.textCapitalization,
    this.keyboardType,
    this.inputFormatters,
    this.onSaved,
    this.onChanged,
    this.validator,
  }) : super(key: key);
  final TextEditingController? controller;
  final bool autofocus = false;
  final bool? enabled;
  final String label;
  final String? hintText;
  final String? helperText;
  final String? prefixText;
  final Widget? icon;
  final int? maxLength;
  final int? maxLines;
  final TextCapitalization? textCapitalization;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String? value)? onSaved;
  final void Function(String? value)? onChanged;
  final String? Function(String? value)? validator;

  @override
  TextFormField build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: autofocus,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enabled: enabled,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      decoration: InputDecoration(
        label: Text(label),
        hintText: hintText,
        helperText: helperText,
        prefixText: prefixText,
        icon: icon,
        // suffixIcon: FeedbackIcon(field: field),
      ),
      textCapitalization: textCapitalization ?? TextCapitalization.words,
      keyboardType: keyboardType,
      onSaved: (value) => onSaved != null ? onSaved!(value) : null,
      onChanged: (value) => onChanged != null ? onChanged!(value) : null,
      validator: (value) => validator != null ? validator!(value) : null,
    );
  }
}
