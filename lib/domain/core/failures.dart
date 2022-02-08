import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.exceedingLength({
    required T failedValue,
    required int max,
  }) = ExceedingLength<T>;
  const factory ValueFailure.empty({
    required T failedValue,
  }) = Empty<T>;
  const factory ValueFailure.multiline({
    required T failedValue,
  }) = Multiline<T>;
  const factory ValueFailure.numberTooLarge({
    required T failedValue,
    required num max,
  }) = NumberTooLarge<T>;
  const factory ValueFailure.listTooLong({
    required T failedValue,
    required int max,
  }) = ListTooLong<T>;
  const factory ValueFailure.invalidEmail({
    required T failedValue,
  }) = InvalidEmail<T>;
  const factory ValueFailure.shortPassword({
    required T failedValue,
  }) = ShortPassword<T>;
  const factory ValueFailure.invalidPhotoUrl({
    required T failedValue,
  }) = InvalidPhotoUrl<T>;
  const factory ValueFailure.notAInteger({
    required T failedValue,
  }) = NotAInteger<T>;
  const factory ValueFailure.outOfRange({
    required T failedValue,
    required int min,
    required int max,
  }) = OutOfRange<T>;
  const factory ValueFailure.invalidCep({
    required T failedValue,
  }) = InvalidCep<T>;
  const factory ValueFailure.invalidDate({
    required T failedValue,
    required String invalidDate,
  }) = InvalidDate<T>;
  const factory ValueFailure.optionNotSelected({
    required T failedValue,
  }) = OptionNotSelected<T>;
}
