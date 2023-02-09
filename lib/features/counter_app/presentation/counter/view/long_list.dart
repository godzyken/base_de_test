import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LongList extends ConsumerWidget {
  const LongList({super.key, required this.items});
  final List<String> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const title = 'Longue liste';
    final scroller = ScrollController(
        initialScrollOffset: 0.0, debugLabel: 'slide', keepScrollOffset: true);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      clipBehavior: Clip.hardEdge,
      primary: true,
      child: SizedBox(
        height: 100,
        width: 150,
        child: ListView.builder(
          key: const Key('long_list'),
          padding: const EdgeInsets.fromLTRB(0, 9, 0, 2),
          clipBehavior: Clip.hardEdge,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              visualDensity: VisualDensity.adaptivePlatformDensity,
              title: Text(items[index],
                  key: Key('items_${index}_text'),
                  style: const TextStyle(color: Colors.redAccent)),
              subtitle: const Text(
                title,
                style: TextStyle(color: Colors.grey),
              ),
            );
          },
          controller: scroller,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          addAutomaticKeepAlives: true,
          addRepaintBoundaries: true,
          addSemanticIndexes: true,
        ),
      ),
    );
  }
}
