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
}

final boatNotifierProvider = StateNotifierProvider<BoatNotifier, Boat>((ref) =>
    BoatNotifier(const Boat(
        boatId: BoatId(value: 0),
        name: 'name',
        ownerEntity: OwnerEntity(
            id: 0, name: 'name', phone: 'phone', address: Address()),
        types: TypesOfBoat.yacht,
        identityNumber: IdentityNumber.cin,
        cnp: CategoriesCNP.c,
        isAvailable: false)));

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

final typesOfBoatNotifierProvider =
    StateNotifierProvider<TypesOfBoatNotifier, List<TypesOfBoat>>(
        (_) => TypesOfBoatNotifier(TypesOfBoat.values));
