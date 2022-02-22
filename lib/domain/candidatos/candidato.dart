import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trabcon_flutter/domain/candidatos/value_objects.dart';
import 'package:trabcon_flutter/domain/core/enums.dart';
import 'package:trabcon_flutter/domain/core/value_objects.dart';

part 'candidato.freezed.dart';

@freezed
class Candidato with _$Candidato {
  const Candidato._();
  const factory Candidato({
    required UniqueId id,
    required NomeCompleto nomeCompleto,
    required DataDeNascimento dataDeNascimento,
    required Genero genero,
    required Profissao profissao,
    required Endereco endereco,
    required Bairro bairro,
    required Cidade cidade,
    required UnidadeFederativaDoBrasil uf,
    required Cep cep,
    required TelefonePrincipal telefonePrincipal,
    required TelefoneAlternativo telefoneAlternativo,
    required CategoriasCnh categoriasCnh,
    required VeiculoAutomotorProprio veiculoAutomotorProprio,
    required EstadoCivil estadoCivil,
    required NumeroDeFilhos numeroDeFilhos,
    required Conjuge conjuge,
    required PortadorDeNecessidadesEspeciais portadorDeNecessidadesEspeciais,
    required NecessidadesEspeciais necessidadesEspeciais,
    required TemParentesNaEmpresa temParentesNaEmpresa,
    required NomeDoParente nomeDoParente,
    required TipoDeParentesco tipoDeParentesco,
    required TemConhecidosNaEmpresa temConhecidosNaEmpresa,
    required NomesDasPessoasConhecidas nomesDasPessoasConhecidas,
    required AutoDescricaoDaPersonalidade autoDescricaoDaPersonalidade,
    required MotivacaoParaTrabalharNaEmpresa motivacaoParaTrabalharNaEmpresa,
    required OutrasInformacoesPessoais outrasInformacoesPessoais,
    required FacebookUrl facebookUrl,
    required InstagramUrl instagramUrl,
    required TwitterUrl twitterUrl,
    required LinkedInUrl linkedInUrl,
    required GitHubUrl gitHubUrl,
    String? photoUrl,
  }) = _Data;

  factory Candidato.empty() => _Data(
        id: UniqueId(),
        nomeCompleto: NomeCompleto.empty(),
        dataDeNascimento: DataDeNascimento.empty(),
        genero: Genero.empty(),
        profissao: Profissao.empty(),
        endereco: Endereco.empty(),
        bairro: Bairro.empty(),
        cidade: Cidade.empty(),
        uf: UnidadeFederativaDoBrasil.empty(),
        cep: Cep.empty(),
        telefonePrincipal: TelefonePrincipal.empty(),
        telefoneAlternativo: TelefoneAlternativo.empty(),
        categoriasCnh: CategoriasCnh.empty(),
        veiculoAutomotorProprio: VeiculoAutomotorProprio.empty(),
        estadoCivil: EstadoCivil.empty(),
        numeroDeFilhos: NumeroDeFilhos.empty(),
        conjuge: Conjuge.empty(),
        portadorDeNecessidadesEspeciais:
            PortadorDeNecessidadesEspeciais.empty(),
        necessidadesEspeciais: NecessidadesEspeciais.empty(),
        temParentesNaEmpresa: TemParentesNaEmpresa.empty(),
        nomeDoParente: NomeDoParente.empty(),
        tipoDeParentesco: TipoDeParentesco.empty(),
        temConhecidosNaEmpresa: TemConhecidosNaEmpresa.empty(),
        nomesDasPessoasConhecidas: NomesDasPessoasConhecidas.empty(),
        autoDescricaoDaPersonalidade: AutoDescricaoDaPersonalidade.empty(),
        motivacaoParaTrabalharNaEmpresa:
            MotivacaoParaTrabalharNaEmpresa.empty(),
        outrasInformacoesPessoais: OutrasInformacoesPessoais.empty(),
        facebookUrl: FacebookUrl.empty(),
        instagramUrl: InstagramUrl.empty(),
        twitterUrl: TwitterUrl.empty(),
        linkedInUrl: LinkedInUrl.empty(),
        gitHubUrl: GitHubUrl.empty(),
      );

  bool get conjugeIsOptional =>
      estadoCivil.getOrNull() != EstadoCivilEnum.casado;

  bool get necessidadesEspeciaisIsOptional =>
      !portadorDeNecessidadesEspeciais.getOrElse(false);

  bool get nomeDoParenteIsOptional => temParentesNaEmpresa.getOrElse(false);

  bool get tipoDeParentescoIsOptional => temParentesNaEmpresa.getOrElse(false);

  bool get nomesDasPessoasConhecidasIsOptional =>
      temConhecidosNaEmpresa.getOrElse(false);

  Candidato updateNomeCompleto(String input) {
    return copyWith(nomeCompleto: NomeCompleto(input));
  }

  Candidato updateDataDeNascimento(DateTime input) {
    return copyWith(dataDeNascimento: DataDeNascimento(input));
  }

  Candidato updateGenero(GeneroEnum? input) {
    return copyWith(
      genero: Genero(input),
    );
  }

  Candidato updateEstadoCivil(EstadoCivilEnum input) {
    return copyWith(
      estadoCivil: EstadoCivil(input),
    );
  }

  Candidato updateProfissao(String input) {
    return copyWith(profissao: Profissao(input));
  }

  Candidato updateEndereco(String input) {
    return copyWith(endereco: Endereco(input));
  }

  Candidato updateBairro(String input) {
    return copyWith(bairro: Bairro(input));
  }

  Candidato updateCidade(String input) {
    return copyWith(cidade: Cidade(input));
  }

  Candidato updateUf(UnidadeFederativaDoBrasilEnum input) {
    return copyWith(uf: UnidadeFederativaDoBrasil(input));
  }

  Candidato updateCep(String input) {
    return copyWith(cep: Cep(input));
  }

  Candidato updateTelefonePrincipal(String input) {
    return copyWith(telefonePrincipal: TelefonePrincipal(input));
  }

  Candidato updateTelefoneAlternativo(String input) {
    return copyWith(telefoneAlternativo: TelefoneAlternativo(input));
  }

  Candidato updateCategoriasCnh(Map<String, bool> input) {
    return copyWith(categoriasCnh: CategoriasCnh(input));
  }

  Candidato updateVeiculoAutomotorProprio(VeiculoAutomotorProprioEnum input) {
    return copyWith(veiculoAutomotorProprio: VeiculoAutomotorProprio(input));
  }

  Candidato updateConjuge(String input) {
    return copyWith(conjuge: Conjuge(input));
  }

  Candidato updateNumeroDeFilhos(String input) {
    return copyWith(numeroDeFilhos: NumeroDeFilhos.fromString(input));
  }

  Candidato updatePortadorDeNecessidadesEspeciais(bool input) {
    return copyWith(
      portadorDeNecessidadesEspeciais: PortadorDeNecessidadesEspeciais(input),
    );
  }

  Candidato updateNecessidadesEspeciais(String input) {
    return copyWith(necessidadesEspeciais: NecessidadesEspeciais(input));
  }

  Candidato updateTemParentesNaEmpresa(bool input) {
    return copyWith(
      temParentesNaEmpresa: TemParentesNaEmpresa(input),
    );
  }

  Candidato updateNomeDoParente(String input) {
    return copyWith(nomeDoParente: NomeDoParente(input));
  }

  Candidato updateTipoDeParentesco(String input) {
    return copyWith(tipoDeParentesco: TipoDeParentesco(input));
  }

  Candidato updateTemConhecidosNaEmpresa(bool input) {
    return copyWith(
      temConhecidosNaEmpresa: TemConhecidosNaEmpresa(input),
    );
  }

  Candidato updateNomesDasPessoasConhecidas(String input) {
    return copyWith(
        nomesDasPessoasConhecidas: NomesDasPessoasConhecidas(input));
  }

  Candidato updateAutoDescricaoDaPersonalidade(String input) {
    return copyWith(
        autoDescricaoDaPersonalidade: AutoDescricaoDaPersonalidade(input));
  }

  Candidato updateMotivacaoParaTrabalharNaEmpresa(String input) {
    return copyWith(
        motivacaoParaTrabalharNaEmpresa:
            MotivacaoParaTrabalharNaEmpresa(input));
  }

  Candidato updateOutrasInformacoesPessoais(String input) {
    return copyWith(
        outrasInformacoesPessoais: OutrasInformacoesPessoais(input));
  }

  Candidato updateFacebookUrl(String input) {
    return copyWith(facebookUrl: FacebookUrl(input));
  }

  Candidato updateInstagramUrl(String input) {
    return copyWith(instagramUrl: InstagramUrl(input));
  }

  Candidato updateTwitterUrl(String input) {
    return copyWith(twitterUrl: TwitterUrl(input));
  }

  Candidato updateLinkedInUrl(String input) {
    return copyWith(linkedInUrl: LinkedInUrl(input));
  }

  Candidato updateGitHubUrl(String input) {
    return copyWith(gitHubUrl: GitHubUrl(input));
  }

  Candidato updatePhotoUrl(String? input) {
    return copyWith(photoUrl: input);
  }

  bool isValid() {
    return nomeCompleto.isValid() &&
        dataDeNascimento.isValid() &&
        genero.isValid() &&
        profissao.isValid() &&
        endereco.isValid() &&
        bairro.isValid() &&
        cidade.isValid() &&
        uf.isValid() &&
        cep.isValid() &&
        telefonePrincipal.isValid() &&
        telefoneAlternativo.isValid() &&
        categoriasCnh.isValid() &&
        veiculoAutomotorProprio.isValid() &&
        estadoCivil.isValid() &&
        numeroDeFilhos.isValid() &&
        conjuge.isValid() &&
        portadorDeNecessidadesEspeciais.isValid() &&
        necessidadesEspeciais.isValid() &&
        temParentesNaEmpresa.isValid() &&
        nomeDoParente.isValid() &&
        tipoDeParentesco.isValid() &&
        temConhecidosNaEmpresa.isValid() &&
        nomesDasPessoasConhecidas.isValid() &&
        autoDescricaoDaPersonalidade.isValid() &&
        motivacaoParaTrabalharNaEmpresa.isValid() &&
        outrasInformacoesPessoais.isValid() &&
        facebookUrl.isValid() &&
        instagramUrl.isValid() &&
        twitterUrl.isValid() &&
        linkedInUrl.isValid() &&
        gitHubUrl.isValid();
  }
}
