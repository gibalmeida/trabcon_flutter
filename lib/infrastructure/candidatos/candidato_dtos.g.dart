// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'candidato_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CandidatoDto _$$_CandidatoDtoFromJson(Map<String, dynamic> json) =>
    _$_CandidatoDto(
      nomeCompleto: json['nomeCompleto'] as String,
      dataDeNascimento: DateTime.parse(json['dataDeNascimento'] as String),
      genero: $enumDecode(_$GeneroEnumEnumMap, json['genero']),
      profissao: json['profissao'] as String,
      endereco: json['endereco'] as String,
      bairro: json['bairro'] as String,
      cidade: json['cidade'] as String,
      uf: $enumDecode(_$UnidadeFederativaDoBrasilEnumEnumMap, json['uf']),
      cep: json['cep'] as String,
      telefonePrincipal: json['telefonePrincipal'] as String,
      telefoneAlternativo: json['telefoneAlternativo'] as String?,
      categoriasCnh: Map<String, bool>.from(json['categoriasCnh'] as Map),
      veiculoAutomotorProprio: $enumDecode(_$VeiculoAutomotorProprioEnumEnumMap,
          json['veiculoAutomotorProprio']),
      estadoCivil: $enumDecode(_$EstadoCivilEnumEnumMap, json['estadoCivil']),
      numeroDeFilhos: json['numeroDeFilhos'] as int,
      conjuge: json['conjuge'] as String?,
      portadorDeNecessidadesEspeciais:
          json['portadorDeNecessidadesEspeciais'] as bool,
      necessidadesEspeciais: json['necessidadesEspeciais'] as String?,
      temParentesNaEmpresa: json['temParentesNaEmpresa'] as bool,
      nomeDoParente: json['nomeDoParente'] as String?,
      tipoDeParentesco: json['tipoDeParentesco'] as String?,
      temConhecidosNaEmpresa: json['temConhecidosNaEmpresa'] as bool,
      nomesDasPessoasConhecidas: json['nomesDasPessoasConhecidas'] as String?,
      autoDescricaoDaPersonalidade:
          json['autoDescricaoDaPersonalidade'] as String,
      motivacaoParaTrabalharNaEmpresa:
          json['motivacaoParaTrabalharNaEmpresa'] as String,
      outrasInformacoesPessoais: json['outrasInformacoesPessoais'] as String?,
      facebookUrl: json['facebookUrl'] as String?,
      instagramUrl: json['instagramUrl'] as String?,
      twitterUrl: json['twitterUrl'] as String?,
      linkedInUrl: json['linkedInUrl'] as String?,
      gitHubUrl: json['gitHubUrl'] as String?,
    );

Map<String, dynamic> _$$_CandidatoDtoToJson(_$_CandidatoDto instance) =>
    <String, dynamic>{
      'nomeCompleto': instance.nomeCompleto,
      'dataDeNascimento': instance.dataDeNascimento.toIso8601String(),
      'genero': _$GeneroEnumEnumMap[instance.genero],
      'profissao': instance.profissao,
      'endereco': instance.endereco,
      'bairro': instance.bairro,
      'cidade': instance.cidade,
      'uf': _$UnidadeFederativaDoBrasilEnumEnumMap[instance.uf],
      'cep': instance.cep,
      'telefonePrincipal': instance.telefonePrincipal,
      'telefoneAlternativo': instance.telefoneAlternativo,
      'categoriasCnh': instance.categoriasCnh,
      'veiculoAutomotorProprio': _$VeiculoAutomotorProprioEnumEnumMap[
          instance.veiculoAutomotorProprio],
      'estadoCivil': _$EstadoCivilEnumEnumMap[instance.estadoCivil],
      'numeroDeFilhos': instance.numeroDeFilhos,
      'conjuge': instance.conjuge,
      'portadorDeNecessidadesEspeciais':
          instance.portadorDeNecessidadesEspeciais,
      'necessidadesEspeciais': instance.necessidadesEspeciais,
      'temParentesNaEmpresa': instance.temParentesNaEmpresa,
      'nomeDoParente': instance.nomeDoParente,
      'tipoDeParentesco': instance.tipoDeParentesco,
      'temConhecidosNaEmpresa': instance.temConhecidosNaEmpresa,
      'nomesDasPessoasConhecidas': instance.nomesDasPessoasConhecidas,
      'autoDescricaoDaPersonalidade': instance.autoDescricaoDaPersonalidade,
      'motivacaoParaTrabalharNaEmpresa':
          instance.motivacaoParaTrabalharNaEmpresa,
      'outrasInformacoesPessoais': instance.outrasInformacoesPessoais,
      'facebookUrl': instance.facebookUrl,
      'instagramUrl': instance.instagramUrl,
      'twitterUrl': instance.twitterUrl,
      'linkedInUrl': instance.linkedInUrl,
      'gitHubUrl': instance.gitHubUrl,
    };

const _$GeneroEnumEnumMap = {
  GeneroEnum.masculino: 'Masculino',
  GeneroEnum.feminino: 'Feminino',
};

const _$UnidadeFederativaDoBrasilEnumEnumMap = {
  UnidadeFederativaDoBrasilEnum.acre: 'AC',
  UnidadeFederativaDoBrasilEnum.alagoas: 'AL',
  UnidadeFederativaDoBrasilEnum.amapa: 'AP',
  UnidadeFederativaDoBrasilEnum.amazonas: 'AM',
  UnidadeFederativaDoBrasilEnum.bahia: 'BA',
  UnidadeFederativaDoBrasilEnum.ceara: 'CE',
  UnidadeFederativaDoBrasilEnum.distritoFederal: 'DF',
  UnidadeFederativaDoBrasilEnum.espiritoSanto: 'ES',
  UnidadeFederativaDoBrasilEnum.goias: 'GO',
  UnidadeFederativaDoBrasilEnum.maranhao: 'MA',
  UnidadeFederativaDoBrasilEnum.matoGrosso: 'MT',
  UnidadeFederativaDoBrasilEnum.matoGrossoDoSul: 'MS',
  UnidadeFederativaDoBrasilEnum.minasGerais: 'MG',
  UnidadeFederativaDoBrasilEnum.para: 'PA',
  UnidadeFederativaDoBrasilEnum.paraiba: 'PB',
  UnidadeFederativaDoBrasilEnum.parana: 'PR',
  UnidadeFederativaDoBrasilEnum.pernambuco: 'PE',
  UnidadeFederativaDoBrasilEnum.piaui: 'PI',
  UnidadeFederativaDoBrasilEnum.rioDeJaneiro: 'RJ',
  UnidadeFederativaDoBrasilEnum.rioGrandeDoNorte: 'RN',
  UnidadeFederativaDoBrasilEnum.rioGrandeDoSul: 'RS',
  UnidadeFederativaDoBrasilEnum.rondonia: 'RO',
  UnidadeFederativaDoBrasilEnum.roraima: 'RR',
  UnidadeFederativaDoBrasilEnum.santaCatarina: 'SC',
  UnidadeFederativaDoBrasilEnum.saoPaulo: 'SP',
  UnidadeFederativaDoBrasilEnum.sergipe: 'SE',
  UnidadeFederativaDoBrasilEnum.tocantins: 'TO',
};

const _$VeiculoAutomotorProprioEnumEnumMap = {
  VeiculoAutomotorProprioEnum.naoPossuoVeiculoAutomotor: 'Não possui',
  VeiculoAutomotorProprioEnum.simCarro: 'Carro',
  VeiculoAutomotorProprioEnum.simMoto: 'Moto',
  VeiculoAutomotorProprioEnum.simCarroEMoto: 'Carro e Moto',
  VeiculoAutomotorProprioEnum.simOutro: 'Outro',
};

const _$EstadoCivilEnumEnumMap = {
  EstadoCivilEnum.solteiro: 'Solteiro',
  EstadoCivilEnum.casado: 'Casado',
  EstadoCivilEnum.separado: 'Separado',
  EstadoCivilEnum.divorciado: 'Divorciado',
};
