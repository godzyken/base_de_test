import 'package:base_de_test/features/common/presentation/utils/extensions/ui_extension.dart';
import 'package:base_de_test/features/transactions/presentation/viewmodel/boatlist/boat_list_viewmodel.dart';
import 'package:base_de_test/features/transactions/presentation/viewmodel/boatlist/filter_status_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/entities.dart';
import 'boat_form_page.dart';

class BoatListPage extends ConsumerWidget {
  BoatListPage({super.key});

  final _filteredBoatListProvider = filteredBoatListProvider;
  final _boatListProvider = boatListViewModelStateNotifierProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boat location app'),
      ),
      body: Column(
        children: [
          ChipsBarWidget(),
          const Divider(
            height: 2,
            color: Colors.grey,
          ),
          Consumer(builder: (context, ref, _) {
            return ref.watch(_filteredBoatListProvider).maybeWhen(
                success: (content) =>
                    _buildBoatListContainerWidget(ref, content),
                error: (e) => Expanded(child: Center(child: ErrorWidget(e))),
                orElse: () => const Expanded(
                        child: Center(
                      child: CircularProgressIndicator(),
                    )));
          })
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildBoatListContainerWidget(WidgetRef ref, final BoatList boatList) {
    return Expanded(child: _buildBoatListWidget(ref, boatList));
  }

  Widget _buildBoatListWidget(final WidgetRef ref, final BoatList boatList) {
    if (boatList.length == 0) {
      return const Center(
        child: Text('No Boat'),
      );
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: boatList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (final BuildContext context, final int index) {
          return _buildBoatItemCardWidget(context, ref, boatList[index]);
        },
      );
    }
  }

  Widget _buildBoatItemCardWidget(
      final BuildContext context, final WidgetRef ref, final Boat boat) {
    return InkWell(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    boat.name,
                    style: context.textTheme.displaySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy').format(boat.rentedAt!),
                    style: context.textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    boat.types.name,
                    style: context.textTheme.displaySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // TODO: List of args...
                ],
              )),
              const SizedBox(
                width: 8,
              ),
              boat.isAvailable
                  ? _buildCheckedIcon(ref, boat)
                  : _buildUncheckedIcon(ref, boat),
            ],
          ),
        ),
      ),
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => BoatFormPage(boat))),
    );
  }

  Widget _buildCheckedIcon(final WidgetRef ref, final Boat boat) {
    return InkResponse(
      onTap: () => ref.watch(_boatListProvider.notifier).unavailableBoat(boat),
      splashColor: Colors.transparent,
      child: const Icon(
        Icons.done,
        size: 24,
        color: Colors.lightGreen,
      ),
    );
  }

  Widget _buildUncheckedIcon(final WidgetRef ref, final Boat boat) {
    return InkResponse(
      onTap: () => ref.watch(_boatListProvider.notifier).availableBoat(boat),
      splashColor: Colors.transparent,
      child: const Icon(
        Icons.radio_button_off_rounded,
        size: 24,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildFloatingActionButton(final BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => const BoatFormPage(null))),
      child: const Icon(Icons.add),
    );
  }
}

class ChipsBarWidget extends ConsumerWidget {
  final _provider = filterKindViewModelStateNotifierProvider;

  ChipsBarWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(builder: (context, ref, _) {
      final viewModel = ref.watch(_provider.notifier);
      ref.watch(_provider);
      return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              children: [
                InputChip(
                  label: const Text('All'),
                  selected: viewModel.isFilterByAll(),
                  onSelected: (_) => viewModel.filterByAll(),
                  selectedColor:
                      viewModel.isFilterByAll() ? Colors.lightGreen : null,
                ),
                const SizedBox(
                  width: 8,
                ),
                InputChip(
                  label: const Text('Available'),
                  selected: viewModel.isFilterByAvailable(),
                  onSelected: (_) => viewModel.filterByAvailable(),
                  selectedColor: viewModel.isFilterByAvailable()
                      ? Colors.lightGreen
                      : null,
                ),
                const SizedBox(
                  width: 8,
                ),
                InputChip(
                  label: const Text('Unavailable'),
                  selected: viewModel.isFilterByUnavailable(),
                  onSelected: (_) => viewModel.filterByUnavailable(),
                  selectedColor: viewModel.isFilterByUnavailable()
                      ? Colors.lightGreen
                      : null,
                ),
              ],
            )),
      );
    });
  }
}
