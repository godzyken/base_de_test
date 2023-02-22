import 'package:base_de_test/features/transactions/domain/entities/entities.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoatNotifier extends StateNotifier<Boat> {
  BoatNotifier(super.state);

  void updateId(BoatId i) {
    state = state.copyWith(boatId: i);
  }

  void updateName(String n) {
    state = state.copyWith(name: n);
  }

  void updateOwnerEntity(OwnerEntity o) {
    state = state.copyWith(ownerEntity: o);
  }

  void updateTypes(TypesOfBoat t) {
    state = state.copyWith(types: t);
  }

  void updateIdentityNumber(IdentityNumber nb) {
    state = state.copyWith(identityNumber: nb);
  }

  void updateCategory(CategoriesCNP cnp) {
    state = state.copyWith(cnp: cnp);
  }

  void updateIsAvailableValue(bool b) {
    state = state.copyWith(isAvailable: b);
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
    state = state.copyWith(id: i);
  }

  void updateOwnerName(String n) {
    state = state.copyWith(name: n);
  }

  void updateOwnerPhone(String p) {
    state = state.copyWith(phone: p);
  }

  void updateOwnerAddress(Address? p) {
    state = state.copyWith(address: p!);
  }
}

class AddressNotifier extends StateNotifier<Address> {
  AddressNotifier(super.state);

  void updateCity(String c) {
    state = state.copyWith(city: c);
  }

  void updateStreet(String s) {
    state = state.copyWith(street: s);
  }

  void updateZipCode(String z) {
    state = state.copyWith(zipcode: z);
  }

  void updateSuite(String s) {
    state = state.copyWith(suite: s);
  }

  void updateGeo(Geo g) {
    state = state.copyWith(geo: g);
  }
}

class GeoNotifier extends StateNotifier<Geo> {
  GeoNotifier(super.state);

  void updateLat(double d) {
    state = state.copyWith(lat: d);
  }

  void updateLong(double lon) {
    state = state.copyWith(lng: lon);
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
    }
  }
}

// providers
final boatNotifierProvider = StateNotifierProvider<BoatNotifier, Boat>((ref) =>
    BoatNotifier(Boat(
        boatId: const BoatId(value: 0),
        name: 'name',
        ownerEntity: const OwnerEntity(
            id: 0, name: 'name', phone: 'phone', address: Address()),
        types: TypesOfBoat.yacht,
        identityNumber: IdentityNumber.cin,
        cnp: CategoriesCNP.c,
        createdAt: DateTime.now(),
        isAvailable: false)));

final typesOfBoatNotifierProvider =
    StateNotifierProvider<TypesOfBoatNotifier, List<TypesOfBoat>>(
        (_) => TypesOfBoatNotifier(TypesOfBoat.values));

final categoriesCnpNotifierProvider =
    StateNotifierProvider<CategoryCnpNotifier, List<CategoriesCNP>>(
        (_) => CategoryCnpNotifier(CategoriesCNP.values));

final ownerEntityNotifierProvider =
    StateNotifierProvider<OwnerEntityNotifier, OwnerEntity>((ref) =>
        OwnerEntityNotifier(const OwnerEntity(
            id: 0,
            name: 'ownerName',
            phone: 'ownerPhone',
            address: Address())));

final addressNotifierProvider = StateNotifierProvider<AddressNotifier, Address>(
    (_) => AddressNotifier(const Address(
        city: 'city',
        street: 'street',
        suite: 'suite',
        zipcode: 'zipCode',
        geo: Geo())));

final identityNumberNotifierProvider =
    StateNotifierProvider<IdentityNumberNotifier, List<IdentityNumber>>(
        (_) => IdentityNumberNotifier(IdentityNumber.values));

final geoNotifierProvider = StateNotifierProvider<GeoNotifier, Geo>(
    (_) => GeoNotifier(const Geo(lat: 0.0, lng: 0.0)));
