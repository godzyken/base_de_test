import 'package:base_de_test/features/transactions/domain/entities/entities.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

Future<Boat> getBoat(Boat boat) {
  return Future.delayed(
      const Duration(seconds: 1),
      () => Boat(
          boatId: boat.boatId,
          name: boat.name,
          ownerId: boat.ownerId,
          addressId: boat.addressId,
          isAvailable: boat.isAvailable,
          createdAt: boat.createdAt,
          rentedAt: boat.rentedAt,
          returnedAt: boat.returnedAt,
          role: boat.role));
}

// State Provider
// Will change by the UI
// Ui  writes to this and reads from this
final currentBoatProvider = StateProvider<Boat?>((ref) => null);
final clockProvider = StateProvider((ref) => DateTime.now());

// state notifiers
class BoatNotifier extends StateNotifier<Boat> {
  BoatNotifier([Boat? boat]) : super(boat ?? Boat.empty());

  Boat? previousState;

  void updateId(int id) {
    var count = id + 1 + DateTime.now().millisecondsSinceEpoch;
    state = state.copyWith.boatId!(value: count);
  }

  void updateName(String n) {
    state = state.copyWith(name: n);
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
}

class TypesOfBoatNotifier extends StateNotifier<List<TypesOfBoat>> {
  TypesOfBoatNotifier(super.state);

  void addTypes(TypesOfBoat typesOfBoat) => state = [...state, typesOfBoat];

  void removeTypes(TypesOfBoat typesOfBoat) =>
      state = [...state..remove(typesOfBoat)];

  String? selectTypes(TypesOfBoat typesOfBoat) {
    switch (typesOfBoat) {
      case TypesOfBoat.barge:
        typesOfBoat = TypesOfBoat.barge;
        state = [...state..elementAt(typesOfBoat.index)];
        return typesOfBoat.name;
      case TypesOfBoat.catamaran:
        typesOfBoat = TypesOfBoat.catamaran;
        state = [...state..elementAt(typesOfBoat.index)];
        return typesOfBoat.name;
      case TypesOfBoat.sailingShips:
        typesOfBoat = TypesOfBoat.sailingShips;
        state = [...state..elementAt(typesOfBoat.index)];

        return typesOfBoat.name;
      case TypesOfBoat.motorShips:
        typesOfBoat = TypesOfBoat.motorShips;
        state = [...state..elementAt(typesOfBoat.index)];

        return typesOfBoat.name;
      case TypesOfBoat.watercraft:
        typesOfBoat = TypesOfBoat.watercraft;
        state = [...state..elementAt(typesOfBoat.index)];

        return typesOfBoat.name;
      case TypesOfBoat.yacht:
        typesOfBoat = TypesOfBoat.yacht;
        state = [...state..elementAt(typesOfBoat.index)];

        return typesOfBoat.name;
      case TypesOfBoat.unknown:
        typesOfBoat = TypesOfBoat.unknown;
        state = [...state..elementAt(typesOfBoat.index)];

        return typesOfBoat.name;
    }
  }
}

class CategoryCnpNotifier extends StateNotifier<List<CategoriesCNP>> {
  CategoryCnpNotifier(super.state);

  void addCat(CategoriesCNP categoriesCNP) => state = [...state, categoriesCNP];

  void removeCat(CategoriesCNP categoriesCNP) =>
      state = [...state..remove(categoriesCNP)];

  String? selectCategoriesCNP(CategoriesCNP cat) {
    switch (cat) {
      case CategoriesCNP.a:
        cat = CategoriesCNP.a;
        state = [...state..elementAt(cat.index)];
        return cat.name;
      case CategoriesCNP.b:
        cat = CategoriesCNP.b;
        state = [...state..elementAt(cat.index)];
        return cat.name;
      case CategoriesCNP.c:
        cat = CategoriesCNP.c;
        state = [...state..elementAt(cat.index)];
        return cat.name;
      case CategoriesCNP.d:
        cat = CategoriesCNP.d;
        state = [...state..elementAt(cat.index)];
        return cat.name;
      case CategoriesCNP.unknown:
        cat = CategoriesCNP.unknown;
        state = [...state..elementAt(cat.index)];
        return cat.name;
    }
  }
}

class DockingNotifier extends StateNotifier<List<Docking>> {
  DockingNotifier(super.state);

  void addDoc(Docking docking) => state = [...state, docking];

  void removeDoc(Docking docking) => state = [...state..remove(docking)];

  String? selectDockingType(Docking doc) {
    switch (doc) {
      case Docking.harbor:
        doc = Docking.harbor;
        state = [...state..elementAt(doc.index)];
        return doc.name;
      case Docking.couple:
        doc = Docking.couple;
        state = [...state..elementAt(doc.index)];

        return doc.name;
      case Docking.marinas:
        doc = Docking.marinas;
        state = [...state..elementAt(doc.index)];

        return doc.name;
      case Docking.anchoring:
        doc = Docking.anchoring;
        state = [...state..elementAt(doc.index)];

        return doc.name;
    }
  }
}

class IdentityNumberNotifier extends StateNotifier<List<IdentityNumber>> {
  IdentityNumberNotifier(super.state);

  void addIdentity(IdentityNumber idN) => state = [...state, idN];

  void removeIdentity(IdentityNumber idN) => state = [...state..remove(idN)];

  String? selectIdentityNumber(IdentityNumber number) {
    switch (number) {
      case IdentityNumber.cin:
        number = IdentityNumber.cin;
        state = [...state..elementAt(number.index)];
        return number.name;
      case IdentityNumber.hin:
        number = IdentityNumber.hin;
        state = [...state..elementAt(number.index)];

        return number.name;
      case IdentityNumber.win:
        number = IdentityNumber.win;
        state = [...state..elementAt(number.index)];

        return number.name;
      case IdentityNumber.unknown:
        number = IdentityNumber.unknown;
        state = [...state..elementAt(number.index)];

        return number.name;
    }
  }
}

class OwnerEntityNotifier extends StateNotifier<OwnerEntity> {
  OwnerEntityNotifier(super.state);

  void updateOwnerId(int i) {
    var count = i + 2 + DateTime.now().millisecondsSinceEpoch;
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

  void updateAddressId(int i) {
    var count = i + 3 + DateTime.now().millisecondsSinceEpoch;
    state = state.copyWith.id!(value: count);
  }

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
    state = state.copyWith(geo: g.toString());
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

class BoatFormStateController extends StateNotifier<FormBoatAddState> {
  BoatFormStateController()
      : super(FormBoatAddState(
            Boat.empty(), OwnerEntity.empty(), AddressEntity.empty()));

  FormzSubmissionStatus? isBoat(Boat? b) {
    if (b!.name.isEmpty && b.isAvailable == false) {
      state = state.copyWith(status: FormzSubmissionStatus.failure);
      return FormzSubmissionStatus.failure;
    } else {
      state = state.copyWith(status: FormzSubmissionStatus.success);
      return FormzSubmissionStatus.success;
    }
  }

  FormzSubmissionStatus? isOwner(OwnerEntity? ownerEntity) {
    if (ownerEntity!.name.isEmpty && ownerEntity.phone.isEmpty) {
      state = state.copyWith(status: FormzSubmissionStatus.failure);
      return FormzSubmissionStatus.failure;
    } else {
      state = state.copyWith(status: FormzSubmissionStatus.success);
      return FormzSubmissionStatus.success;
    }
  }

  FormzSubmissionStatus? isAddress(AddressEntity? addressEntity) {
    if (addressEntity!.city.isEmpty || addressEntity.docking.name.isEmpty) {
      state = state.copyWith(status: FormzSubmissionStatus.failure);
      return FormzSubmissionStatus.failure;
    } else {
      state = state.copyWith(status: FormzSubmissionStatus.success);
      return FormzSubmissionStatus.success;
    }
  }

  void addBoat(Boat b) async {
    Boat form = state.boat.copyWith(
        boatId: b.boatId,
        ownerId: b.ownerId,
        addressId: b.addressId,
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

    if (form.isAvailable == true) {
      boat = form;
      state = state.copyWith(status: FormzSubmissionStatus.success);
      state = state.copyWith(boat: boat);
    } else {
      state = state.copyWith(status: FormzSubmissionStatus.failure);
    }

    state = state.copyWith(boat: boat);
  }

  void addOwner(OwnerEntity o) async {
    OwnerEntity form = state.ownerEntity.copyWith(
        ownerId: o.ownerId, name: o.name, phone: o.phone, isValid: o.isValid);

    late OwnerEntity ownerEntity;

    if (form.isValid == true) {
      ownerEntity = form;
      state = state.copyWith(status: FormzSubmissionStatus.success);
    } else {
      state = state.copyWith(status: FormzSubmissionStatus.failure);
    }

    state = state.copyWith(ownerEntity: ownerEntity);
  }

  void addAddress(AddressEntity a) async {
    AddressEntity form = state.addressEntity.copyWith(
        id: a.id,
        docking: a.docking,
        zipcode: a.zipcode,
        city: a.city,
        geo: a.geo);

    late AddressEntity addressEntity;

    if (form.docking.name.isNotEmpty) {
      addressEntity = form;
      state = state.copyWith(status: FormzSubmissionStatus.success);
    } else {
      state = state.copyWith(status: FormzSubmissionStatus.failure);
    }

    state = state.copyWith(addressEntity: addressEntity);
  }

  @override
  bool updateShouldNotify(FormBoatAddState old, FormBoatAddState current) {
    return current.boatNameFormz!.isValid;
  }
}

// state notifier providers
final boatNotifierProvider = StateNotifierProvider<BoatNotifier, Boat>((ref) {
  final now = ref.read(clockProvider);
  final diff = now.add(const Duration(days: 5));
  return BoatNotifier(Boat(
      boatId: const BoatId(value: 0),
      name: 'name',
      addressId: const AddressId(value: 0),
      types: TypesOfBoat.unknown,
      identityNumber: IdentityNumber.unknown,
      cnp: CategoriesCNP.unknown,
      createdAt: now,
      isAvailable: false,
      ownerId: const OwnerId(value: 0),
      rentedAt: now,
      returnedAt: diff,
      role: 'role'));
});

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
            phone: 'ownerPhone',
            isValid: false)));

final addressNotifierProvider =
    StateNotifierProvider<AddressNotifier, AddressEntity>((_) =>
        AddressNotifier(const AddressEntity(
            id: AddressId(value: 0),
            city: 'city',
            docking: Docking.anchoring,
            zipcode: 'zipCode',
            geo: 'GeoEntity()',
            isValid: false)));

final dockingNotifierProvider =
    StateNotifierProvider<DockingNotifier, List<Docking>>(
        (_) => DockingNotifier(Docking.values));

final identityNumberNotifierProvider =
    StateNotifierProvider<IdentityNumberNotifier, List<IdentityNumber>>(
        (_) => IdentityNumberNotifier(IdentityNumber.values));

final geoNotifierProvider = StateNotifierProvider<GeoNotifier, GeoEntity>(
    (_) => GeoNotifier(const GeoEntity(lat: 0.0, lng: 0.0)));

final boatFormStateNotifierProvider =
    StateNotifierProvider<BoatFormStateController, FormBoatAddState>(
        (ref) => BoatFormStateController());
