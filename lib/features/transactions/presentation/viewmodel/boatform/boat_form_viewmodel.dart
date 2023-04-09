import 'dart:async';
import 'dart:developer' as developer;

import 'package:base_de_test/features/auth/domain/entities/user_properties/name.dart';
import 'package:base_de_test/features/transactions/presentation/controller/boat_notifier.dart';
import 'package:base_de_test/features/transactions/presentation/state/app_form_state.dart';
import 'package:base_de_test/features/transactions/presentation/viewmodel/boatlist/boat_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/entities.dart';

class AddBoatFormViewModel extends StateNotifier<AppFormState<Boat>> {
  AddBoatFormViewModel(final Boat? boat, this._boatListViewModel)
      : super(const AppFormState.init()) {
    _initBoat(boat);
  }

  final BoatListViewModel _boatListViewModel;

  late BoatId boatId;
  late int _ownerId;
  late int _addressId;
  late StreamSubscription subscription;
  StreamController<int> controller = StreamController<int>();

  AppFormState<Boat>? previousState;

  var _name = 'boatoteau';
  OwnerEntity? _owner;
  AddressEntity? _address;
  var _ownerName = 'Akhenathon';
  var _cityName = 'Marseille';
  var _zipCode = '13000';
  var _ownerPhone = '080080080';
  var _isAvailable = false;
  String _boatIdentity = IdentityNumber.unknown.name;
  String _types = TypesOfBoat.unknown.name;
  String _cnp = CategoriesCNP.unknown.name;
  List<Docking> _docking = Docking.values;
  final DateTime _initDate = DateTime.now();
  final DateTime _minimal = DateTime(DateTime.now().year);
  final DateTime _maximal = DateTime(DateTime.now().year + 5);
  final DateTimeRange _initDateTimeRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().add(const Duration(days: 7)),
  );

  var _raison = 'recherche';
  var _isNewBoat = false;

  _initBoat(final Boat? boat) {
    state = const AppFormState.init();
    if (state.isInit) {
      state = const AppFormState.process();
      subscription = _setUp().listen(
        (event) {
          _boatListViewModel.addListener((state) {
            if (state.isInit && boat!.isAvailable) {
              state.dataStream!.where((element) {
                for (var e in element.values) {
                  boat.boatId?.value != 0 ? e.boatId!.value : boat.boatId;
                  //addNewBoat(e);
                  return true;
                }

                return false;
              });
            }
          });
        },
      );
    }

    if (boat?.boatId!.value == 0) {
      _isNewBoat = true;
      // _addressId = setAddressId(newId++);
      // _ownerId = setOwnerId(newId++);
      //addNewBoat(boat);
    } else {
      boatId = boat!.boatId!;
      _name = boat.name;
      _ownerId = boat.ownerId!.value;
      _addressId = boat.addressId!.value;
      _boatIdentity = boat.identityNumber.name;
      _types = boat.types.name;
      _cnp = boat.cnp.name;
      _docking = [];
      _isAvailable = boat.isAvailable;
    }
  }

  _cacheState() {
    previousState = state;
  }

  Future<Boat> addNewBoat(final Boat? boat) async {
    _cacheState();
    state = const AppFormState.process();
    try {
      developer.log('last Boat save: $boat');

      final Boat newBoat = await _boatListViewModel.addBoatLocation(
        boat!.name,
        boat.ownerId!.value,
        boat.addressId!.value,
        boat.types.name,
        boat.identityNumber.name,
        boat.cnp.name,
        boat.isAvailable,
        boat.createdAt,
        boat.rentedAt,
        boat.returnedAt,
        boat.role,
      );

      return Future.delayed(const Duration(seconds: 1), () {
        //return success(newBoat);
        return state.when(
            init: () => _initBoat(newBoat),
            process: () {
              if (const AppFormState.process().isProcess) {
                return newBoat;
              }
              return Boat.empty();
            },
            success: success,
            error: (error) {
              AppFormState.error(error);
              return Boat.empty();
            });
      });
    } on Exception catch (e) {
      developer.log('Error during addBoatLocation(): $e');
      state.isError;
      return Boat.empty();
    }
  }

  FutureOr<Boat> success(Boat form) {
    final newBoat = form;
    if (newBoat.isAvailable) {
      AppFormState.success(newBoat);
      return newBoat;
    }
    return Boat.empty();
  }

  createOrUpdateBoat() async {
    _cacheState();
    developer.log('first Boat save: ${state.data}');

    if (_isNewBoat) {
      state = AppFormState.success(await _boatListViewModel.addBoatLocation(
        _name,
        _ownerId,
        _addressId,
        _types,
        _boatIdentity,
        _cnp,
        _isAvailable,
        _initDate,
        _initDateTimeRange.start,
        _initDateTimeRange.end,
        _raison,
      ));
    } else {
      final oldBoat = Boat(
        boatId: BoatId(value: boatId.value),
        name: _name,
        addressId: AddressId(value: _addressId),
        types: TypesOfBoat.values.byName(_types),
        identityNumber: IdentityNumber.values.byName(_boatIdentity),
        cnp: CategoriesCNP.values.byName(_cnp),
        isAvailable: _isAvailable,
        createdAt: _initDate,
        role: _raison,
        ownerId: OwnerId(value: _ownerId),
        rentedAt: _initDateTimeRange.start,
        returnedAt: _initDateTimeRange.end,
      );
      state =
          AppFormState.success(await _boatListViewModel.updateBoat(oldBoat));
    }
  }

  createOrUpdateOwner(String id) {
    if (id.isNotEmpty) {}
  }

  createOrUpdateAddress() {}

  deleteBoatLocation() {
    if (!_isNewBoat) {
      _initDateTimeRange.end;
      return _boatListViewModel.deleteLocation(boatId);
    }
  }

  String appBarTitle() => _isNewBoat ? 'Add Boat' : 'Edit Boat';

  String initialBoatNameValue() => _name;
  String initialOwnerNameValue() => _ownerName;
  String initialCityNameValue() => _cityName;
  String initialZipCodeValue() => _zipCode;
  String initialOwnerPhoneValue() => _ownerPhone;
  OwnerId initializeOwnerId() => OwnerId(value: _ownerId);
  AddressId initializeAddressId() => AddressId(value: _addressId);
  OwnerEntity? initializeOwnerEntityValue() => _owner!;
  IdentityNumber? initialBoatIdentityValue() => IdentityNumber.unknown;
  bool initialAvailableValue() => _isAvailable;
  TypesOfBoat initialTypesOfBoatValue() => TypesOfBoat.unknown;
  CategoriesCNP initialCnpValue() => CategoriesCNP.unknown;
  List<Docking> initialDockingValue() => _docking;
  DateTime initialCreatedDateValue() => _initDate;
  DateTime datePickerFirstDate() => _minimal;
  DateTime datePickerLastDate() => _maximal;
  String initialRoleValue() => _raison;
  bool isNewBoatValue() => !_isNewBoat;
  DateTimeRange initDateRangeValue() => _initDateTimeRange;

  BoatNameFormz? setName(final String value) {
    try {
      if (value.isNotEmpty) {
        _name = value;
        if (_name.isNotEmpty) {
          return BoatNameFormz.pure('name: $_name');
        } else {
          return BoatNameFormz.dirty('dirty name: $_name');
        }
      }
    } on NameValidationError catch (e) {
      BoatNameFormz.showBoatNameErrorMessage(e);
      return null;
    }
    return null;
  }

  BoatRoleFormz? setRole(final String value) {
    try {
      if (value.isNotEmpty) {
        _raison = value;
        if (_raison.isNotEmpty) {
          return BoatRoleFormz.pure('raison: $_raison');
        } else {
          return BoatRoleFormz.dirty('dirty raison: $_raison');
        }
      }
    } on NameValidationError catch (e) {
      BoatRoleFormz.showBoatRoleErrorMessage(e);
      return null;
    }
    return null;
  }

  OwnerNameFormz? setOwnerName(final String value) {
    var name = _owner?.name;
    try {
      if (value.isNotEmpty) {
        _ownerName = value;
        if (_ownerName.isNotEmpty) {
          name = _ownerName;
          return OwnerNameFormz.pure('name: $name');
        } else {
          return OwnerNameFormz.dirty('dirty name: $name');
        }
      }
    } on NameValidationError catch (e) {
      OwnerNameFormz.showOwnerNameErrorMessage(e);
      return null;
    }
    return null;
  }

  CityNameFormz? setCityName(final String value) {
    var city = _address?.city;
    try {
      if (value.isNotEmpty) {
        _cityName = value;
        if (_cityName.isNotEmpty) {
          city = _cityName;
          return CityNameFormz.pure('name: $city');
        } else {
          return CityNameFormz.dirty('dirty name: $city');
        }
      }
    } on NameValidationError catch (e) {
      CityNameFormz.showCityNameErrorMessage(e);
      return CityNameFormz.dirty('error city: $city');
    }
    return null;
  }

  ZipCodeFormz? setZipCode(final String value) {
    var zip = _address?.zipcode;
    try {
      if (value.isNotEmpty) {
        _zipCode = value;
        if (_zipCode.isNotEmpty) {
          zip = _zipCode;
          return ZipCodeFormz.pure('zipcode: $zip');
        } else {
          return ZipCodeFormz.dirty('dirty zipcode: $zip');
        }
      }
    } on ZipcodeValidationError catch (e) {
      ZipCodeFormz.showZipCodeErrorMessage(e);
      return ZipCodeFormz.dirty('error zipcode: $zip');
    }
    return null;
  }

  OwnerPhoneFormz? setOwnerPhone(final String value) {
    var phone = _owner?.phone;
    try {
      if (value.isNotEmpty) {
        _ownerPhone = value;
        if (_ownerPhone.isNotEmpty) {
          phone = _ownerPhone;
          return OwnerPhoneFormz.pure('phone: $phone');
        } else {
          return OwnerPhoneFormz.dirty('dirty phone: $phone');
        }
      }
    } on PhoneFormatError catch (e) {
      OwnerPhoneFormz.showPhoneFormatErrorMessage(e);
      return OwnerPhoneFormz.dirty('error phone: $phone');
    }
    return null;
  }

  String? setBoatIdentity(final List<IdentityNumber> values) {
    for (var el in values) {
      switch (el) {
        case IdentityNumber.unknown:
          el = IdentityNumber.unknown;
          return el.name;
        case IdentityNumber.cin:
          el = IdentityNumber.cin;
          return el.name;
        case IdentityNumber.hin:
          el = IdentityNumber.hin;
          return el.name;
        case IdentityNumber.win:
          el = IdentityNumber.win;
          return el.name;
      }
    }
    return null;
  }

  String? setTypesBoat(final List<TypesOfBoat> values) {
    for (var el in values) {
      switch (el) {
        case TypesOfBoat.unknown:
          el = TypesOfBoat.unknown;
          return el.name;
        case TypesOfBoat.sailingShips:
          el = TypesOfBoat.sailingShips;
          return el.name;
        case TypesOfBoat.motorShips:
          el = TypesOfBoat.motorShips;
          return el.name;
        case TypesOfBoat.watercraft:
          el = TypesOfBoat.watercraft;
          return el.name;
        case TypesOfBoat.catamaran:
          el = TypesOfBoat.catamaran;
          return el.name;
        case TypesOfBoat.barge:
          el = TypesOfBoat.barge;
          return el.name;
        case TypesOfBoat.yacht:
          el = TypesOfBoat.yacht;
          return el.name;
      }
    }
    return null;
  }

  String? setDocking(final List<Docking> values) {
    for (var el in values) {
      switch (el) {
        case Docking.harbor:
          el = Docking.harbor;
          return el.name;
        case Docking.couple:
          el = Docking.couple;
          return el.name;
        case Docking.marinas:
          el = Docking.marinas;
          return el.name;
        case Docking.anchoring:
          el = Docking.anchoring;
          return el.name;
      }
    }
    return null;
  }

  String? setCategoryCnp(final List<CategoriesCNP> values) {
    for (var el in values) {
      switch (el) {
        case CategoriesCNP.unknown:
          el = CategoriesCNP.unknown;
          return el.name;
        case CategoriesCNP.a:
          el = CategoriesCNP.a;
          return el.name;
        case CategoriesCNP.b:
          el = CategoriesCNP.b;
          return el.name;
        case CategoriesCNP.c:
          el = CategoriesCNP.c;
          return el.name;
        case CategoriesCNP.d:
          el = CategoriesCNP.d;
          return el.name;
      }
    }
    return null;
  }

  setStartLocation(final DateTime value) => _initDateTimeRange.start;
  setStopLocation(final DateTime value) => _initDateTimeRange.end;
  setIsAvailable(final bool value) => _isAvailable = value;

  setAddressId(final int value) => AddressId(value: _addressId = value);
  setOwnerId(final int value) => OwnerId(value: _ownerId = value);

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
    } else {
      return value;
    }
  }

  String? validatePhone(String value) {
    if (value.isEmpty) {
      return 'Enter a phone';
    } else {
      return value;
    }
  }

  String? validateRole(String value) {
    if (value.isEmpty) {
      return 'Enter a raison';
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
        _initDateTimeRange.start.isAtSameMomentAs(_initDate)) {
      setIsAvailable(true);
      return 'this boat is available';
    } else {
      setIsAvailable(false);
      return 'this boat is not available or not exist';
    }
  }

  Stream<int> _setUp() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      subscription.onData((data) {
        controller.add(data);
      });
    });
    return controller.stream;
  }

/*
  Stream optionalMap(Stream<AppFormState<Boat>> source, addNewBoat) async* {
    if (addNewBoat == null) {
      yield* source;
    } else {
      await for (var event in source) {
        yield addNewBoat(event);
      }
    }
  }
*/

/*  @override
  AppFormState<Boat> get state {
    return state.when(
        init: AppFormState.init,
        process: AppFormState.process,
        success: AppFormState.success,
        error: AppFormState.error);
  }*/

/*  @override
  set state(AppFormState value) {
    state = AppFormState.success(value.data);
  }*/
}

final boatFormViewModelProvider =
    Provider.autoDispose.family<AddBoatFormViewModel, Boat?>((ref, boat) {
  final boatListViewModel =
      ref.read(boatListViewModelStateNotifierProvider.notifier);

  boat = ref.read(boatNotifierProvider);

  return AddBoatFormViewModel(boat, boatListViewModel);
});

// Future Provider
final boatListFutureProvider = FutureProvider.autoDispose
    .family<List<Boat>, AddBoatFormViewModel>((ref, filter) async {
  final boatListViewModel =
      ref.watch(boatListViewModelStateNotifierProvider.notifier);

  return boatListViewModel.addBoatLocation(
      filter._name,
      filter._ownerId,
      filter._addressId,
      filter._types,
      filter._boatIdentity,
      filter._cnp,
      filter._isAvailable,
      filter._initDate,
      filter._initDateTimeRange.start,
      filter._initDateTimeRange.end,
      filter._raison);
});

// UI read this to know what to display
final addBoatFutureProvider = FutureProvider<Boat?>((ref) {
  final boat = ref.watch(currentBoatProvider);
  if (boat != null) {
    return getBoat(boat);
  } else {
    return Boat.empty();
  }
});
