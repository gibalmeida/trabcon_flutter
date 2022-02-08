import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';
import 'package:kt_dart/collection.dart';

import 'failures.dart';

Either<ValueFailure<String>, String> validateMaxStringLength(
  String input,
  int maxLength,
) {
  if (input.length <= maxLength) {
    return right(input);
  } else {
    return left(
      ValueFailure.exceedingLength(
        failedValue: input,
        max: maxLength,
      ),
    );
  }
}

Either<ValueFailure<String>, String> validateStringNotEmpty(String input) {
  if (input.isEmpty) {
    return left(ValueFailure.empty(failedValue: input));
  } else {
    return right(input);
  }
}

Either<ValueFailure<String>, String> validateSingleLine(String input) {
  if (input.contains('\n')) {
    return left(ValueFailure.multiline(failedValue: input));
  } else {
    return right(input);
  }
}

Either<ValueFailure<KtList<T>>, KtList<T>> validateMaxListLength<T>(
  KtList<T> input,
  int maxLength,
) {
  if (input.size <= maxLength) {
    return right(input);
  } else {
    return left(
      ValueFailure.listTooLong(
        failedValue: input,
        max: maxLength,
      ),
    );
  }
}

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  // Maybe not the most robust way of email validation but it's good enough
  const emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  if (RegExp(emailRegex).hasMatch(input)) {
    return right(input);
  } else {
    return left(ValueFailure.invalidEmail(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validatePassword(String input) {
  // You can also add some advanced password checks (uppercase/lowercase, at least 1 number, ...)
  if (input.length >= 6) {
    return right(input);
  } else {
    return left(ValueFailure.shortPassword(failedValue: input));
  }
}

Either<ValueFailure<int?>, int> validateInteger(String input) {
  final parsedValue = int.tryParse(input);
  if (parsedValue == null) {
    return left(const ValueFailure.notAInteger(failedValue: null));
  } else {
    return right(parsedValue);
  }
}

Either<ValueFailure<DateTime?>, DateTime> validateDate(String input) {
  DateTime? parsedDate = DateTime.tryParse(input);
  if (parsedDate == null) {
    return left(
      ValueFailure.invalidDate(
        failedValue: parsedDate,
        invalidDate: input,
      ),
    );
  } else {
    return right(parsedDate);
  }
}

Either<ValueFailure<DateTime?>, DateTime> validateDateFromString(String input) {
  if (input.isEmpty) {
    return left(
      const ValueFailure.empty(
        failedValue: null,
      ),
    );
  }
  try {
    return right(DateFormat.yMd().parse(input));
  } on FormatException catch (_) {
    return left(
      ValueFailure.invalidDate(
        failedValue: null,
        invalidDate: input,
      ),
    );
  }
}

Either<ValueFailure<int>, int> validateRange(
  int input,
  int minValue,
  int maxValue,
) {
  if (input < minValue || input > maxValue) {
    return left(ValueFailure.outOfRange(
        failedValue: input, min: minValue, max: maxValue));
  } else {
    return right(input);
  }
}

Either<ValueFailure<String>, String> validateCep(String input) {
  // O CEP deve estar no formato xx.xxx-xxx (onde x é um número de 0 a 9)
  const cepRegex = r"""^[0-9]{2}\.[0-9]{3}-[0-9]{3}""";
  if (RegExp(cepRegex).hasMatch(input)) {
    return right(input);
  } else {
    return left(ValueFailure.invalidCep(failedValue: input));
  }
}
