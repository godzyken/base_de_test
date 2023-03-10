import 'package:base_de_test/features/transactions/domain/entities/entities.dart';
import 'package:base_de_test/features/transactions/domain/repositories/boats_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

class BoatNotifier extends StateNotifier<Boat> {
  BoatNotifier(super.state);

  void updateId(int id) {
    final count = id + 1 + DateTime.now().millisecondsSinceEpoch;
    state = state.copyWith.boatId!(value: count);
  }

  void updateName(String n) {
    state = state.copyWith(name: n);
  }

  void updateOwnerName(String o) {
    state = state.copyWith.ownerEntity!(name: o);
    int id = 2 + DateTime.now().millisecondsSinceEpoch;
    state = state.copyWith.ownerId!(value: id);
    state = state.copyWith.ownerEntity!.ownerId(value: id);
  }

  void updateCityName(String n) {
    state =
        state.copyWith(addressEntity: state.addressEntity?.copyWith(city: n));
    int id = 3 + DateTime.now().millisecondsSinceEpoch;
    state = state.copyWith(addressId: state.addressId?.copyWith(value: id));
    state = state.copyWith.addressEntity!.id!(value: id);
  }

  void updateOwnerPhone(String p) {
    state = state.copyWith(ownerEntity: state.ownerEntity?.copyWith(phone: p));
  }

  void updateRole(String r) {
    state = state.copyWith(role: r);
  }

  void updateCreatedDate(String d) {
    state = state.copyWith(createdAt: DateTime.parse(d));
  }

  void updateRentalDate(String d) {
    state = state.copyWith(rentedAt: DateTime.parse(d));
  }

  void updateReturnedDate(String d) {
    state = state.copyWith(returnedAt: DateTime.parse(d));
  }

  void setRemovedDate(String r) {
    state = state.copyWith(deletedAt: DateTime.parse(r));
  }

  void updateTypes(String t) {
    state = state.copyWith(types: TypesOfBoat.values.byName(t));
  }

  void updateIdentityNumber(String nb) {
    state = state.copyWith(identityNumber: IdentityNumber.values.byName(nb));
  }

  void updateCategory(String cnp) {
    state = state.copyWith(cnp: CategoriesCNP.values.byName(cnp));
  }

  void updateIsAvailableValue(bool b) {
    state = state.copyWith(isAvailable: b, isChecked: b);
  }

  void updateDockingTypeValue(String d) {
    state = state.copyWith(
        addressEntity:
            state.addressEntity?.copyWith(docking: Docking.values.byName(d)));
  }

  void updateZipCode(String z) {
    state = state.copyWith(
        addressEntity: state.addressEntity?.copyWith(zipcode: z));
  }
}

class TypesOfBoatNotifier extends StateNotifier<List<TypesOfBoat>> {
  TypesOfBoatNotifier(super.state);

  String? selectTypes(TypesOfBoat typesOfBoat) {
    switch (typesOfBoat) {
      case TypesOfBoat.barge:
        typesOfBoat = TypesOfBoat.barge;
        return typesOfBoat.name;
      case TypesOfBoat.catamaran:
        typesOfBoat = TypesOfBoat.catamaran;
        return typesOfBoat.name;
      case TypesOfBoat.sailingShips:
        typesOfBoat = TypesOfBoat.sailingShips;
        return typesOfBoat.name;
      case TypesOfBoat.motorShips:
        typesOfBoat = TypesOfBoat.motorShips;
        return typesOfBoat.name;
      case TypesOfBoat.watercraft:
        typesOfBoat = TypesOfBoat.watercraft;
        return typesOfBoat.name;
      case TypesOfBoat.yacht:
        typesOfBoat = TypesOfBoat.yacht;
        return typesOfBoat.name;
      case TypesOfBoat.unknown:
        typesOfBoat = TypesOfBoat.unknown;
        return typesOfBoat.name;
    }
  }
}

class CategoryCnpNotifier extends StateNotifier<List<CategoriesCNP>> {
  CategoryCnpNotifier(super.state);

  String? selectCategoriesCNP(CategoriesCNP cat) {
    switch (cat) {
      case CategoriesCNP.a:
        cat = CategoriesCNP.a;
        return cat.name;
      case CategoriesCNP.b:
        cat = CategoriesCNP.b;
        return cat.name;
      case CategoriesCNP.c:
        cat = CategoriesCNP.c;
        return cat.name;
      case CategoriesCNP.d:
        cat = CategoriesCNP.d;
        return cat.name;
    }
  }
}

class OwnerEntityNotifier extends StateNotifier<OwnerEntity> {
  OwnerEntityNotifier(super.state);

  void updateOwnerId(int i) {
    final count = i + 1 + DateTime.now().millisecondsSinceEpoch;
    state = state.copyWith.ownerId(value: count);
  }

  void updateOwnerName(String n) {
    state = state.copyWith(name: n);
  }

  void updateOwnerPhone(String p) {
    state = state.copyWith(phone: p);
  }
}

class AddressNotifier extends StateNotifier<AddressEntity> {
  AddressNotifier(super.state);

  void updateCity(String c) {
    state = state.copyWith(city: c);
  }

  void updateDocking(Docking s) {
    state = state.copyWith(docking: s);
  }

  void updateZipCode(String z) {
    state = state.copyWith(zipcode: z);
  }

  void updateGeo(GeoEntity g) {
    state = state.copyWith(geo: g);
  }
}

class GeoNotifier extends StateNotifier<GeoEntity> {
  GeoNotifier(super.state);

  void updateLat(double d) {
    state = state.copyWith(lat: d);
  }

  void updateLong(double lon) {
    state = state.copyWith(lng: lon);
  }
}

class DockingNotifier extends StateNotifier<List<Docking>> {
  DockingNotifier(super.state);

  String? selectDockingType(Docking doc) {
    switch (doc) {
      case Docking.harbor:
        doc = Docking.harbor;
        return doc.name;
      case Docking.couple:
        doc = Docking.couple;
        return doc.name;
      case Docking.marinas:
        doc = Docking.marinas;
        return doc.name;
      case Docking.anchoring:
        doc = Docking.anchoring;
        return doc.name;
    }
  }
}

class IdentityNumberNotifier extends StateNotifier<List<IdentityNumber>> {
  IdentityNumberNotifier(super.state);

  String? selectIdentityNumber(IdentityNumber number) {
    switch (number) {
      case IdentityNumber.cin:
        number = IdentityNumber.cin;
        return number.name;
      case IdentityNumber.hin:
        number = IdentityNumber.hin;
        return number.name;
      case IdentityNumber.win:
        number = IdentityNumber.win;
        return number.name;
      case IdentityNumber.unknown:
        number = IdentityNumber.unknown;
        return number.name;
    }
  }
}

class BoatFormStateNotifier extends StateNotifier<FormBoatAddState> {
  BoatFormStateNotifier(this._repository)
      : super(FormBoatAddState(Boat.empty()));

  final BoatsRepository _repository;

  FormzSubmissionStatus? validator(Boat? b) {
    if (b!.name.isEmpty) {
      return FormzSubmissionStatus.failure;
    } else {
      return FormzSubmissionStatus.inProgress;
    }
  }

  void addBoat(Boat b) async {
    Boat form = state.form.copyWith(
        boatId: b.boatId,
        ownerEntity: b.ownerEntity,
        name: b.name,
        identityNumber: b.identityNumber,
        createdAt: b.createdAt,
        types: b.types,
        rentedAt: b.rentedAt,
        cnp: b.cnp,
        role: b.role,
        isAvailable: b.isAvailable,
        returnedAt: b.returnedAt,
        isChecked: b.isChecked,
        deletedAt: b.deletedAt);

    late Boat boat;

    if (form.isAvailable) {
      boat = form.copyWith(isAvailable: true);
    } else {
      boat = form.copyWith(isAvailable: false);
    }

    state = state.copyWith(form: form.copyWith(boatId: boat.boatId));
  }

  @override
  void dispose() {
    _repository.closeDatabase();
    super.dispose();
  }
}

// providers
final boatNotifierProvider = StateNotifierProvider<BoatNotifier, Boat>((ref) =>
    BoatNotifier(Boat(
        boatId: const BoatId(value: 0),
        name: 'name',
        ownerEntity: const OwnerEntity(
            ownerId: OwnerId(value: 0), name: 'name', phone: 'phone'),
        addressId: const AddressId(value: 0),
        addressEntity: const AddressEntity(
            id: AddressId(value: 0),
            docking: Docking.anchoring,
            city: 'city',
            zipcode: 'zip_code',
            geo: GeoEntity()),
        types: TypesOfBoat.yacht,
        identityNumber: IdentityNumber.cin,
        cnp: CategoriesCNP.c,
        createdAt: DateTime.now(),
        isAvailable: false,
        ownerId: const OwnerId(value: 0))));

final typesOfBoatNotifierProvider =
    StateNotifierProvider<TypesOfBoatNotifier, List<TypesOfBoat>>(
        (_) => TypesOfBoatNotifier(TypesOfBoat.values));

final categoriesCnpNotifierProvider =
    StateNotifierProvider<CategoryCnpNotifier, List<CategoriesCNP>>(
        (_) => CategoryCnpNotifier(CategoriesCNP.values));

final ownerEntityNotifierProvider =
    StateNotifierProvider<OwnerEntityNotifier, OwnerEntity>((ref) =>
        OwnerEntityNotifier(const OwnerEntity(
            ownerId: OwnerId(value: 0),
            name: 'ownerName',
            phone: 'ownerPhone')));

final addressNotifierProvider =
    StateNotifierProvider<AddressNotifier, AddressEntity>((_) =>
        AddressNotifier(const AddressEntity(
            id: AddressId(value: 0),
            city: 'city',
            docking: Docking.anchoring,
            zipcode: 'zipCode',
            geo: GeoEntity())));

final dockingNotifierProvider =
    StateNotifierProvider<DockingNotifier, List<Docking>>(
        (_) => DockingNotifier(Docking.values));

final identityNumberNotifierProvider =
    StateNotifierProvider<IdentityNumberNotifier, List<IdentityNumber>>(
        (_) => IdentityNumberNotifier(IdentityNumber.values));

final geoNotifierProvider = StateNotifierProvider<GeoNotifier, GeoEntity>(
    (_) => GeoNotifier(const GeoEntity(lat: 0.0, lng: 0.0)));

final boatFormStateNotifierProvider =
    StateNotifierProvider<BoatFormStateNotifier, FormBoatAddState>((ref) {
  final form = ref.notifier;
  final boatNotifier = ref.refresh(boatNotifierProvider.notifier);

  form.addListener((state) {});

  return form;
});
