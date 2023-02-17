import 'package:freezed_annotation/freezed_annotation.dart';

import 'boat_entity.dart';
import 'boat_id.dart';

part 'boat_list_entity.freezed.dart';

@freezed
class BoatList with _$BoatList {
  const factory BoatList({required List<Boat> values}) = _BoatList;

  const BoatList._();

  operator [](final int index) => values[index];

  int get length => values.length;

  BoatList addBoat(final Boat boat) => copyWith(values: [...values, boat]);

  BoatList updateBoat(final Boat newBoat) {
    return copyWith(
        values: values
            .map((boat) => newBoat.boatId == boat.boatId ? newBoat : boat)
            .toList());
  }

  BoatList removeBoatById(final BoatId id) =>
      copyWith(values: values.where((boat) => boat.isAvailable).toList());

  BoatList filterByComplete() =>
      copyWith(values: values.where((boat) => boat.isAvailable).toList());

  BoatList filterByIncomplete() =>
      copyWith(values: values.where((boat) => !boat.isAvailable).toList());
}
