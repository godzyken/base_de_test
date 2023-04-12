import 'package:flutter_riverpod/flutter_riverpod.dart';

enum FilterKind { all, available, unavailable, byId }

final filterKindViewModelStateNotifierProvider =
    StateNotifierProvider.autoDispose<FilterKindViewModel, FilterKind>(
        (_) => FilterKindViewModel());

class FilterKindViewModel extends StateNotifier<FilterKind> {
  FilterKindViewModel() : super(FilterKind.all);

  filterByAll() => state = FilterKind.all;

  filterByAvailable() => state = FilterKind.available;

  filterByUnavailable() => state = FilterKind.unavailable;

  filterById(final int id) => state = FilterKind.byId;

  bool isFilterByAll() => state == FilterKind.all;

  bool isFilterByAvailable() => state == FilterKind.available;

  bool isFilterByUnavailable() => state == FilterKind.unavailable;

  bool isFilterById(final int id) => state == FilterKind.byId;
}
