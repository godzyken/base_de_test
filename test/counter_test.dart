import 'package:base_de_test/features/counter_app/domain/data/entity/counter_increment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'counter_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CounterIncrement>()])
void main() {
  late MockCounterIncrement counterIncrement;

  setUp(() {
    counterIncrement = MockCounterIncrement();
  });

  tearDown(() {
    resetMockitoState();
  });

  group('Counter sans appel api', () {
    test('value should start at 0', () {
      expect(counterIncrement.value, 0);
    });

    test('value should be incremented', () {
      when(counterIncrement.increment()).thenReturn(1);

      counterIncrement.value;

      counterIncrement.increment();

      counterIncrement.count;

      expect(counterIncrement.count, 1);
    });

    test('value should be decremented', () {
      when(counterIncrement.decrement()).thenReturn(-1);
      expect(counterIncrement.count, -1);
    });
  });

  group('Trouver un Textwidget', () {
    testWidgets('trouver un Text widget', (tester) async {
      // Build an App with a Text widget that displays the letter 'H'.
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: Text('H'),
        ),
      ));

      // Find a widget that displays the letter 'H'.
      expect(find.text('H'), findsOneWidget);
    });

    testWidgets('Trouver un widget avec une Key', (tester) async {
      // Define the test key.
      const testKey = Key('K');

      // Build a MaterialApp with the testKey.
      await tester.pumpWidget(MaterialApp(key: testKey, home: Container()));

      // Find the MaterialApp widget using the testKey.
      expect(find.byKey(testKey), findsOneWidget);
    });

    testWidgets('Trouver une instance de widget spécifique', (tester) async {
      const childWidget = Padding(padding: EdgeInsets.zero);

      // Provide the childWidget to the Container.
      await tester.pumpWidget(Container(child: childWidget));

      // Search for the childWidget in the tree and verify it exists.
      expect(find.byWidget(childWidget), findsOneWidget);
    });
  });

  group('Compteur et defilement', () {
    /* testWidgets('Counter increments smoke test', (tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(LongList(
        items: List<String>.generate(10000, (i) => 'Item $i'),
      ));

      final listFinder = find.byType(Scrollable);
      final itemFinder = find.byKey(const ValueKey('item_50_text'));

      // Scroll until the item to be found appears.
      */ /*   await tester.scrollUntilVisible(
        itemFinder,
        500.0,
        scrollable: listFinder,
      );*/ /*

      await tester.dragUntilVisible(listFinder, itemFinder, Offset.infinite,
          duration: const Duration(milliseconds: 1000), maxIteration: 50);

      // Verify that the item contains the correct text.
      expect(itemFinder, findsOneWidget);
    });*/
  });

  group('Simulation de api when', () {
    test('la valeur doit s\'incrementer', () {
      try {
        counterIncrement.increment();
      } on MissingStubError {
        // TODO
      }

      expect(counterIncrement.increment(), null);

      when(counterIncrement.increment()).thenReturn(1);
      expect(counterIncrement.increment(), 1);

      expect(counterIncrement.increment(), 1);

      when(counterIncrement.increment()).thenReturn(2);
      expect(counterIncrement.increment(), 2);

      when(counterIncrement.value).thenReturn(2);
      expect(counterIncrement.value, 2);

      when(counterIncrement.value).thenThrow(RangeError('message error'));
      expect(() => counterIncrement.value, throwsRangeError);

      var response = [0, 1, 2, 3];
      when(counterIncrement.increment())
          .thenAnswer((_) => response.removeAt(0));
      expect(counterIncrement.increment(), 0);
      expect(counterIncrement.increment(), 1);
      expect(counterIncrement.increment(), 2);
    });
    test('la valeur doit décrementer', () {
      try {
        counterIncrement.decrement();
      } on MissingStubError {
        // TODO
      }

      expect(counterIncrement.decrement(), null);

      when(counterIncrement.decrement()).thenReturn(-1);
      expect(counterIncrement.decrement(), -1);

      expect(counterIncrement.decrement(), -1);

      when(counterIncrement.decrement()).thenReturn(-2);
      expect(counterIncrement.decrement(), -2);

      when(counterIncrement.value).thenReturn(-2);
      expect(counterIncrement.value, -2);

      when(counterIncrement.value).thenThrow(RangeError('message error'));
      expect(() => counterIncrement.value, throwsRangeError);

      var response = [0, -1, -2, -3];
      when(counterIncrement.decrement())
          .thenAnswer((_) => response.removeAt(0));
      expect(counterIncrement.decrement(), 0);
      expect(counterIncrement.decrement(), -1);
      expect(counterIncrement.decrement(), -2);
    });

    test('le conpteur http doit s\'incrementer', () {
      try {
        counterIncrement.increment();
      } on MissingStubError {
        // TODO
      }

      expect(counterIncrement.increment(), null);

      when(counterIncrement.increment()).thenReturn(1);
      expect(counterIncrement.increment(), 1);

      expect(counterIncrement.increment(), 1);

      when(counterIncrement.increment()).thenReturn(2);
      expect(counterIncrement.increment(), 2);

      when(counterIncrement.value).thenReturn(2);
      expect(counterIncrement.value, 2);

      when(counterIncrement.value).thenThrow(RangeError('message error'));
      expect(() => counterIncrement.value, throwsRangeError);

      var response = [0, 1, 2, 3];
      when(counterIncrement.increment())
          .thenAnswer((_) => response.removeAt(0));
      expect(counterIncrement.increment(), 0);
      expect(counterIncrement.increment(), 1);
      expect(counterIncrement.increment(), 2);
    });
    test('le conpteur http  doit décrementer', () {
      try {
        counterIncrement.decrement();
      } on MissingStubError {
        // TODO
      }

      expect(counterIncrement.decrement(), null);

      when(counterIncrement.decrement()).thenReturn(-1);
      expect(counterIncrement.decrement(), -1);

      expect(counterIncrement.decrement(), -1);

      when(counterIncrement.decrement()).thenReturn(-2);
      expect(counterIncrement.decrement(), -2);

      when(counterIncrement.value).thenReturn(-2);
      expect(counterIncrement.value, -2);

      when(counterIncrement.value).thenThrow(RangeError('message error'));
      expect(() => counterIncrement.value, throwsRangeError);

      var response = [0, -1, -2, -3];
      when(counterIncrement.decrement())
          .thenAnswer((_) => response.removeAt(0));
      expect(counterIncrement.decrement(), 0);
      expect(counterIncrement.decrement(), -1);
      expect(counterIncrement.decrement(), -2);
    });
  });
}
