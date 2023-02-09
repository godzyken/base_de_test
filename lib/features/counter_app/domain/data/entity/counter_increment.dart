import 'package:base_de_test/features/counter_app/domain/data/entity/counter.dart';
import 'package:equatable/equatable.dart';

class CounterIncrement extends Equatable implements Counter {
  final int value;
  const CounterIncrement({required this.value});

  int? increment() => value + value;

  int? decrement() => value - value;

  factory CounterIncrement.fromJson(Map<String, dynamic> json) {
    return CounterIncrement(value: json['value']);
  }

  @override
  String toString() {
    return 'CounterIncrement{value: $value}';
  }

  @override
  // TODO: implement count
  int get count => value;

  @override
  // TODO: implement id
  int get id => 0;

  @override
  Map<String, dynamic> toJson() => {'id': id, 'count': value};

  @override
  // TODO: implement props
  List<Object?> get props => [
        count,
        value,
        increment(),
        decrement(),
        id,
      ];
}
