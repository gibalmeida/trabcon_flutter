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
