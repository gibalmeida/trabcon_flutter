enum EstadoCivilEnum {
  solteiro,
  casado,
  separado,
  divorciado,
}

extension EstadoCivilEnumX on EstadoCivilEnum {
  String toStringCapitalized() {
    String option = toString().split('.').last;
    return "${option[0].toUpperCase()}${option.substring(1).toLowerCase()}";
  }
}

enum GeneroEnum {
  masculino,
  feminino,
}

extension GeneroEnumX on GeneroEnum {
  String toStringCapitalized() {
    String option = toString().split('.').last;
    return "${option[0].toUpperCase()}${option.substring(1).toLowerCase()}";
  }
}

enum VeiculoAutomotorProprioEnum {
  naoPossuoVeiculoAutomotor,
  simCarro,
  simMoto,
  simCarroEMoto,
  simOutro,
}

extension VeiculoAutomotorProprioEnumX on VeiculoAutomotorProprioEnum {
  String toStringCapitalized() {
    switch (this) {
      case VeiculoAutomotorProprioEnum.naoPossuoVeiculoAutomotor:
        return 'Não possuo veículo automotor';
      case VeiculoAutomotorProprioEnum.simCarro:
        return 'Sim, Carro';
      case VeiculoAutomotorProprioEnum.simMoto:
        return 'Sim, Moto';
      case VeiculoAutomotorProprioEnum.simCarroEMoto:
        return 'Sim, Carro e Moto';
      case VeiculoAutomotorProprioEnum.simOutro:
        return 'Sim, Outro';
    }
  }

  String toShortCode() {
    switch (this) {
      case VeiculoAutomotorProprioEnum.naoPossuoVeiculoAutomotor:
        return 'NP';
      case VeiculoAutomotorProprioEnum.simCarro:
        return 'CA';
      case VeiculoAutomotorProprioEnum.simMoto:
        return 'MO';
      case VeiculoAutomotorProprioEnum.simCarroEMoto:
        return 'CM';
      case VeiculoAutomotorProprioEnum.simOutro:
        return 'OT';
    }
  }
}

enum UnidadeFederativaDoBrasilEnum {
  acre,
  alagoas,
  amapa,
  amazonas,
  bahia,
  ceara,
  distritoFederal,
  espiritoSanto,
  goias,
  maranhao,
  matoGrosso,
  matoGrossoDoSul,
  minasGerais,
  para,
  paraiba,
  parana,
  pernambuco,
  piaui,
  rioDeJaneiro,
  rioGrandeDoNorte,
  rioGrandeDoSul,
  rondonia,
  roraima,
  santaCatarina,
  saoPaulo,
  sergipe,
  tocantins,
}

extension UnidadeFederativaDoBrasilEnumX on UnidadeFederativaDoBrasilEnum {
  String toStringCapitalized() {
    switch (this) {
      case UnidadeFederativaDoBrasilEnum.acre:
        return 'Acre';
      case UnidadeFederativaDoBrasilEnum.alagoas:
        return 'Alagoas';
      case UnidadeFederativaDoBrasilEnum.amapa:
        return 'Amapá';
      case UnidadeFederativaDoBrasilEnum.amazonas:
        return 'Amazonas';
      case UnidadeFederativaDoBrasilEnum.bahia:
        return 'Bahia';
      case UnidadeFederativaDoBrasilEnum.ceara:
        return 'Ceará';
      case UnidadeFederativaDoBrasilEnum.distritoFederal:
        return 'Distrito Federal';
      case UnidadeFederativaDoBrasilEnum.espiritoSanto:
        return 'Espírito Santo';
      case UnidadeFederativaDoBrasilEnum.goias:
        return 'Goiás';
      case UnidadeFederativaDoBrasilEnum.maranhao:
        return 'Maranhão';
      case UnidadeFederativaDoBrasilEnum.matoGrosso:
        return 'Mato Grosso';
      case UnidadeFederativaDoBrasilEnum.matoGrossoDoSul:
        return 'Mato Grosso do Sul';
      case UnidadeFederativaDoBrasilEnum.minasGerais:
        return 'Minas Gerais';
      case UnidadeFederativaDoBrasilEnum.para:
        return 'Pará';
      case UnidadeFederativaDoBrasilEnum.paraiba:
        return 'Paraíba';
      case UnidadeFederativaDoBrasilEnum.parana:
        return 'Paraná';
      case UnidadeFederativaDoBrasilEnum.pernambuco:
        return 'Pernambuco';
      case UnidadeFederativaDoBrasilEnum.piaui:
        return 'Piauí';
      case UnidadeFederativaDoBrasilEnum.rioDeJaneiro:
        return 'Rio de Janeiro';
      case UnidadeFederativaDoBrasilEnum.rioGrandeDoNorte:
        return 'Rio Grande do Norte';
      case UnidadeFederativaDoBrasilEnum.rioGrandeDoSul:
        return 'Rio Grande do Sul';
      case UnidadeFederativaDoBrasilEnum.rondonia:
        return 'Rondônia';
      case UnidadeFederativaDoBrasilEnum.roraima:
        return 'Roraíma';
      case UnidadeFederativaDoBrasilEnum.santaCatarina:
        return 'Santa Catarina';
      case UnidadeFederativaDoBrasilEnum.saoPaulo:
        return 'São Paulo';
      case UnidadeFederativaDoBrasilEnum.sergipe:
        return 'Sergipe';
      case UnidadeFederativaDoBrasilEnum.tocantins:
        return 'Tocantins';
    }
  }

  String toShortCode() {
    switch (this) {
      case UnidadeFederativaDoBrasilEnum.acre:
        return 'AC';
      case UnidadeFederativaDoBrasilEnum.alagoas:
        return 'AL';
      case UnidadeFederativaDoBrasilEnum.amapa:
        return 'AP';
      case UnidadeFederativaDoBrasilEnum.amazonas:
        return 'AM';
      case UnidadeFederativaDoBrasilEnum.bahia:
        return 'BA';
      case UnidadeFederativaDoBrasilEnum.ceara:
        return 'CE';
      case UnidadeFederativaDoBrasilEnum.distritoFederal:
        return 'DF';
      case UnidadeFederativaDoBrasilEnum.espiritoSanto:
        return 'ES';
      case UnidadeFederativaDoBrasilEnum.goias:
        return 'GO';
      case UnidadeFederativaDoBrasilEnum.maranhao:
        return 'MA';
      case UnidadeFederativaDoBrasilEnum.matoGrosso:
        return 'MT';
      case UnidadeFederativaDoBrasilEnum.matoGrossoDoSul:
        return 'MS';
      case UnidadeFederativaDoBrasilEnum.minasGerais:
        return 'MG';
      case UnidadeFederativaDoBrasilEnum.para:
        return 'PA';
      case UnidadeFederativaDoBrasilEnum.paraiba:
        return 'PB';
      case UnidadeFederativaDoBrasilEnum.parana:
        return 'PR';
      case UnidadeFederativaDoBrasilEnum.pernambuco:
        return 'PE';
      case UnidadeFederativaDoBrasilEnum.piaui:
        return 'PI';
      case UnidadeFederativaDoBrasilEnum.rioDeJaneiro:
        return 'RJ';
      case UnidadeFederativaDoBrasilEnum.rioGrandeDoNorte:
        return 'RN';
      case UnidadeFederativaDoBrasilEnum.rioGrandeDoSul:
        return 'RS';
      case UnidadeFederativaDoBrasilEnum.rondonia:
        return 'RO';
      case UnidadeFederativaDoBrasilEnum.roraima:
        return 'RR';
      case UnidadeFederativaDoBrasilEnum.santaCatarina:
        return 'SC';
      case UnidadeFederativaDoBrasilEnum.saoPaulo:
        return 'SP';
      case UnidadeFederativaDoBrasilEnum.sergipe:
        return 'SE';
      case UnidadeFederativaDoBrasilEnum.tocantins:
        return 'TO';
    }
  }
}
