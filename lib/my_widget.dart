import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counterProvider = Provider((ref) => 0);
final counterStateProvider = StateProvider((ref) => 0);

class MyWidget extends ConsumerStatefulWidget {
  const MyWidget({super.key, required this.title, required this.message});

  final String title;
  final String message;

  @override
  ConsumerState<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<MyWidget> {
  @override
  void initState() {
    super.initState();
    final count = ref.read(counterProvider);
    log('count debug : $count');
  }

  @override
  Widget build(BuildContext context) {
    final count = ref.watch(counterProvider);
    final addCount = ref.watch(counterStateProvider);
    return MaterialApp(
      title: 'test mi couille',
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            children: [
              Text(widget.message),
              Text('Count: $count'),
              Consumer(builder: (context, ref, _) {
                return ElevatedButton(
                    onPressed: () =>
                        ref.watch(counterStateProvider.notifier).state++,
                    child: Text('$addCount'));
              })
            ],
          ),
        ),
      ),
    );
  }
}
