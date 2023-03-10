// Mocks generated by Mockito 5.3.2 from annotations
// in base_de_test/test/counter_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:base_de_test/features/counter_app/domain/data/entity/counter_increment.dart'
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

/// A class which mocks [CounterIncrement].
///
/// See the documentation for Mockito's code generation for more information.
class MockCounterIncrement extends _i1.Mock implements _i2.CounterIncrement {
  @override
  int get value => (super.noSuchMethod(
        Invocation.getter(#value),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);
  @override
  int get count => (super.noSuchMethod(
        Invocation.getter(#count),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);
  @override
  int get id => (super.noSuchMethod(
        Invocation.getter(#id),
        returnValue: 0,
        returnValueForMissingStub: 0,
      ) as int);
  @override
  List<Object?> get props => (super.noSuchMethod(
        Invocation.getter(#props),
        returnValue: <Object?>[],
        returnValueForMissingStub: <Object?>[],
      ) as List<Object?>);
  @override
  Map<String, dynamic> toJson() => (super.noSuchMethod(
        Invocation.method(
          #toJson,
          [],
        ),
        returnValue: <String, dynamic>{},
        returnValueForMissingStub: <String, dynamic>{},
      ) as Map<String, dynamic>);
}
