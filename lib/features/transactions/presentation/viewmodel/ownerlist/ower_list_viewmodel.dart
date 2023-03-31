import 'package:base_de_test/features/transactions/domain/entities/entities.dart';
import 'package:base_de_test/features/transactions/domain/usecases/uses_cases.dart';
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
      final newOwner =
          await _createOwnerEntityCase.execute(name, phone, isValid);
      state = State.success(state.data!.addOwner(newOwner));
    } on Exception catch (e) {
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
