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

const smallScreenWidth = 640.0;
const mediumScreenWidth = 1007.0;

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

// TODO: Verificar o problema que aconteceu das Categorias de CNH ficar fora de ordem no Chrome
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

    onPressedSaveButton() {
      if (_formKey.currentState!.validate()) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Salvando seus dados...'),
          ),
        );
        final candidato = Candidato(
          id: UniqueId(),
          nomeCompleto: NomeCompleto(nomeCompletoController.text),
          dataDeNascimento:
              DataDeNascimento.fromString(dataDeNascimentoController.text),
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
          portadorDeNecessidadesEspeciais: PortadorDeNecessidadesEspeciais(
              portadorDeNecessidadesEspeciais.value),
          necessidadesEspeciais: NecessidadesEspeciais(
              portadorDeNecessidadesEspeciais.value
                  ? necessidadesEspeciaisController.text
                  : null),
          temParentesNaEmpresa:
              TemParentesNaEmpresa(temParentesNaEmpresa.value),
          nomeDoParente: NomeDoParente(
              temParentesNaEmpresa.value ? nomeDoParenteController.text : null),
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
          motivacaoParaTrabalharNaEmpresa: MotivacaoParaTrabalharNaEmpresa(
              motivacaoParaTrabalharNaEmpresaController.text),
          outrasInformacoesPessoais: OutrasInformacoesPessoais(
              outrasInformacoesPessoaisController.text),
          facebookUrl: FacebookUrl(facebookUrlController.text),
          instagramUrl: InstagramUrl(instagramUrlController.text),
          twitterUrl: TwitterUrl(twitterUrlController.text),
          linkedInUrl: LinkedInUrl(linkedInUrlController.text),
          gitHubUrl: GitHubUrl(gitHubUrlController.text),
        );

        ref.read(candidatoRepositoryProvider).createOrUpdate(candidato).then(
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
    }

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
          MediaQuery.of(context).size.width < smallScreenWidth
              ? IconButton(
                  onPressed: onPressedSaveButton,
                  icon: const Icon(Icons.save),
                )
              : ElevatedButton.icon(
                  onPressed: onPressedSaveButton,
                  icon: const Icon(Icons.save),
                  label: const Text('Salvar'),
                ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final containerWidth = constraints.maxWidth *
              (constraints.maxWidth <= mediumScreenWidth ? 0.99 : 0.90);
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.only(top: 16.0),
                  width: containerWidth,
                  child: Flex(
                    direction: Axis.vertical,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.spaceBetween,
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: [
                          SizedBox(
                            width:
                                _responsiveWidth(containerWidth, 1, .45, .30),
                            child: _buildNomeCompleto(nomeCompletoController),
                          ),
                          SizedBox(
                            width:
                                _responsiveWidth(containerWidth, 1, .32, .18),
                            child: _buildDataDeNascimento(
                                dataDeNascimentoController,
                                context,
                                dateFormat),
                          ),
                          SizedBox(
                            width:
                                _responsiveWidth(containerWidth, 1, .20, .20),
                            child: _buildGenero(genero),
                          ),
                          SizedBox(
                            width: _responsiveWidth(containerWidth, 1, 1, .29),
                            child: _buildProfissao(profissaoController),
                          ),
                        ],
                      ),
                      const Divider(),
                      Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.spaceBetween,
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: [
                          SizedBox(
                            width:
                                _responsiveWidth(containerWidth, 1, 0.49, 0.49),
                            child: _buildEndereco(enderecoController),
                          ),
                          SizedBox(
                            width:
                                _responsiveWidth(containerWidth, 1, 0.49, 0.50),
                            child: _buildBairro(bairroController),
                          ),
                          SizedBox(
                            width:
                                _responsiveWidth(containerWidth, 1, 0.45, 0.49),
                            child: _buildCidade(cidadeController),
                          ),
                          SizedBox(
                            width:
                                _responsiveWidth(containerWidth, 1, 0.32, 0.39),
                            child: _buildEstado(uf),
                          ),
                          SizedBox(
                            width:
                                _responsiveWidth(containerWidth, 1, 0.18, 0.1),
                            child: _buildCep(cepController),
                          )
                        ],
                      ),
                      const Divider(),
                      Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.spaceBetween,
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: [
                          SizedBox(
                              width: _responsiveWidth(
                                  containerWidth, 1, 0.49, 0.49),
                              child: _buildTelefonePrincipal(
                                  telefonePrincipalController)),
                          SizedBox(
                              width: _responsiveWidth(
                                  containerWidth, 1, 0.49, 0.50),
                              child: _buildTelefoneAlternativo(
                                  telefoneAlternativoController)),
                        ],
                      ),
                      const Divider(),
                      Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.spaceBetween,
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: [
                          Column(
                            children: [
                              const Text(
                                'Marque as categorias da sua CNH',
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                  width: _responsiveWidth(
                                      containerWidth, 1, 1, 0.49),
                                  child: _buildCategoriasCnh(
                                      context, categoriasCnh)),
                            ],
                          ),
                          SizedBox(
                              width:
                                  _responsiveWidth(containerWidth, 1, 1, 0.50),
                              child: _buildVeiculoAutomotorProprio(
                                  veiculoAutomotorProprio)),
                        ],
                      ),
                      const Divider(),
                      Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.spaceBetween,
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: [
                          SizedBox(
                              width: _responsiveWidth(
                                  containerWidth, 1, 0.20, 0.24),
                              child: _buildEstadoCivil(estadoCivil)),
                          SizedBox(
                              width: _responsiveWidth(
                                  containerWidth, 1, 0.49, 0.50),
                              child: _buildConjuge(
                                  conjugeController, estadoCivil, genero)),
                          SizedBox(
                              width: _responsiveWidth(
                                  containerWidth, 1, 0.28, 0.24),
                              child: _buildNumeroDeFilhos(
                                  numeroDeFilhosController)),
                        ],
                      ),
                      const Divider(),
                      Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.spaceBetween,
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: [
                          SizedBox(
                            width:
                                _responsiveWidth(containerWidth, 1, 0.30, 0.30),
                            child: _buildPortadorDeNecessidadesEspeciais(
                                portadorDeNecessidadesEspeciais),
                          ),
                          SizedBox(
                            width:
                                _responsiveWidth(containerWidth, 1, 0.68, 0.68),
                            child: _buildNecessidadesEspeciais(
                                necessidadesEspeciaisController,
                                portadorDeNecessidadesEspeciais),
                          ),
                        ],
                      ),
                      const Divider(),
                      Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.spaceBetween,
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: [
                          SizedBox(
                              width: _responsiveWidth(
                                  containerWidth, 1, 0.30, 0.30),
                              child: _buildTemParentesNaEmpresa(
                                  temParentesNaEmpresa)),
                          SizedBox(
                            width:
                                _responsiveWidth(containerWidth, 1, 0.37, 0.37),
                            child: _buildNomeDoParente(
                                nomeDoParenteController, temParentesNaEmpresa),
                          ),
                          SizedBox(
                            width:
                                _responsiveWidth(containerWidth, 1, 0.30, 0.37),
                            child: _buildTipoDeParentesco(
                                tipoDeParentescoController,
                                temParentesNaEmpresa),
                          ),
                        ],
                      ),
                      const Divider(),
                      Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.spaceBetween,
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: [
                          SizedBox(
                              width: _responsiveWidth(
                                  containerWidth, 1, 0.30, 0.68),
                              child: _buildTemConhecidosNaEmpresa(
                                  temConhecidosNaEmpresa)),
                          SizedBox(
                            width:
                                _responsiveWidth(containerWidth, 1, 0.68, 0.68),
                            child: _buildNomesDasPessoasConhecidas(
                                nomesDasPessoasConhecidasController,
                                temConhecidosNaEmpresa),
                          ),
                        ],
                      ),
                      const Divider(),
                      Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.spaceBetween,
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: [
                          SizedBox(
                            child: _buildAutoDescricaoDaPersonalidade(
                                autoDescricaoDaPersonalidadeController),
                          ),
                          SizedBox(
                            child: _buildMotivoParaTrabalharNaEmpresa(
                                motivacaoParaTrabalharNaEmpresaController),
                          ),
                          SizedBox(
                              child: _buildOutrasInformacoes(
                                  outrasInformacoesPessoaisController)),
                        ],
                      ),
                      const Divider(),
                      Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.spaceBetween,
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: [
                          SizedBox(
                              width:
                                  _responsiveWidth(containerWidth, 1, 1, 0.49),
                              child: _buildFacebookUrl(facebookUrlController)),
                          SizedBox(
                              width:
                                  _responsiveWidth(containerWidth, 1, 1, 0.50),
                              child:
                                  _buildInstagramUrl(instagramUrlController)),
                          SizedBox(
                              width:
                                  _responsiveWidth(containerWidth, 1, 1, 0.49),
                              child: _buildTwitterUrl(twitterUrlController)),
                          SizedBox(
                              width:
                                  _responsiveWidth(containerWidth, 1, 1, 0.50),
                              child: _buildLinkedInUrl(linkedInUrlController)),
                          SizedBox(
                              width:
                                  _responsiveWidth(containerWidth, 1, 1, 0.49),
                              child: _buildGitHubUrl(gitHubUrlController)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
          // }
        },
      ),
    );
  }

  double _responsiveWidth(double containerWidth, percForSmallScreen,
      percForMediumScreen, percForLargeScreen) {
    if (containerWidth <= smallScreenWidth) {
      return (percForSmallScreen * containerWidth);
    } else if (containerWidth <= mediumScreenWidth) {
      return (percForMediumScreen * containerWidth);
    } else {
      return (percForLargeScreen * containerWidth);
    }
  }

  MyDataFormTextField<ValueObject<dynamic>> _buildGitHubUrl(
      TextEditingController gitHubUrlController) {
    return MyDataFormTextField(
      controller: gitHubUrlController,
      maxLength: GitHubUrl.maxLength,
      label: 'GitHub',
      hintText: 'seu id nome no GitHub',
      prefixText: 'https://github.com/',
      icon: const FaIcon(FontAwesomeIcons.github),
      keyboardType: TextInputType.url,
      textCapitalization: TextCapitalization.none,
      validator: (value) => _errorMessage(GitHubUrl(value ?? '')),
    );
  }

  MyDataFormTextField<ValueObject<dynamic>> _buildLinkedInUrl(
      TextEditingController linkedInUrlController) {
    return MyDataFormTextField(
      controller: linkedInUrlController,
      maxLength: LinkedInUrl.maxLength,
      label: 'LinkedIn',
      hintText: 'seu id nome no LinkedIn',
      prefixText: 'https://www.linkedin.com/in/',
      icon: const FaIcon(FontAwesomeIcons.linkedin),
      keyboardType: TextInputType.url,
      textCapitalization: TextCapitalization.none,
      validator: (value) => _errorMessage(LinkedInUrl(value ?? '')),
    );
  }

  MyDataFormTextField<ValueObject<dynamic>> _buildTwitterUrl(
      TextEditingController twitterUrlController) {
    return MyDataFormTextField(
      controller: twitterUrlController,
      maxLength: TwitterUrl.maxLength,
      label: 'Twitter',
      hintText: 'seu id nome no Twitter',
      prefixText: '@',
      icon: const FaIcon(FontAwesomeIcons.twitter),
      keyboardType: TextInputType.url,
      textCapitalization: TextCapitalization.none,
      validator: (value) => _errorMessage(TwitterUrl(value ?? '')),
    );
  }

  MyDataFormTextField<ValueObject<dynamic>> _buildInstagramUrl(
      TextEditingController instagramUrlController) {
    return MyDataFormTextField(
      controller: instagramUrlController,
      maxLength: InstagramUrl.maxLength,
      label: 'Instagram',
      hintText: 'seu id nome no Instagram',
      icon: const FaIcon(FontAwesomeIcons.instagram),
      prefixText: '@',
      keyboardType: TextInputType.url,
      textCapitalization: TextCapitalization.none,
      validator: (value) => _errorMessage(InstagramUrl(value ?? '')),
    );
  }

  MyDataFormTextField<ValueObject<dynamic>> _buildFacebookUrl(
      TextEditingController facebookUrlController) {
    return MyDataFormTextField(
      controller: facebookUrlController,
      maxLength: FacebookUrl.maxLength,
      label: 'Facebook',
      hintText: 'seu id no facebook',
      prefixText: 'https://www.facebook.com/',
      icon: const FaIcon(FontAwesomeIcons.facebook),
      keyboardType: TextInputType.url,
      textCapitalization: TextCapitalization.none,
      validator: (value) => _errorMessage(FacebookUrl(value ?? '')),
    );
  }

  MyDataFormTextField<ValueObject<dynamic>> _buildOutrasInformacoes(
      TextEditingController outrasInformacoesPessoaisController) {
    return MyDataFormTextField(
      controller: outrasInformacoesPessoaisController,
      maxLength: OutrasInformacoesPessoais.maxLength,
      label: 'Outras informações',
      hintText: 'Caso queira coloque aqui outras informações a seu respeito.',
      maxLines: 5,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.none,
      validator: (value) =>
          _errorMessage(OutrasInformacoesPessoais(value ?? '')),
    );
  }

  MyDataFormTextField<ValueObject<dynamic>> _buildMotivoParaTrabalharNaEmpresa(
      TextEditingController motivacaoParaTrabalharNaEmpresaController) {
    return MyDataFormTextField(
      controller: motivacaoParaTrabalharNaEmpresaController,
      maxLength: MotivacaoParaTrabalharNaEmpresa.maxLength,
      label: 'Por que gostaria de trabalhar conosco',
      hintText: 'Diga-nos porque você gostaria de trabalhar em nossa empresa.',
      maxLines: 5,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.none,
      validator: (value) =>
          _errorMessage(MotivacaoParaTrabalharNaEmpresa(value ?? '')),
    );
  }

  MyDataFormTextField<ValueObject<dynamic>> _buildAutoDescricaoDaPersonalidade(
      TextEditingController autoDescricaoDaPersonalidadeController) {
    return MyDataFormTextField(
      controller: autoDescricaoDaPersonalidadeController,
      maxLength: AutoDescricaoDaPersonalidade.maxLength,
      label: 'Autodescrição da personalidade',
      hintText: 'Faça uma autodescrição da sua personalidade',
      maxLines: 5,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.none,
      validator: (value) =>
          _errorMessage(AutoDescricaoDaPersonalidade(value ?? '')),
    );
  }

  MyDataFormTextField<ValueObject<dynamic>> _buildNomesDasPessoasConhecidas(
      TextEditingController nomesDasPessoasConhecidasController,
      ValueNotifier<bool> temConhecidosNaEmpresa) {
    return MyDataFormTextField(
      maxLength: NomesDasPessoasConhecidas.maxLength,
      controller: nomesDasPessoasConhecidasController,
      enabled: temConhecidosNaEmpresa.value,
      label: 'Nomes dos amigos/conhecidos que trabalham na empresa',
      hintText:
          'Informe alguns nomes de pessoas conhecidas que trabalham na empresa',
      keyboardType: TextInputType.text,
      validator: (value) => temConhecidosNaEmpresa.value
          ? _errorMessage(NomesDasPessoasConhecidas(value))
          : null,
    );
  }

  SwitchListTile _buildTemConhecidosNaEmpresa(
      ValueNotifier<bool> temConhecidosNaEmpresa) {
    return SwitchListTile(
      title: const Text('Possui amigos/conhecidos que trabalha na empresa'),
      value: temConhecidosNaEmpresa.value,
      onChanged: (value) => temConhecidosNaEmpresa.value = value,
    );
  }

  MyDataFormTextField<ValueObject<dynamic>> _buildTipoDeParentesco(
      TextEditingController tipoDeParentescoController,
      ValueNotifier<bool> temParentesNaEmpresa) {
    return MyDataFormTextField(
      maxLength: TipoDeParentesco.maxLength,
      controller: tipoDeParentescoController,
      enabled: temParentesNaEmpresa.value,
      label: 'Tipo de parentesco',
      hintText: 'Informe a relação de parentesco',
      helperText: 'Ex: pai, mãe, irmão(ã), namorado(a), tio(a), primo(a), etc.',
      keyboardType: TextInputType.text,
      validator: (value) => temParentesNaEmpresa.value
          ? _errorMessage(TipoDeParentesco(value))
          : null,
    );
  }

  MyDataFormTextField<ValueObject<dynamic>> _buildNomeDoParente(
      TextEditingController nomeDoParenteController,
      ValueNotifier<bool> temParentesNaEmpresa) {
    return MyDataFormTextField(
      maxLength: NomeDoParente.maxLength,
      controller: nomeDoParenteController,
      enabled: temParentesNaEmpresa.value,
      label: 'Nome do parente ou namorada(o)',
      hintText: 'Informe o nome da pessoa',
      keyboardType: TextInputType.text,
      validator: (value) => temParentesNaEmpresa.value
          ? _errorMessage(NomeDoParente(value))
          : null,
    );
  }

  SwitchListTile _buildTemParentesNaEmpresa(
      ValueNotifier<bool> temParentesNaEmpresa) {
    return SwitchListTile(
      title: const Text('Possui parente ou namorado(a) trabalhando na empresa'),
      value: temParentesNaEmpresa.value,
      onChanged: (value) => temParentesNaEmpresa.value = value,
    );
  }

  MyDataFormTextField<ValueObject<dynamic>> _buildNecessidadesEspeciais(
      TextEditingController necessidadesEspeciaisController,
      ValueNotifier<bool> portadorDeNecessidadesEspeciais) {
    return MyDataFormTextField(
      controller: necessidadesEspeciaisController,
      maxLength: NecessidadesEspeciais.maxLength,
      enabled: portadorDeNecessidadesEspeciais.value,
      label: 'Necessidades especiais',
      hintText: 'Preencha com as suas necessidades especiais',
      keyboardType: TextInputType.text,
      validator: (value) => portadorDeNecessidadesEspeciais.value
          ? _errorMessage(NecessidadesEspeciais(value ?? ''))
          : null,
    );
  }

  SwitchListTile _buildPortadorDeNecessidadesEspeciais(
      ValueNotifier<bool> portadorDeNecessidadesEspeciais) {
    return SwitchListTile(
      title: const Text('É portador de necessidades especiais'),
      value: portadorDeNecessidadesEspeciais.value,
      onChanged: (value) => portadorDeNecessidadesEspeciais.value = value,
    );
  }

  MyDataFormTextField<ValueObject<dynamic>> _buildNumeroDeFilhos(
      TextEditingController numeroDeFilhosController) {
    return MyDataFormTextField(
      maxLength: 2,
      controller: numeroDeFilhosController,
      label: 'Número de filhos',
      hintText: 'Número de filhos que você possui',
      helperText: 'Se não tiver filhos, coloque 0 no campo',
      keyboardType: TextInputType.number,
      validator: (value) =>
          _errorMessage(NumeroDeFilhos.fromString(value ?? '')),
    );
  }

  MyDataFormTextField<ValueObject<dynamic>> _buildConjuge(
      TextEditingController conjugeController,
      ValueNotifier<EstadoCivilEnum?> estadoCivil,
      ValueNotifier<GeneroEnum?> genero) {
    return MyDataFormTextField(
      maxLength: Conjuge.maxLength,
      controller: conjugeController,
      enabled: estadoCivil.value == EstadoCivilEnum.casado,
      label: genero.value == GeneroEnum.masculino
          ? 'Nome da esposa'
          : genero.value == GeneroEnum.feminino
              ? 'Nome do marido'
              : 'Nome do conjuge',
      hintText: 'Nome do conjuge',
      validator: (value) => estadoCivil.value == EstadoCivilEnum.casado
          ? _errorMessage(Conjuge(value))
          : null,
    );
  }

  DropdownButtonFormField<EstadoCivilEnum> _buildEstadoCivil(
      ValueNotifier<EstadoCivilEnum?> estadoCivil) {
    return DropdownButtonFormField<EstadoCivilEnum>(
      decoration: const InputDecoration(
        label: Text('Estado civil'),
        contentPadding: EdgeInsets.all(11.0),
      ),
      hint: const Text('Selecione'),
      value: estadoCivil.value,
      items: EstadoCivilEnum.values.map<DropdownMenuItem<EstadoCivilEnum>>(
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
    );
  }

  DropdownButtonFormField<VeiculoAutomotorProprioEnum>
      _buildVeiculoAutomotorProprio(
          ValueNotifier<VeiculoAutomotorProprioEnum?> veiculoAutomotorProprio) {
    return DropdownButtonFormField<VeiculoAutomotorProprioEnum>(
      decoration: const InputDecoration(
        label: Text('Possui veículo automotor'),
        contentPadding: EdgeInsets.all(11.0),
      ),
      hint: const Text('Selecione'),
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
      onChanged: (value) => veiculoAutomotorProprio.value = value,
    );
  }

  Widget _buildCategoriasCnh(
      BuildContext context, ValueNotifier<Map<String, bool>> categoriasCnh) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10.0,
      children: [
        ...const <Map<String, Widget>>[
          {'A': FaIcon(FontAwesomeIcons.motorcycle, size: 18.0)},
          {'B': FaIcon(FontAwesomeIcons.carSide, size: 18.0)},
          {'C': FaIcon(FontAwesomeIcons.truck, size: 18.0)},
          {'D': FaIcon(FontAwesomeIcons.bus, size: 18.0)},
          {'E': FaIcon(FontAwesomeIcons.truck, size: 18.0)},
        ].map<Widget>(
          (value) {
            final categoria = value.entries.first;
            return ChoiceChip(
              label: Text("Categoria ${categoria.key}"),
              avatar: categoria.value,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              selectedColor: Theme.of(context).primaryColorLight,
              selected: categoriasCnh.value[categoria.key] ?? false,
              onSelected: (value) {
                categoriasCnh.value[categoria.key] = value;
                categoriasCnh
                    .notifyListeners(); // Tem que chamar notifyListeners senão a UI não é atualizada
              },
            );
          },
        ).toList(),
      ],
    );
  }

  MyDataFormTextField<ValueObject<dynamic>> _buildTelefoneAlternativo(
      TextEditingController telefoneAlternativoController) {
    return MyDataFormTextField(
      controller: telefoneAlternativoController,
      maxLength: TelefoneAlternativo.maxLength,
      label: 'Telefone alternativo',
      hintText: 'Número de telefone alternativo para contato.',
      helperText: 'Se o nº principal não der certo, tentamos nesse.',
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        TelefoneInputFormatter(),
      ],
      keyboardType: TextInputType.phone,
      validator: (value) => _errorMessage(TelefoneAlternativo(value ?? '')),
    );
  }

  MyDataFormTextField<ValueObject<dynamic>> _buildTelefonePrincipal(
      TextEditingController telefonePrincipalController) {
    return MyDataFormTextField(
      controller: telefonePrincipalController,
      maxLength: TelefonePrincipal.maxLength,
      label: 'Telefone principal',
      hintText: 'Número de telefone principal para contato',
      helperText: 'Se precisarmos contactá-lo, vamos ligar nesse nº.',
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        TelefoneInputFormatter(),
      ],
      keyboardType: TextInputType.phone,
      validator: (value) => _errorMessage(TelefonePrincipal(value ?? '')),
    );
  }

  MyDataFormTextField<ValueObject<dynamic>> _buildCep(
      TextEditingController cepController) {
    return MyDataFormTextField(
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
    );
  }

  DropdownButtonFormField<UnidadeFederativaDoBrasilEnum> _buildEstado(
      ValueNotifier<UnidadeFederativaDoBrasilEnum?> uf) {
    return DropdownButtonFormField<UnidadeFederativaDoBrasilEnum>(
      decoration: const InputDecoration(
        label: Text('Estado/UF'),
        contentPadding: EdgeInsets.all(11.0),
      ),
      hint: const Text('Selecione'),
      value: uf.value,
      items: UnidadeFederativaDoBrasilEnum.values
          .map<DropdownMenuItem<UnidadeFederativaDoBrasilEnum>>(
        (value) {
          return DropdownMenuItem<UnidadeFederativaDoBrasilEnum>(
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
    );
  }

  MyDataFormTextField<ValueObject<dynamic>> _buildCidade(
      TextEditingController cidadeController) {
    return MyDataFormTextField(
      controller: cidadeController,
      maxLength: Cidade.maxLength,
      label: 'Cidade',
      hintText: 'Informe o nome da sua cidade de residência.',
      validator: (value) => _errorMessage(Cidade(value ?? '')),
    );
  }

  MyDataFormTextField<ValueObject<dynamic>> _buildBairro(
      TextEditingController bairroController) {
    return MyDataFormTextField(
      controller: bairroController,
      maxLength: Bairro.maxLength,
      label: 'Bairro',
      hintText: 'Preencha com o nome do seu bairro de residência.',
      validator: (value) => _errorMessage(Bairro(value ?? '')),
    );
  }

  MyDataFormTextField<ValueObject<dynamic>> _buildEndereco(
      TextEditingController enderecoController) {
    return MyDataFormTextField(
      controller: enderecoController,
      maxLength: Endereco.maxLength,
      label: 'Endereço',
      hintText: 'Preencha com o seu endereço de residência',
      keyboardType: TextInputType.streetAddress,
      validator: (value) => _errorMessage(Endereco(value ?? '')),
    );
  }

  MyDataFormTextField<ValueObject<dynamic>> _buildProfissao(
      TextEditingController profissaoController) {
    return MyDataFormTextField(
      controller: profissaoController,
      maxLength: Profissao.maxLength,
      label: 'Profissão',
      hintText: 'Informe sua profissão principal.',
      helperText: 'Caso seja apenas estudante, informe "Estudante"',
      validator: (value) => _errorMessage(Profissao(value ?? '')),
    );
  }

  DropdownButtonFormField<GeneroEnum> _buildGenero(
      ValueNotifier<GeneroEnum?> genero) {
    return DropdownButtonFormField<GeneroEnum>(
      decoration: const InputDecoration(
        label: Text('Gênero'),
        contentPadding: EdgeInsets.all(11.0),
      ),
      hint: const Text('Selecione'),
      value: genero.value,
      items: GeneroEnum.values.map<DropdownMenuItem<GeneroEnum>>(
        (value) {
          return DropdownMenuItem<GeneroEnum>(
            value: value,
            child: Text(
              value.toStringCapitalized(),
            ),
          );
        },
      ).toList(),
      onChanged: (value) => genero.value = value,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => value == null
          ? 'Você deve selecionar uma opção'
          : _errorMessage(Genero(value)),
    );
  }

  TextFormField _buildDataDeNascimento(
      TextEditingController dataDeNascimentoController,
      BuildContext context,
      DateFormat dateFormat) {
    return TextFormField(
      controller: dataDeNascimentoController,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        DataInputFormatter()
      ],
      decoration: const InputDecoration(
        label: Text('Data de nascimento'),
        prefixIcon: Icon(Icons.cake),
      ),
      style: const TextStyle(fontSize: 18.0),
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
      validator: (value) =>
          _errorMessage(DataDeNascimento.fromString(value ?? '')),
      // onSaved: (value) =>  ,
    );
  }

  MyDataFormTextField<ValueObject<dynamic>> _buildNomeCompleto(
      TextEditingController nomeCompletoController) {
    return MyDataFormTextField(
      controller: nomeCompletoController,
      label: 'Nome completo',
      autofocus: true,
      maxLength: NomeCompleto.maxLength,
      validator: (value) => _errorMessage(NomeCompleto(value ?? '')),
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
      style: const TextStyle(fontSize: 18.0),
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
