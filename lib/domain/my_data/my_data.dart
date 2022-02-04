import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trabcon_flutter/domain/my_data/value_objects.dart';

part 'my_data.freezed.dart';

@freezed
class MyData with _$MyData {
  const MyData._();
  const factory MyData({
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
  }) = _Data;

  factory MyData.empty() => _Data(
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
}

// static const cannotBeEmpty = 'O preenchimento deste campo é obrigatório.';

  // setNomeCompleto(String value) {
  //   state = state.copyWith(nomeCompleto: value);
  // }

  // String validateNomeCompleto(String value) {
  //   if (value != null && value.isEmpty) {
  //     return cannotBeEmpty;
  //   }
  // }

  // setDataDeNascimento(String value) {
  //   state = state.copyWith(dataDeNascimento: value);
  // }

  // String validateDataDeNascimento(String value) {
  //   if (value != null && value.isEmpty) {
  //     return cannotBeEmpty;
  //   }
  // }

  // setGenero(Genero value) {
  //   state = state.copyWith(genero: value);
  // }

  // setProfissao(String value) {
  //   state = state.copyWith(profissao: value);
  // }

  // String validateProfissao(String value) {
  //   if (value != null && value.isEmpty) {
  //     return cannotBeEmpty;
  //   }
  // }

  // setEndereco(String value) {
  //   state = state.copyWith(endereco: value);
  // }

  // String validateEndereco(String value) {
  //   if (value != null && value.isEmpty) {
  //     return cannotBeEmpty;
  //   }
  // }

  // setBairro(String value) {
  //   state = state.copyWith(bairro: value);
  // }

  // String validateBairro(String value) {
  //   if (value != null && value.isEmpty) {
  //     return cannotBeEmpty;
  //   }
  // }

  // setCidade(String value) {
  //   state = state.copyWith(cidade: value);
  // }

  // String validateCidade(String value) {
  //   if (value != null && value.isEmpty) {
  //     return cannotBeEmpty;
  //   }
  // }

  // setUf(String value) {
  //   state = state.copyWith(uf: value);
  // }

  // String validateUf(String value) {
  //   if (value != null && value.isEmpty) {
  //     return cannotBeEmpty;
  //   }
  // }

  // setCep(String value) {
  //   state = state.copyWith(cep: value);
  // }

  // String validateCep(String value) {
  //   if (value != null && value.isEmpty) {
  //     return cannotBeEmpty;
  //   }
  // }

  // setTelefonePrincipal(String value) {
  //   state = state.copyWith(telefonePrincipal: value);
  // }

  // String validateTelefonePrincipal(String value) {
  //   // TODO; implementar validação de número de telefone
  //   if (value != null && value.isEmpty) {
  //     return cannotBeEmpty;
  //   }
  // }

  // setTelefoneAlternativo(String value) {
  //   state = state.copyWith(telefoneAlternativo: value);
  // }

  // String validateTelefoneAlternativo(String value) {
  //   // TODO; implementar validação de número de telefone
  // }

  // setCategoriasCnh(List<String> value) {
  //   state = state.copyWith(categoriasCnh: value);
  // }

  // String validateCategoriasCnh(List<String> value) {
  //   if (value != null && value.isEmpty) {
  //     return cannotBeEmpty;
  //   }
  // }

  // setVeiculoAutomotorProprio(value) {
  //   state = state.copyWith(veiculoAutomotorProprio: value);
  // }

  // String validateVeiculoAutomotorProprio(String value) {
  //   if (value != null && value.isEmpty) {
  //     return cannotBeEmpty;
  //   }
  // }

  // setEstadoCivil(EstadoCivil value) {
  //   state = state.copyWith(estadoCivil: value);
  // }

  // String validateEstadoCivil(String value) {
  //   if (value != null && value.isEmpty) {
  //     return cannotBeEmpty;
  //   }
  // }

  // setNumeroDeFilhos(int value) {
  //   state = state.copyWith(numeroDeFilhos: value);
  // }

  // String validateNumeroDeFilhos(String value) {
  //   try {
  //     if (value != null) {
  //       int _ = int.parse(value);
  //     }
  //     if (value != null && value.isEmpty) {
  //       return cannotBeEmpty;
  //     }
  //   } on FormatException {
  //     return 'Informe um número válido para este campo.';
  //   }
  // }

  // setConjuge(String value) {
  //   state = state.copyWith(conjuge: value);
  // }

  // String validateConjuge(String value) {
  //   if (value != null &&
  //       state.estadoCivil == EstadoCivil.casado &&
  //       value.isEmpty) {
  //     return cannotBeEmpty;
  //   }
  // }

  // setPortadorDeNecessidadesEspeciais(bool value) {
  //   state = state.copyWith(portadorDeNecessidadesEspeciais: value);
  // }

  // setNecessidadesEspeciais(String value) {
  //   state = state.copyWith(necessidadesEspeciais: value);
  // }

  // String validateNecessidadesEspeciais(String value) {
  //   if (value != null &&
  //       state.portadorDeNecessidadesEspeciais &&
  //       value.isEmpty) {
  //     return cannotBeEmpty;
  //   }
  // }

  // setTemParentesNaEmpresa(bool value) {
  //   state = state.copyWith(temParentesNaEmpresa: value);
  // }

  // setNomeDoParente(String value) {
  //   state = state.copyWith(nomeDoParente: value);
  // }

  // String validateNomeDoParente(String value) {
  //   if (value != null && state.temParentesNaEmpresa && value.isEmpty) {
  //     return cannotBeEmpty;
  //   }
  // }

  // setTipoDeParentesco(value) {
  //   state = state.copyWith(tipoDeParentesco: value);
  // }

  // String validateTipoDeParentesco(String value) {
  //   if (value != null && state.temParentesNaEmpresa && value.isEmpty) {
  //     return cannotBeEmpty;
  //   }
  // }

  // setTemConhecidosNaEmpresa(bool value) {
  //   state = state.copyWith(temConhecidosNaEmpresa: value);
  // }

  // setNomeDasPessoasConhecidas(value) {
  //   state = state.copyWith(nomesDasPessoasConhecidas: value);
  // }

  // String validateNomeDasPessoasConhecidas(String value) {
  //   if (value != null && state.temConhecidosNaEmpresa && value.isEmpty) {
  //     return cannotBeEmpty;
  //   }
  // }

  // setAutoDescricaoDaPersonalidade(String value) {
  //   state = state.copyWith(autoDescricaoDaPersonalidade: value);
  // }

  // String validateAutoDescricaoDaPersonalidade(String value) {
  //   if (value != null && value.isEmpty) {
  //     return cannotBeEmpty;
  //   }
  // }

  // setMotivaParaTrabalharNaEmpresa(String value) {
  //   state = state.copyWith(motivacaoParaTrabalharNaEmpresa: value);
  // }

  // String validateMotivoParaTrabalharNaEmpresa(String value) {
  //   if (value != null && value.isEmpty) {
  //     return cannotBeEmpty;
  //   }
  // }

  // setOutrasInformacoesPessoais(String value) {
  //   state = state.copyWith(outrasInformacoesPessoais: value);
  // }

  // String validateOutrasInformacoesPessoais(String value) {}

  // setFacebookUrl(String value) {
  //   state = state.copyWith(facebookUrl: value);
  // }

  // String validateFacebookUrl(String value) {}

  // setInstagramUrl(String value) {
  //   state = state.copyWith(instagramUrl: value);
  // }

  // String validateInstagramUrl(String value) {}

  // setTwitterUrl(String value) {
  //   state = state.copyWith(twitterUrl: value);
  // }

  // String validateTwitterUrl(String value) {}

  // setLinkedInUrl(String value) {
  //   state = state.copyWith(linkedInUrl: value);
  // }

  // String validateLinkedInUrl(String value) {}

  // setGitHubUrl(value) {
  //   state = state.copyWith(gitHubUrl: value);
  // }

  // String validateGitHubUrl(String value) {}

  // bool isCasado() {
  //   return state.estadoCivil == EstadoCivil.casado;
  // }

  // String labelForConjuge() {
  //   switch (state.genero) {
  //     case Genero.masculino:
  //       return 'Nome da esposa';
  //     case Genero.feminino:
  //       return 'Nome do marido';
  //     default:
  //       return 'Nome do Conjuge';
  //   }
  // }