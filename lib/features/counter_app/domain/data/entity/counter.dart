import '../adapter/safe_convert.dart';

class Counter {
  // 1
  final int id;
  // 0
  final int count;

  Counter({
    this.id = 0,
    this.count = 0,
  });

  factory Counter.fromJson(Map<String, dynamic>? json) => Counter(
        id: asT<int>(json, 'id'),
        count: asT<int>(json, 'count'),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'count': count,
      };
}
