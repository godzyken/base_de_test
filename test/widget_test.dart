// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:base_de_test/features/counter_app/counter_providers.dart';
import 'package:base_de_test/features/counter_app/infrastructure/repositories/counter_repository.dart';
import 'package:base_de_test/my_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'widget_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CounterRepository>()])
void main() {
  late MockCounterRepository mockCounterRepository;

  setUp(() => {mockCounterRepository = MockCounterRepository()});

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(
        child: MyWidget(
            title: 'test riverpod', message: 'test counter widget riverpod')));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('the counter state is not shared between tests', (tester) async {
    await tester.pumpWidget(const ProviderScope(
        child: MyWidget(
            title: 'test riverpod', message: 'test counter widget riverpod')));

    // The state is `0` once again, with no tearDown/setUp needed
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);
  });

  testWidgets('override counterRepositoryProvider', (tester) async {
    await tester.pumpWidget(ProviderScope(
        overrides: [
          counterRepositoryProvider.overrideWithValue(MockCounterRepository())
        ],
        child: const MyWidget(
            title: 'test riverpod', message: 'test counter widget riverpod')));

    // The state is `0` once again, with no tearDown/setUp needed
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);
  });

  testWidgets('override future Provider', (tester) async {
    await tester.pumpWidget(const ProviderScope(
        overrides: [
          // counterListProvider.overrideWith(
          //     (ref) async => AsyncValue.data([CounterIncrement(value: 0)])
          // )
        ],
        child: MyWidget(
            title: 'test riverpod', message: 'test counter widget riverpod')));

    // The state is `0` once again, with no tearDown/setUp needed
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);
  });
}
