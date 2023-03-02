import 'package:freezed_annotation/freezed_annotation.dart';

import '../boat/boat_entity.dart';

part 'form_boat_add.freezed.dart';

@freezed
class FormBoatAddState with _$FormBoatAddState {
  const factory FormBoatAddState(Boat form) = _FormBoatAddState;
}
