import 'package:base_de_test/features/transactions/presentation/viewmodel/boatlist/boat_list_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/entities.dart';

class BoatLocationFormViewModel {
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
  var _initdate = DateTime.now();
  var _startAt = DateTime.now();
  var _stopAt = DateTime.now();
  var _raison = '';
  var _isNewBoat = false;

  BoatLocationFormViewModel(final Boat? boat, this._boatListViewModel) {
    _initBoat(boat);
  }

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
      _startAt = boat.rentedAt!;
      _stopAt = boat.returnedAt!;
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
        _startAt,
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
          isAvailable: _isAvailable);

      _boatListViewModel.updateBoat(newBoat);
    }
  }

  deleteBoatLocation() {
    if (!_isNewBoat) {
      _stopAt;
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
  DateTime initialLocDateValue() => _initdate;
  DateTime datePickerFirstDate() => _startAt;
  DateTime datePickerLastDate() => _stopAt;
  String initialRoleValue() => _raison;
  bool isNewBoatValue() => !_isNewBoat;

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
  setStartLocation(final DateTime value) => _startAt = value;
  setStopLocation(final DateTime value) => _stopAt = value;

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
    if (_isNewBoat && _startAt.isBefore(DateTime.now())) {
      return 'Start date of location must be after today\'s date';
    } else {
      return null;
    }
  }

  String? validateDateOffset() {
    if (!_isNewBoat && _stopAt.isBefore(DateTime.now())) {
      setIsAvailable(true);
      return 'this boat is available';
    } else if (_isNewBoat && _startAt.isAtSameMomentAs(createOrUpdateBoat())) {
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
