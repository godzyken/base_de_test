import 'dart:developer' as developer;

import 'package:base_de_test/features/transactions/domain/entities/entities.dart';
import 'package:base_de_test/features/transactions/domain/usecase_provider.dart';
import 'package:base_de_test/features/transactions/domain/usecases/uses_cases.dart';
import 'package:base_de_test/features/transactions/presentation/controller/boat_notifier.dart';
import 'package:base_de_test/features/transactions/presentation/viewmodel/boatlist/filter_status_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/state.dart';

class OwnerListViewModel extends StateNotifier<State<OwnerList>> {
  final GetOwnerListUseCase _getOwnerListUseCase;
  final CreateOwnerEntityCase _createOwnerEntityCase;
  final DeleteOwnerEntityCase _deleteOwnerEntityCase;
  final UpdateOwnerUseCase _updateOwnerUseCase;

  OwnerListViewModel(this._getOwnerListUseCase, this._createOwnerEntityCase,
      this._deleteOwnerEntityCase, this._updateOwnerUseCase)
      : super(const State.init()) {
    _getOwnerList();
  }

  _getOwnerList() async {
    try {
      state = const State.loading();
      final ownerList = await _getOwnerListUseCase.execute();
      state = State.success(ownerList);
    } on Exception catch (e) {
      state = State.error(e);
    }
  }

  isValidOwner(final OwnerEntity ownerEntity) {
    final newOwner = ownerEntity.copyWith(isValid: true);
    updateOwner(newOwner);
  }

  isUnValidOwner(final OwnerEntity ownerEntity) {
    final newOwner = ownerEntity.copyWith(isValid: false);
    updateOwner(newOwner);
  }

  addOwner(
    final String name,
    final String phone,
    final bool isValid,
  ) async {
    try {
      developer.log('AddOwner(): start try with id: $name');

      state = const State.loading();
      final newOwner =
          await _createOwnerEntityCase.execute(name, phone, isValid);
      developer.log('ownerList from addOwner(): $newOwner');

      state.maybeWhen(
          success: (owners) {
            state = State.success(
                OwnerList(values: [OwnerEntity.create(name, phone)]));
          },
          loading: () => const State.loading(),
          init: State.init,
          error: (err) => State.error(err),
          orElse: () {});

      state = State.success(state.data!.addOwner(newOwner));
    } on Exception catch (e) {
      developer.log('Error before addOwner(): $e');
      state = State.error(e);
    }
  }

  updateOwner(final OwnerEntity newOwner) async {
    try {
      await _updateOwnerUseCase.execute(
        newOwner.ownerId,
        newOwner.name,
        newOwner.phone,
        newOwner.isValid,
      );
      state = State.success(state.data!.updateOwner(newOwner));
    } on Exception catch (e) {
      state = State.error(e);
    }
  }

  deleteOwner(final OwnerId id) async {
    try {
      await _deleteOwnerEntityCase.execute(id);
      state = State.success(state.data!.removeOwnerById(id));
    } on Exception catch (e) {
      state = State.error(e);
    }
  }
}

final ownerListViewModelStateNotifierProvider =
    StateNotifierProvider.autoDispose<OwnerListViewModel, State<OwnerList>>(
        (ref) => OwnerListViewModel(
              ref.watch(getOwnerListUseCaseProvider),
              ref.watch(createOwnerUseCaseProvider),
              ref.watch(deleteOwnerUseCaseProvider),
              ref.watch(updateOwnerUseCaseProvider),
            ));

final filteredOwnerListProvider = Provider.autoDispose<State<OwnerList>>((ref) {
  final filterKind = ref.watch(filterKindViewModelStateNotifierProvider);
  final ownerListState = ref.watch(ownerListViewModelStateNotifierProvider);
  final ownerId =
      ref.watch(ownerEntityNotifierProvider.select((value) => value.ownerId));

  return ownerListState.when(
      init: () => const State.init(),
      loading: () => const State.loading(),
      success: (ownerList) {
        switch (filterKind) {
          case FilterKind.all:
            return State.success(ownerList);
          case FilterKind.available:
            return State.success(ownerList.filterByComplete());
          case FilterKind.unavailable:
            return State.success(ownerList.filterByIncomplete());
          case FilterKind.byId:
            return State.success(ownerList.filterById(ownerId.value));
        }
      },
      error: (error) => State.error(error));
});
