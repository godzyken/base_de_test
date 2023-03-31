import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part "app_form_state.freezed.dart";

@freezed
class AppFormState<T> with _$AppFormState<T> {
  const AppFormState._();

  const factory AppFormState.init() = init<T>;
  const factory AppFormState.process() = _process;
  const factory AppFormState.success(final T form) = _success<T>;
  const factory AppFormState.error(final Exception exception) = _error;

  bool get isInit => maybeWhen(init: () => true, orElse: () => false);
  bool get isProcess => maybeWhen(process: () => true, orElse: () => false);
  bool get isSuccess => maybeWhen(success: (_) => true, orElse: () => false);
  bool get isError => maybeWhen(error: (_) => true, orElse: () => false);

  T? get data => maybeWhen(success: (data) => data, orElse: () => null);

  List<T>? get dataStream => mapOrNull(
        success: (_) => []..breakI((t) => isSuccess),
        process: (value) => []..lastOption.pure(data),
        error: (value) => []..all((t) => false),
        init: (value) => []..init,
      );
}
