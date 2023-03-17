import 'package:base_de_test/features/transactions/domain/usecase_provider.dart';
import 'package:base_de_test/features/transactions/presentation/viewmodel/boatlist/filter_status_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/uses_cases.dart';
import '../../state/state.dart';

class BoatListViewModel extends StateNotifier<State<BoatList>> {
  final GetBoatListUseCase _getBoatListUseCase;
  final CreateBoatLocationCase _createBoatLocationCase;
  final DeleteBoatLocationUseCase _deleteBoatLocationUseCase;
  final UpdateBoatLocationUseCase _updateBoatLocationUseCase;

  BoatListViewModel(this._getBoatListUseCase, this._createBoatLocationCase,
      this._deleteBoatLocationUseCase, this._updateBoatLocationUseCase)
      : super(const State.init()) {
    _getBoatList();
  }

  availableBoat(final Boat boat) {
    final newBoat = boat.copyWith(isAvailable: true);
    updateBoat(newBoat);
  }

  unavailableBoat(final Boat boat) {
    final newBoat = boat.copyWith(isAvailable: false);
    updateBoat(newBoat);
  }

  _getBoatList() async {
    try {
      state = const State.loading();
      final boatList = await _getBoatListUseCase.execute();
      state = State.success(boatList);
    } on Exception catch (e) {
      state = State.error(e);
    }
  }

  addBoatLocation(
    final String name,
    final OwnerId ownerId,
    final bool isAvailable,
    final AddressId addressId,
    final IdentityNumber identityNumber,
    final TypesOfBoat typesOfBoat,
    final CategoriesCNP cnp,
    final DateTime create,
    final DateTime? removedAt,
    final DateTime? rentAt,
    final DateTime? returnedAt,
    final String role,
  ) async {
    try {
      final newBoat = await _createBoatLocationCase.execute(
          name,
          ownerId,
          addressId,
          identityNumber,
          typesOfBoat,
          cnp,
          isAvailable,
          create,
          removedAt!,
          rentAt!,
          returnedAt!,
          role);

      state = State.success(state.data!.addBoat(newBoat));
    } on Exception catch (e) {
      state = State.error(e);
    }
  }

  updateBoat(final Boat newBoat) async {
    try {
      await _updateBoatLocationUseCase.execute(
          newBoat.boatId!,
          newBoat.name,
          newBoat.ownerId!,
          newBoat.identityNumber,
          newBoat.addressId!,
          newBoat.types,
          newBoat.cnp,
          newBoat.isAvailable,
          newBoat.createdAt,
          newBoat.deletedAt!,
          newBoat.rentedAt!,
          newBoat.returnedAt!,
          newBoat.role!);
      state = State.success(state.data!.updateBoat(newBoat));
    } on Exception catch (e) {
      state = State.error(e);
    }
  }

  deleteLocation(final BoatId id) async {
    try {
      await _deleteBoatLocationUseCase.execute(id);
      state = State.success(state.data!.removeBoatById(id));
    } on Exception catch (e) {
      state = State.error(e);
    }
  }
}

final filteredBoatListProvider = Provider.autoDispose<State<BoatList>>((ref) {
  final filterKind = ref.watch(filterKindViewModelStateNotifierProvider);
  final boatListState = ref.watch(boatListViewModelStateNotifierProvider);

  return boatListState.when(
    init: () => const State.init(),
    loading: () => const State.loading(),
    success: (boatList) {
      switch (filterKind) {
        case FilterKind.all:
          return State.success(boatList);
        case FilterKind.available:
          return State.success(boatList.filterByComplete());
        case FilterKind.unavailable:
          return State.success(boatList.filterByIncomplete());
      }
    },
    error: (exception) => State.error(exception),
  );
});

final boatListViewModelStateNotifierProvider =
    StateNotifierProvider.autoDispose<BoatListViewModel, State<BoatList>>(
        (ref) => BoatListViewModel(
              ref.watch(getBoatListUseCaseProvider),
              ref.watch(createBoatLocationUseCaseProvider),
              ref.watch(deleteBoatLocationUseCaseProvider),
              ref.watch(updateBoatLocationUseCaseProvider),
            ));
