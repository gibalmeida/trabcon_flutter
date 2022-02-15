import 'package:trabcon_flutter/domain/core/enums.dart';
import 'package:trabcon_flutter/domain/core/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:trabcon_flutter/domain/core/value_objects.dart';
import 'package:trabcon_flutter/domain/core/value_validators.dart';

class NomeCompleto extends ValueObject<String> {
  static const maxLength = 40;

  @override
  final Either<ValueFailure<String>, String> value;

  factory NomeCompleto(String input) {
    return NomeCompleto._(validateMaxStringLength(input, maxLength)
        .flatMap(validateStringNotEmpty));
  }

  factory NomeCompleto.empty() {
    return NomeCompleto('');
  }

  const NomeCompleto._(this.value);
}

class DataDeNascimento extends ValueObject<DateTime> {
  @override
  final Either<ValueFailure<DateTime?>, DateTime> value;

  factory DataDeNascimento(DateTime input) {
    return DataDeNascimento._(right(input));
  }

  factory DataDeNascimento.fromString(String input) {
    return DataDeNascimento._(
      validateDateFromString(input),
    );
  }

  factory DataDeNascimento.empty() {
    return DataDeNascimento._(
      left(
        const ValueFailure.empty(
          failedValue: null,
        ),
      ),
    );
  }

  const DataDeNascimento._(this.value);
}

class Genero extends ValueObject<GeneroEnum> {
  @override
  final Either<ValueFailure<GeneroEnum?>, GeneroEnum> value;

  factory Genero(GeneroEnum? input) {
    if (input == null) {
      return Genero.empty();
    } else {
      return Genero._(right(input));
    }
  }

  factory Genero.empty() {
    return Genero._(
      left(
        const ValueFailure.optionNotSelected(failedValue: null),
      ),
    );
  }

  const Genero._(this.value);
}

class EstadoCivil extends ValueObject<EstadoCivilEnum> {
  @override
  final Either<ValueFailure<EstadoCivilEnum?>, EstadoCivilEnum> value;

  factory EstadoCivil(EstadoCivilEnum input) {
    return EstadoCivil._(right(input));
  }

  factory EstadoCivil.empty() {
    return EstadoCivil._(
      left(
        const ValueFailure.optionNotSelected(
          failedValue: null,
        ),
      ),
    );
  }

  const EstadoCivil._(this.value);
}

class Profissao extends ValueObject<String> {
  static const maxLength = 40;

  @override
  final Either<ValueFailure<String>, String> value;

  factory Profissao(String input) {
    return Profissao._(validateMaxStringLength(input, maxLength)
        .flatMap(validateStringNotEmpty));
  }

  factory Profissao.empty() {
    return Profissao('');
  }

  const Profissao._(this.value);
}

class Endereco extends ValueObject<String> {
  static const maxLength = 40;

  @override
  final Either<ValueFailure<String>, String> value;

  factory Endereco(String input) {
    return Endereco._(validateMaxStringLength(input, maxLength)
        .flatMap(validateStringNotEmpty));
  }

  factory Endereco.empty() {
    return Endereco('');
  }

  const Endereco._(this.value);
}

class Bairro extends ValueObject<String> {
  static const maxLength = 40;

  @override
  final Either<ValueFailure<String>, String> value;

  factory Bairro(String input) {
    return Bairro._(validateMaxStringLength(input, maxLength)
        .flatMap(validateStringNotEmpty));
  }

  factory Bairro.empty() {
    return Bairro('');
  }

  const Bairro._(this.value);
}

class Cidade extends ValueObject<String> {
  static const maxLength = 40;

  @override
  final Either<ValueFailure<String>, String> value;

  factory Cidade(String input) {
    return Cidade._(validateMaxStringLength(input, maxLength)
        .flatMap(validateStringNotEmpty));
  }

  factory Cidade.empty() {
    return Cidade('');
  }

  const Cidade._(this.value);
}

class UnidadeFederativaDoBrasil
    extends ValueObject<UnidadeFederativaDoBrasilEnum> {
  @override
  final Either<ValueFailure<UnidadeFederativaDoBrasilEnum?>,
      UnidadeFederativaDoBrasilEnum> value;

  factory UnidadeFederativaDoBrasil(UnidadeFederativaDoBrasilEnum input) {
    return UnidadeFederativaDoBrasil._(right(input));
  }

  factory UnidadeFederativaDoBrasil.empty() {
    return UnidadeFederativaDoBrasil._(
      left(
        const ValueFailure.optionNotSelected(
          failedValue: null,
        ),
      ),
    );
  }

  const UnidadeFederativaDoBrasil._(this.value);
}

class Cep extends ValueObject<String> {
  static const maxLength = 10;

  @override
  final Either<ValueFailure<String>, String> value;

  factory Cep(String input) {
    return Cep._(validateMaxStringLength(input, maxLength)
        .flatMap(validateStringNotEmpty)
        .flatMap(validateCep));
  }

  factory Cep.empty() {
    return Cep('');
  }

  const Cep._(this.value);
}

class TelefonePrincipal extends ValueObject<String> {
  static const maxLength = 15;

  @override
  final Either<ValueFailure<String>, String> value;

  factory TelefonePrincipal(String input) {
    return TelefonePrincipal._(
      validateMaxStringLength(input, maxLength).flatMap(validateStringNotEmpty),
    );
  }

  factory TelefonePrincipal.empty() {
    return TelefonePrincipal('');
  }

  const TelefonePrincipal._(this.value);
}

class TelefoneAlternativo extends ValueObject<String> {
  static const maxLength = 15;

  @override
  final Either<ValueFailure<String>, String> value;

  factory TelefoneAlternativo(String input) {
    return TelefoneAlternativo._(validateMaxStringLength(input, maxLength));
  }

  factory TelefoneAlternativo.empty() {
    return TelefoneAlternativo('');
  }

  const TelefoneAlternativo._(this.value);
}

class VeiculoAutomotorProprio extends ValueObject<VeiculoAutomotorProprioEnum> {
  @override
  final Either<ValueFailure<VeiculoAutomotorProprioEnum?>,
      VeiculoAutomotorProprioEnum> value;

  factory VeiculoAutomotorProprio(VeiculoAutomotorProprioEnum input) {
    return VeiculoAutomotorProprio._(right(input));
  }

  factory VeiculoAutomotorProprio.empty() {
    return VeiculoAutomotorProprio._(
      left(
        const ValueFailure.optionNotSelected(
          failedValue: null,
        ),
      ),
    );
  }

  const VeiculoAutomotorProprio._(this.value);
}

class NumeroDeFilhos extends ValueObject<int> {
  static const numeroMinimoDeFilhos = 0;
  static const numeroMaximoDeFilhos = 50;
  @override
  final Either<ValueFailure<int?>, int> value;

  factory NumeroDeFilhos(int input) {
    return NumeroDeFilhos._(
      validateRange(
        input,
        numeroMinimoDeFilhos,
        numeroMaximoDeFilhos,
      ),
    );
  }

  factory NumeroDeFilhos.fromString(String input) {
    return NumeroDeFilhos._(
      validateInteger(input).flatMap(
        (input) => validateRange(
          input,
          numeroMinimoDeFilhos,
          numeroMaximoDeFilhos,
        ),
      ),
    );
  }

  factory NumeroDeFilhos.empty() {
    return NumeroDeFilhos._(
      left(
        const ValueFailure.empty(failedValue: 0),
      ),
    );
  }

  const NumeroDeFilhos._(this.value);
}

class Conjuge extends ValueObject<String?> {
  static const maxLength = 40;

  @override
  final Either<ValueFailure<String?>, String?> value;

  factory Conjuge(String? input) {
    if (input == null) {
      return Conjuge._(
        right(null),
      );
    } else {
      return Conjuge._(
        validateMaxStringLength(input, maxLength)
            .flatMap(validateStringNotEmpty),
      );
    }
  }

  factory Conjuge.empty() {
    return Conjuge('');
  }

  const Conjuge._(this.value);
}

class PortadorDeNecessidadesEspeciais extends ValueObject<bool> {
  @override
  final Either<ValueFailure<bool>, bool> value;

  int? get maxLength => null;

  factory PortadorDeNecessidadesEspeciais(bool input) {
    return PortadorDeNecessidadesEspeciais._(right(input));
  }

  factory PortadorDeNecessidadesEspeciais.empty() {
    return PortadorDeNecessidadesEspeciais(false);
  }

  const PortadorDeNecessidadesEspeciais._(this.value);
}

class NecessidadesEspeciais extends ValueObject<String?> {
  static const maxLength = 40;

  @override
  final Either<ValueFailure<String?>, String?> value;

  factory NecessidadesEspeciais(String? input) {
    if (input == null) {
      return NecessidadesEspeciais._(right(null));
    } else {
      return NecessidadesEspeciais._(
        validateMaxStringLength(input, maxLength)
            .flatMap(validateStringNotEmpty),
      );
    }
  }

  factory NecessidadesEspeciais.empty() {
    return NecessidadesEspeciais('');
  }

  const NecessidadesEspeciais._(
    this.value,
  );
}

class TemParentesNaEmpresa extends ValueObject<bool> {
  @override
  final Either<ValueFailure<bool>, bool> value;

  int? get maxLength => null;

  factory TemParentesNaEmpresa(bool input) {
    return TemParentesNaEmpresa._(right(input));
  }

  factory TemParentesNaEmpresa.empty() {
    return TemParentesNaEmpresa(false);
  }

  const TemParentesNaEmpresa._(this.value);
}

class NomeDoParente extends ValueObject<String?> {
  static const maxLength = 40;

  @override
  final Either<ValueFailure<String?>, String?> value;

  factory NomeDoParente(String? input) {
    if (input == null) {
      return NomeDoParente._(
        right(null),
      );
    } else {
      return NomeDoParente._(
        validateMaxStringLength(input, maxLength)
            .flatMap(validateStringNotEmpty),
      );
    }
  }

  factory NomeDoParente.empty() {
    return NomeDoParente('');
  }

  const NomeDoParente._(
    this.value,
  );
}

class TipoDeParentesco extends ValueObject<String?> {
  static const maxLength = 20;

  @override
  final Either<ValueFailure<String?>, String?> value;

  factory TipoDeParentesco(String? input) {
    if (input == null) {
      return TipoDeParentesco._(
        right(null),
      );
    } else {
      return TipoDeParentesco._(
        validateMaxStringLength(input, maxLength)
            .flatMap(validateStringNotEmpty),
      );
    }
  }

  factory TipoDeParentesco.empty() {
    return TipoDeParentesco(
      '',
    );
  }

  const TipoDeParentesco._(this.value);
}

class TemConhecidosNaEmpresa extends ValueObject<bool> {
  @override
  final Either<ValueFailure<bool>, bool> value;

  factory TemConhecidosNaEmpresa(bool input) {
    return TemConhecidosNaEmpresa._(right(input));
  }

  factory TemConhecidosNaEmpresa.empty() {
    return TemConhecidosNaEmpresa(false);
  }

  const TemConhecidosNaEmpresa._(this.value);
}

class NomesDasPessoasConhecidas extends ValueObject<String?> {
  static const maxLength = 40;

  @override
  final Either<ValueFailure<String?>, String?> value;

  factory NomesDasPessoasConhecidas(String? input) {
    if (input == null) {
      return NomesDasPessoasConhecidas._(
        right(null),
      );
    } else {
      return NomesDasPessoasConhecidas._(
        validateMaxStringLength(input, maxLength)
            .flatMap(validateStringNotEmpty),
      );
    }
  }

  factory NomesDasPessoasConhecidas.empty() {
    return NomesDasPessoasConhecidas(
      '',
    );
  }

  const NomesDasPessoasConhecidas._(
    this.value,
  );
}

class AutoDescricaoDaPersonalidade extends ValueObject<String> {
  static const maxLength = 500;

  @override
  final Either<ValueFailure<String>, String> value;

  factory AutoDescricaoDaPersonalidade(String input) {
    return AutoDescricaoDaPersonalidade._(
        validateMaxStringLength(input, maxLength)
            .flatMap(validateStringNotEmpty));
  }

  factory AutoDescricaoDaPersonalidade.empty() {
    return AutoDescricaoDaPersonalidade('');
  }

  const AutoDescricaoDaPersonalidade._(this.value);
}

class MotivacaoParaTrabalharNaEmpresa extends ValueObject<String> {
  static const maxLength = 500;

  @override
  final Either<ValueFailure<String>, String> value;

  factory MotivacaoParaTrabalharNaEmpresa(String input) {
    return MotivacaoParaTrabalharNaEmpresa._(
        validateMaxStringLength(input, maxLength)
            .flatMap(validateStringNotEmpty));
  }

  factory MotivacaoParaTrabalharNaEmpresa.empty() {
    return MotivacaoParaTrabalharNaEmpresa('');
  }

  const MotivacaoParaTrabalharNaEmpresa._(this.value);
}

class OutrasInformacoesPessoais extends ValueObject<String> {
  static const maxLength = 500;

  @override
  final Either<ValueFailure<String>, String> value;

  factory OutrasInformacoesPessoais(String input) {
    return OutrasInformacoesPessoais._(
        validateMaxStringLength(input, maxLength));
  }

  factory OutrasInformacoesPessoais.empty() {
    return OutrasInformacoesPessoais('');
  }

  const OutrasInformacoesPessoais._(this.value);
}

class FacebookUrl extends ValueObject<String> {
  static const maxLength = 30;

  @override
  final Either<ValueFailure<String>, String> value;

  factory FacebookUrl(String input) {
    return FacebookUrl._(validateMaxStringLength(input, maxLength));
  }

  factory FacebookUrl.empty() {
    return FacebookUrl('');
  }

  const FacebookUrl._(this.value);
}

class InstagramUrl extends ValueObject<String> {
  static const maxLength = 30;

  @override
  final Either<ValueFailure<String>, String> value;

  factory InstagramUrl(String input) {
    return InstagramUrl._(validateMaxStringLength(input, maxLength));
  }

  factory InstagramUrl.empty() {
    return InstagramUrl('');
  }

  const InstagramUrl._(this.value);
}

class TwitterUrl extends ValueObject<String> {
  static const maxLength = 30;

  @override
  final Either<ValueFailure<String>, String> value;

  factory TwitterUrl(String input) {
    return TwitterUrl._(validateMaxStringLength(input, maxLength));
  }

  factory TwitterUrl.empty() {
    return TwitterUrl('');
  }

  const TwitterUrl._(this.value);
}

class LinkedInUrl extends ValueObject<String> {
  static const maxLength = 30;

  @override
  final Either<ValueFailure<String>, String> value;

  factory LinkedInUrl(String input) {
    return LinkedInUrl._(validateMaxStringLength(input, maxLength));
  }

  factory LinkedInUrl.empty() {
    return LinkedInUrl('');
  }

  const LinkedInUrl._(this.value);
}

class GitHubUrl extends ValueObject<String> {
  static const maxLength = 30;

  @override
  final Either<ValueFailure<String>, String> value;

  factory GitHubUrl(String input) {
    return GitHubUrl._(validateMaxStringLength(input, maxLength));
  }

  factory GitHubUrl.empty() {
    return GitHubUrl('');
  }

  const GitHubUrl._(this.value);
}

class CategoriasCnh extends ValueObject<Map<String, bool>> {
  @override
  final Either<ValueFailure<Map<String, bool>>, Map<String, bool>> value;

  factory CategoriasCnh(Map<String, bool> input) {
    return CategoriasCnh._(right(input));
  }

  factory CategoriasCnh.empty() {
    return CategoriasCnh(
      {
        'A': false,
        'B': false,
        'C': false,
        'D': false,
        'E': false,
      },
    );
  }

  CategoriasCnh._(this.value);
}
