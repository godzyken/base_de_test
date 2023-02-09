import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'domain/data/entity/counter_increment.dart';
import 'infrastructure/repositories/counter_repository.dart';

final counterRepositoryProvider = Provider((ref) => CounterRepository());

final counterListProvider = FutureProvider((ref) async {
  final counter = ref.watch(counterRepositoryProvider);

  return counter.fetchCounter();
});

final listCounterProvider = FutureProvider((ref) async => <CounterIncrement>[]);
