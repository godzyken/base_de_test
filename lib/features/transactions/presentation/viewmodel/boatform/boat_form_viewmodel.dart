import 'package:base_de_test/features/transactions/presentation/viewmodel/boatlist/boat_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/entities.dart';

class BoatLocationFormViewModel {
  BoatLocationFormViewModel(final Boat? boat, this._boatListViewModel) {
    _initBoat(boat);
  }
  late BoatId _id;
  final BoatListViewModel _boatListViewModel;
  var _name = '';
  var _boatIdentity = IdentityNumber.values;
  OwnerEntity _owner = const OwnerEntity(
      id: 0, name: 'name', phone: 'phone', address: Address());
  var _ownerName = '';
  var _isAvailable = false;
  var _types = TypesOfBoat.values;
  var cnp = CategoriesCNP.values;
  final DateTime _initDate = DateTime(DateTime.now().year);
  final DateTime _minimal = DateTime(DateTime.now().year);
  final DateTime _maximal = DateTime(DateTime.now().year + 5);
  final DateTimeRange _initDateTimeRange = DateTimeRange(
      start: DateTime.now(), end: DateTime.now().add(const Duration(days: 7)));

  var _raison = '';
  var _isNewBoat = false;

  _initBoat(final Boat? boat) {
    if (boat == null) {
      _isNewBoat = true;
    } else {
      _id = boat.boatId!;
      _name = boat.name;
      _boatIdentity = [];
      _types = [];
      _owner = boat.ownerEntity;
      _isAvailable = boat.isAvailable;
      _raison = boat.role!;
    }
  }

  createOrUpdateBoat() {
    if (_isNewBoat) {
      _boatListViewModel.addBoatLocation(
        _name,
        _isAvailable,
        _owner,
        _boatIdentity.single,
        _types.single,
        cnp.single,
        _initDate,
        _raison,
      );
    } else {
      final newBoat = Boat(
          boatId: _id,
          name: _name,
          ownerEntity: _owner,
          types: _types.single,
          identityNumber: _boatIdentity.single,
          cnp: cnp.single,
          isAvailable: _isAvailable,
          rentedAt: _initDateTimeRange.start,
          returnedAt: _initDateTimeRange.end,
          role: _raison);

      _boatListViewModel.updateBoat(newBoat);
    }
  }

  deleteBoatLocation() {
    if (!_isNewBoat) {
      _initDateTimeRange.end;
      return _boatListViewModel.deleteLocation(_id);
    }
  }

  String appBarTitle() => _isNewBoat ? 'Add Boat' : 'Edit Boat';

  String initialUserNameValue() => _name;
  String initialOwnerNameValue() => _ownerName;
  List<IdentityNumber> initialBoatIdentityValue() => _boatIdentity;
  bool initialAvailableValue() => _isAvailable;
  List<TypesOfBoat> initialTypesOfBoatValue() => _types;
  List<CategoriesCNP> initialCnpValue() => cnp;
  DateTime initialLocDateValue() => _initDate;
  DateTime datePickerFirstDate() => _minimal;
  DateTime datePickerLastDate() => _maximal;
  String initialRoleValue() => _raison;
  bool isNewBoatValue() => !_isNewBoat;
  DateTimeRange initDateRangeValue() => _initDateTimeRange;

  setName(final String value) => _name = value;
  setRole(final String value) => _raison = value;
  setOwnerName(final String value) {
    _ownerName = value;
    var address = const Address();
    _owner =
        OwnerEntity(id: 0, name: _ownerName, phone: 'phone', address: address);
  }

  setBoatIdentity(final List<IdentityNumber> value) => _boatIdentity = value;
  setTypesBoat(final List<TypesOfBoat> value) => _types = value;
  setIsAvailable(final bool value) => _isAvailable = value;
  setCategoryCnp(final List<CategoriesCNP> value) => cnp = value;
  setStartLocation(final DateTime value) => _initDateTimeRange.start;
  setStopLocation(final DateTime value) => _initDateTimeRange.end;

  String? validateName() {
    if (_name.isEmpty) {
      return 'Enter a name';
    } else if (_name.length > 20) {
      return 'Limit the name to 20 characters';
    } else {
      return null;
    }
  }

  String? validateDateInset() {
    if (_isNewBoat && _initDateTimeRange.start.isBefore(_initDate)) {
      return 'Start date of location must be after today\'s date';
    } else {
      return null;
    }
  }

  String? validateDateOffset() {
    if (!_isNewBoat && _initDateTimeRange.end.isBefore(_initDate)) {
      setIsAvailable(true);
      return 'this boat is available';
    } else if (_isNewBoat &&
        _initDateTimeRange.start.isAtSameMomentAs(createOrUpdateBoat())) {
      setIsAvailable(true);
      return 'this boat is available';
    } else {
      setIsAvailable(false);
      return 'this boat is not available or not exist';
    }
  }
}

final boatFormViewModelProvider =
    Provider.autoDispose.family<BoatLocationFormViewModel, Boat?>((ref, boat) {
  final boatListViewModel =
      ref.watch(boatListViewModelStateNotifierProvider.notifier);
  return BoatLocationFormViewModel(boat, boatListViewModel);
});
