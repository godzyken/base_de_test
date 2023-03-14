import 'package:base_de_test/features/transactions/presentation/viewmodel/boatlist/boat_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/entities.dart';

class AddBoatFormViewModel {
  AddBoatFormViewModel(final Boat? boat, this._boatListViewModel) {
    _initBoat(boat);
  }
  final BoatListViewModel _boatListViewModel;

  late BoatId _id;
  late OwnerId _ownerId;
  late AddressId _addressId;

  var _name = '';
  var _boatIdentity = IdentityNumber.values;
  OwnerEntity? _owner;
  AddressEntity? _address;
  var _ownerName = '';
  var _cityName = '';
  var _zipCode = '';
  var _ownerPhone = '';
  var _isAvailable = false;
  var _types = TypesOfBoat.values;
  var _cnp = CategoriesCNP.values;
  final DateTime _initDate = DateTime.now();
  final DateTime _removeDate = DateTime.now();
  final DateTime _minimal = DateTime(DateTime.now().year);
  final DateTime _maximal = DateTime(DateTime.now().year + 5);
  final DateTimeRange _initDateTimeRange = DateTimeRange(
      start: DateTime.now(), end: DateTime.now().add(const Duration(days: 7)));

  var _raison = '';
  var _isNewBoat = false;

  _initBoat(final Boat? boat) {
    if (boat == null) {
      _isNewBoat = true;
      // _ownerId = boat!.ownerId!;
      // _addressId = boat.addressId!;
    } else {
      _id = boat.boatId!;
      _name = boat.name;
      _ownerId = boat.ownerId!;
      _addressId = boat.addressId!;
      _address = boat.addressEntity!;
      _boatIdentity = [];
      _types = [];
      _cnp = [];
      _owner = boat.ownerEntity;
      _isAvailable = boat.isAvailable;
      _raison = boat.role!;
    }
  }

  createOrUpdateBoat() {
    if (_isNewBoat) {
      var value = 1 + DateTime.now().millisecondsSinceEpoch;

      _addressId = setAddressId(value);
      _ownerId = setOwnerId(value);

      _boatListViewModel.addBoatLocation(
        _name,
        _ownerId,
        _isAvailable,
        _owner!,
        _addressId,
        _address!,
        _boatIdentity.first,
        _types.first,
        _cnp.first,
        _initDate,
        _removeDate,
        _initDateTimeRange.start,
        _initDateTimeRange.end,
        _raison,
      );
    } else {
      final oldBoat = Boat(
        boatId: _id,
        name: _name,
        ownerEntity: _owner,
        addressId: _addressId,
        addressEntity: _address,
        types: _types.first,
        identityNumber: _boatIdentity.first,
        cnp: _cnp.first,
        isAvailable: _isAvailable,
        createdAt: _initDate,
        role: _raison,
        ownerId: _ownerId,
      );
      _boatListViewModel.updateBoat(oldBoat);
    }
  }

  deleteBoatLocation() {
    if (!_isNewBoat) {
      _initDateTimeRange.end;
      return _boatListViewModel.deleteLocation(_id);
    }
  }

  String appBarTitle() => _isNewBoat ? 'Add Boat' : 'Edit Boat';

  String initialBoatNameValue() => _name;
  String initialOwnerNameValue() => _ownerName;
  String initialOwnerPhoneValue() => _ownerPhone;
  OwnerId initializeOwnerId() => _ownerId;
  AddressId initializeAddressId() => _addressId;
  OwnerEntity? initializeOwnerEntityValue() => _owner!;
  List<IdentityNumber> initialBoatIdentityValue() => _boatIdentity;
  bool initialAvailableValue() => _isAvailable;
  List<TypesOfBoat> initialTypesOfBoatValue() => _types;
  List<CategoriesCNP> initialCnpValue() => _cnp;
  DateTime initialCreatedDateValue() => _initDate;
  DateTime datePickerFirstDate() => _minimal;
  DateTime datePickerLastDate() => _maximal;
  String initialRoleValue() => _raison;
  bool isNewBoatValue() => !_isNewBoat;
  DateTimeRange initDateRangeValue() => _initDateTimeRange;

  setName(final String value) => _name = value;
  setRole(final String value) => _raison = value;
  setOwnerName(final String value) => _ownerName = value;
  setCityName(final String value) => _cityName = value;
  setZipCode(final String value) => _zipCode = value;
  setOwnerPhone(final String value) => _ownerPhone = value;
  setOwnerId(final int value) => _ownerId.copyWith(value: value).value;

  setAddressId(final int value) {
    var i = value + 3 + DateTime.now().millisecondsSinceEpoch;
    _addressId.copyWith(value: i).value;
  }

  setBoatIdentity(final List<IdentityNumber> value) => _boatIdentity = value;
  setTypesBoat(final List<TypesOfBoat> value) {
    if (_types.isNotEmpty) {
      _types.contains(value.single);
      return value;
    }
  }

  setIsAvailable(final bool value) => _isAvailable = value;
  setCategoryCnp(final List<CategoriesCNP> value) => _cnp = value;
  setStartLocation(final DateTime value) => _initDateTimeRange.start;
  setStopLocation(final DateTime value) => _initDateTimeRange.end;

  even(final DateTimeRange dateTimeRange, initialAvailableValue) {
    if (setStartLocation(dateTimeRange.start)) {
      initialAvailableValue = false;
    } else if (setStopLocation(dateTimeRange.end)) {
      initialAvailableValue = true;
    }
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return 'Enter a name';
    } else if (value.length > 20) {
      return 'Limit the name to 20 characters';
    } else {
      return value;
    }
  }

  String? validatePhone(String value) {
    if (value.isEmpty) {
      return 'Enter a phone';
    } else if (value.length > 20) {
      return 'Limit the name to 20 characters';
    } else {
      return value;
    }
  }

  String? validateRole(String value) {
    if (value.isEmpty) {
      return 'Enter a raison';
    } else if (value.length > 20) {
      return 'Limit the name to 20 characters';
    } else {
      return value;
    }
  }

  String? validateDateInset() {
    if (_isNewBoat && _initDateTimeRange.start.isBefore(_initDate)) {
      setIsAvailable(true);
      return 'Start date of location must be after today\'s date';
    } else {
      setIsAvailable(false);
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
    Provider.autoDispose.family<AddBoatFormViewModel, Boat?>((ref, boat) {
  final boatListViewModel =
      ref.watch(boatListViewModelStateNotifierProvider.notifier);
  ref.keepAlive();
  return AddBoatFormViewModel(boat, boatListViewModel);
});

final boatListFutureProvider = FutureProvider.autoDispose
    .family<List<Boat>, AddBoatFormViewModel>((ref, filter) async {
  final boatListViewModel =
      ref.watch(boatListViewModelStateNotifierProvider.notifier);

  return boatListViewModel.addBoatLocation(
      filter._name,
      filter._ownerId,
      filter._isAvailable,
      filter._owner!,
      filter._addressId,
      filter._address!,
      filter._boatIdentity.first,
      filter._types.first,
      filter._cnp.first,
      filter._initDate,
      filter._removeDate,
      filter._initDateTimeRange.start,
      filter._initDateTimeRange.end,
      filter._raison);
});
