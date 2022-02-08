import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trabcon_flutter/domain/candidatos/candidato.dart';
import 'package:trabcon_flutter/domain/candidatos/value_objects.dart';
import 'package:trabcon_flutter/domain/core/enums.dart';
import 'package:trabcon_flutter/domain/core/value_objects.dart';

part 'candidato_dtos.freezed.dart';
part 'candidato_dtos.g.dart';

@freezed
class CandidatoDto with _$CandidatoDto {
  factory CandidatoDto({
    @JsonKey(ignore: true) @Default('') String id,
    required String nomeCompleto,
    required DateTime dataDeNascimento,
    required GeneroEnum genero,
    required String profissao,
    required String endereco,
    required String bairro,
    required String cidade,
    required UnidadeFederativaDoBrasilEnum uf,
    required String cep,
    required String telefonePrincipal,
    String? telefoneAlternativo,
    required Map<String, bool> categoriasCnh,
    required VeiculoAutomotorProprioEnum veiculoAutomotorProprio,
    required EstadoCivilEnum estadoCivil,
    required int numeroDeFilhos,
    String? conjuge,
    required bool portadorDeNecessidadesEspeciais,
    String? necessidadesEspeciais,
    required bool temParentesNaEmpresa,
    String? nomeDoParente,
    String? tipoDeParentesco,
    required bool temConhecidosNaEmpresa,
    String? nomesDasPessoasConhecidas,
    required String autoDescricaoDaPersonalidade,
    required String motivacaoParaTrabalharNaEmpresa,
    String? outrasInformacoesPessoais,
    String? facebookUrl,
    String? instagramUrl,
    String? twitterUrl,
    String? linkedInUrl,
    String? gitHubUrl,
  }) = _CandidatoDto;

  factory CandidatoDto.fromJson(Map<String, dynamic> json) =>
      _$CandidatoDtoFromJson(json);

  factory CandidatoDto.fromDomain(Candidato candidato) {
    return CandidatoDto(
      id: candidato.id.getOrCrash(),
      nomeCompleto: candidato.nomeCompleto.getOrCrash(),
      dataDeNascimento: candidato.dataDeNascimento.getOrCrash(),
      genero: candidato.genero.getOrCrash(),
      profissao: candidato.profissao.getOrCrash(),
      endereco: candidato.endereco.getOrCrash(),
      bairro: candidato.bairro.getOrCrash(),
      cidade: candidato.cidade.getOrCrash(),
      uf: candidato.uf.getOrCrash(),
      cep: candidato.cep.getOrCrash(),
      telefonePrincipal: candidato.telefonePrincipal.getOrCrash(),
      telefoneAlternativo: candidato.telefoneAlternativo.getOrCrash(),
      categoriasCnh: candidato.categoriasCnh.getOrCrash(),
      veiculoAutomotorProprio: candidato.veiculoAutomotorProprio.getOrCrash(),
      estadoCivil: candidato.estadoCivil.getOrCrash(),
      conjuge: candidato.conjuge.getOrCrash(),
      numeroDeFilhos: candidato.numeroDeFilhos.getOrCrash(),
      portadorDeNecessidadesEspeciais:
          candidato.portadorDeNecessidadesEspeciais.getOrCrash(),
      necessidadesEspeciais: candidato.necessidadesEspeciais.getOrCrash(),
      temParentesNaEmpresa: candidato.temParentesNaEmpresa.getOrCrash(),
      nomeDoParente: candidato.nomeDoParente.getOrCrash(),
      tipoDeParentesco: candidato.tipoDeParentesco.getOrCrash(),
      temConhecidosNaEmpresa: candidato.temConhecidosNaEmpresa.getOrCrash(),
      nomesDasPessoasConhecidas:
          candidato.nomesDasPessoasConhecidas.getOrCrash(),
      autoDescricaoDaPersonalidade:
          candidato.autoDescricaoDaPersonalidade.getOrCrash(),
      motivacaoParaTrabalharNaEmpresa:
          candidato.motivacaoParaTrabalharNaEmpresa.getOrCrash(),
      outrasInformacoesPessoais:
          candidato.outrasInformacoesPessoais.getOrCrash(),
      facebookUrl: candidato.facebookUrl.getOrCrash(),
      instagramUrl: candidato.instagramUrl.getOrCrash(),
      twitterUrl: candidato.twitterUrl.getOrCrash(),
      linkedInUrl: candidato.linkedInUrl.getOrCrash(),
      gitHubUrl: candidato.gitHubUrl.getOrCrash(),
    );
  }

  const CandidatoDto._();

  Candidato toDomain() {
    return Candidato(
      id: UniqueId.fromUniqueString(id),
      nomeCompleto: NomeCompleto(nomeCompleto),
      dataDeNascimento: DataDeNascimento(dataDeNascimento),
      genero: Genero(genero),
      profissao: Profissao(profissao),
      endereco: Endereco(endereco),
      bairro: Bairro(bairro),
      cidade: Cidade(cidade),
      uf: UnidadeFederativaDoBrasil(uf),
      cep: Cep(cep),
      telefonePrincipal: TelefonePrincipal(telefonePrincipal),
      telefoneAlternativo: TelefoneAlternativo(telefoneAlternativo ?? ''),
      categoriasCnh: CategoriasCnh(categoriasCnh),
      veiculoAutomotorProprio: VeiculoAutomotorProprio(veiculoAutomotorProprio),
      estadoCivil: EstadoCivil(estadoCivil),
      numeroDeFilhos: NumeroDeFilhos(numeroDeFilhos),
      conjuge: Conjuge(conjuge),
      portadorDeNecessidadesEspeciais:
          PortadorDeNecessidadesEspeciais(portadorDeNecessidadesEspeciais),
      necessidadesEspeciais: NecessidadesEspeciais(necessidadesEspeciais ?? ''),
      temParentesNaEmpresa: TemParentesNaEmpresa(temParentesNaEmpresa),
      nomeDoParente: NomeDoParente(nomeDoParente ?? ''),
      tipoDeParentesco: TipoDeParentesco(tipoDeParentesco),
      temConhecidosNaEmpresa: TemConhecidosNaEmpresa(temConhecidosNaEmpresa),
      nomesDasPessoasConhecidas:
          NomesDasPessoasConhecidas(nomesDasPessoasConhecidas),
      autoDescricaoDaPersonalidade:
          AutoDescricaoDaPersonalidade(autoDescricaoDaPersonalidade),
      motivacaoParaTrabalharNaEmpresa:
          MotivacaoParaTrabalharNaEmpresa(motivacaoParaTrabalharNaEmpresa),
      outrasInformacoesPessoais:
          OutrasInformacoesPessoais(outrasInformacoesPessoais ?? ''),
      facebookUrl: FacebookUrl(facebookUrl ?? ''),
      instagramUrl: InstagramUrl(instagramUrl ?? ''),
      twitterUrl: TwitterUrl(twitterUrl ?? ''),
      linkedInUrl: LinkedInUrl(linkedInUrl ?? ''),
      gitHubUrl: GitHubUrl(gitHubUrl ?? ''),
    );
  }
}
