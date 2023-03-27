import 'dart:async';
import 'dart:developer' as developer;

import 'package:base_de_test/features/auth/domain/entities/user_properties/name.dart';
import 'package:base_de_test/features/transactions/domain/entities/boat_properties/boat_name.dart';
import 'package:base_de_test/features/transactions/domain/entities/owner_properties/owner_name.dart';
import 'package:base_de_test/features/transactions/presentation/controller/boat_notifier.dart';
import 'package:base_de_test/features/transactions/presentation/viewmodel/boatlist/boat_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/address_properties/docking.dart';
import '../../../domain/entities/entities.dart';

class AddBoatFormViewModel extends StreamNotifier<AsyncValue<Boat>> {
  AddBoatFormViewModel(final Boat? boat, this._boatListViewModel) {
    _initBoat(boat);
  }
  final BoatListViewModel _boatListViewModel;

  late BoatId boatId;
  late OwnerId _ownerId;
  late AddressId _addressId;
  late StreamSubscription subscription;
  StreamController<int> controller = StreamController<int>();

  final int _id = 0;
  var _name = '';
  OwnerEntity? _owner;
  AddressEntity? _address;
  var _ownerName = '';
  var _cityName = '';
  var _zipCode = '';
  var _ownerPhone = '';
  var _isAvailable = false;
  IdentityNumber _boatIdentity = IdentityNumber.unknown;
  TypesOfBoat _types = TypesOfBoat.unknown;
  CategoriesCNP _cnp = CategoriesCNP.unknown;
  List<Docking> _docking = Docking.values;
  final DateTime _initDate = DateTime.now();
  final DateTime _removeDate = DateTime.now();
  final DateTime _minimal = DateTime(DateTime.now().year);
  final DateTime _maximal = DateTime(DateTime.now().year + 5);
  final DateTimeRange _initDateTimeRange = DateTimeRange(
      start: DateTime.now(), end: DateTime.now().add(const Duration(days: 7)));

  var _raison = '';
  var _isNewBoat = false;
  int newId = 0;

  _initBoat(final Boat? boat) {
    subscription = _setUp().listen(
      (event) {
        _boatListViewModel.addListener((state) {
          if (state.isInit && boat!.isAvailable) {
            state.dataStream!.where((element) {
              for (var e in element.values) {
                newId != 0 ? _id : e.boatId!.value;
                createOrUpdateBoat();
                return true;
              }

              return false;
            });
          }
        });
      },
    );

    developer.log('subscription: $subscription');
    if (boat == null && newId == 0) {
      _isNewBoat = true;
      // _ownerId = boat!.ownerId!;
      // _addressId = boat.addressId!;
    } else {
      boatId = boat!.boatId!;
      _name = boat.name;
      _ownerId = boat.ownerId!;
      _addressId = boat.addressId!;
      _boatIdentity = boat.identityNumber;
      _types = boat.types;
      _cnp = boat.cnp;
      _docking = [];
      _isAvailable = boat.isAvailable;
    }
  }

  createOrUpdateBoat() {
    if (_isNewBoat && newId >= 0) {
      boatId = boatId.copyWith(value: newId++);
      developer.log('message boat id : $boatId');
      _addressId = setAddressId(newId++);
      _ownerId = setOwnerId(newId++);
      _boatListViewModel.addBoatLocation(
        _name,
        _ownerId,
        _isAvailable,
        _addressId,
        _boatIdentity,
        _types,
        _cnp,
        _initDate,
        _removeDate,
        _initDateTimeRange.start,
        _initDateTimeRange.end,
        _raison,
      );
    } else {
      final oldBoat = Boat(
        boatId: BoatId(value: boatId.value),
        name: _name,
        addressId: _addressId,
        types: _types,
        identityNumber: _boatIdentity,
        cnp: _cnp,
        isAvailable: _isAvailable,
        createdAt: _initDate,
        role: _raison,
        ownerId: _ownerId,
        rentedAt: _initDateTimeRange.start,
        returnedAt: _initDateTimeRange.end,
      );
      _boatListViewModel.updateBoat(oldBoat);
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
  OwnerId initializeOwnerId() => _ownerId;
  AddressId initializeAddressId() => _addressId;
  OwnerEntity? initializeOwnerEntityValue() => _owner!;
  IdentityNumber? initialBoatIdentityValue() => _boatIdentity;
  bool initialAvailableValue() => _isAvailable;
  TypesOfBoat initialTypesOfBoatValue() => _types;
  CategoriesCNP initialCnpValue() => _cnp;
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

  setAddressId(final int value) => _addressId.copyWith(value: value);
  setOwnerId(final int value) => _ownerId.copyWith(value: value);

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

  Stream<int> _setUp() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      subscription.onData((data) {
        controller.add(data);
      });
    });
    return controller.stream;
  }

  @override
  Stream<AsyncData<Boat>> build() {
    // TODO: implement build
    throw UnimplementedError();
  }
}

final boatFormViewModelProvider =
    Provider.autoDispose.family<AddBoatFormViewModel, Boat?>((ref, boat) {
  developer.log('boat: $boat');
  final boatListViewModel =
      ref.watch(boatListViewModelStateNotifierProvider.notifier);
  developer.log('boatListViewModel: $boatListViewModel');

  final nextBoat = ref.watch(boatNotifierProvider.notifier);

/*  final state = ref.state;
  state.subscription.onData((data) {
    ref.container.listen(boatStreamProvider, (previous, next) {
      var boatRin = Boat(
          boatId: previous?.value?.boatId,
          name: previous!.value!._name,
          ownerId: previous.value!._ownerId,
          addressId: previous.value!._addressId,
          isAvailable: previous.value!._isAvailable,
          createdAt: previous.value!._initDate);

      if (boatRin.boatId != next.value?.boatId) {
        if (next.asData != null) {
          final newBoat = Boat(
          boatId: next.value!.boatId,
          name: next.value!._name,
          ownerId: next.value!._ownerId,
          addressId: next.value!._addressId,
          isAvailable: next.value!._isAvailable,
          createdAt: next.value!._initDate,
        );
          boatRin = newBoat;
        }

      }
    });
    return state.subscription.resume();
  });*/

  ref.keepAlive();
  return AddBoatFormViewModel(nextBoat.debugState, boatListViewModel);
});

final boatListFutureProvider = FutureProvider.autoDispose
    .family<List<Boat>, AddBoatFormViewModel>((ref, filter) async {
  final boatListViewModel =
      ref.watch(boatListViewModelStateNotifierProvider.notifier);

  return boatListViewModel.addBoatLocation(
      filter._name,
      filter._ownerId,
      filter._isAvailable,
      filter._addressId,
      filter._boatIdentity,
      filter._types,
      filter._cnp,
      filter._initDate,
      filter._removeDate,
      filter._initDateTimeRange.start,
      filter._initDateTimeRange.end,
      filter._raison);
});

final boatStreamProvider =
    StreamProvider.autoDispose<AddBoatFormViewModel>((ref) async* {
  final boat = ref.listen(boatFormStateNotifierProvider, (previous, next) {
    ref.state.isRefreshing;
    ref.state.isLoading;
    ref.state.isReloading;
    ref.state.unwrapPrevious();

    if (next.status == previous?.status) {
      next.status;
    }
    previous?.status;
  });
  ref.keepAlive();
  final addBoat = AddBoatFormViewModel(boatNotifierProvider.read(ref.container),
      boatListViewModelStateNotifierProvider.notifier.read(ref.container));

  ref.onDispose(() => addBoat.subscription.asFuture());

  ref.onAddListener(() {
    addBoat.subscription.onDone(() {
      boat.read();
    });

    addBoat.subscription.onData((data) {
      boat.read();
    });

    addBoat.controller.onListen;

    addBoat.controller.add(boat.read().boat.boatId!.value);
  });

  ref.onRemoveListener(() {
    boat.close();
    addBoat.subscription.cancel();
  });

  ref.onCancel(() {
    boat.close();
    addBoat.subscription.cancel();
  });

  ref.onResume(() {
    boat.close();
    addBoat.subscription.resume();
  });

  await for (final value in addBoat.controller.stream) {
    if (value == 10) addBoat.controller.sink.close();

    yield addBoat;
  }
});
