// Mocks generated by Mockito 5.3.2 from annotations
// in base_de_test/test/widget_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:base_de_test/features/counter_app/domain/data/entity/counter_increment.dart'
    as _i4;
import 'package:base_de_test/features/counter_app/infrastructure/repositories/counter_repository.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [CounterRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockCounterRepository extends _i1.Mock implements _i2.CounterRepository {
  @override
  _i3.Future<List<_i4.CounterIncrement>> fetchCounter() => (super.noSuchMethod(
        Invocation.method(
          #fetchCounter,
          [],
        ),
        returnValue: _i3.Future<List<_i4.CounterIncrement>>.value(
            <_i4.CounterIncrement>[]),
        returnValueForMissingStub: _i3.Future<List<_i4.CounterIncrement>>.value(
            <_i4.CounterIncrement>[]),
      ) as _i3.Future<List<_i4.CounterIncrement>>);
}
