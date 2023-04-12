import 'package:base_de_test/features/transactions/application/datasource/database/boat_database_impl.dart';
import 'package:base_de_test/features/transactions/application/datasource/database/source_base.dart';
import 'package:base_de_test/features/transactions/application/datasource/repository/address_repository_impl.dart';
import 'package:base_de_test/features/transactions/application/datasource/repository/boats_repository_impl.dart';
import 'package:base_de_test/features/transactions/application/datasource/repository/owner_repository_impl.dart';
import 'package:base_de_test/features/transactions/domain/repositories/address_repository.dart';
import 'package:base_de_test/features/transactions/domain/repositories/boats_repository.dart';
import 'package:base_de_test/features/transactions/domain/repositories/owner_repository.dart';
import 'package:base_de_test/features/transactions/presentation/controller/boat_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

final boatsDatabaseProvider =
    Provider<SourceBase>((_) => BoatDatabaseImpl.instance);

//<-----------------------[Boat]------------------------------------>//

final boatsRepoProvider = Provider<BoatsRepository>(
    (ref) => BoatsRepositoryImpl(ref.watch(boatsDatabaseProvider)));
final boatFutureProvider = FutureProvider.autoDispose((ref) async {
  final response = boatsDatabaseProvider.read(ref.container);
  ref.onDispose(() => response.close());

  final handler = boatsRepoProvider.read(ref.container);
  ref.onDispose(() => handler.closeDatabase());

  final form =
      boatFormStateNotifierProvider.notifier.select((value) => value.stream);
  form.select((value) => value.listen((event) {
        do {
          final boatEntity = event.boat.toJson();
          response.insertBoat(boatEntity);
        } while (event.boat.isAvailable);
      }));
  ref.keepAlive();
  return response;
});

//<-----------------------[Owner]------------------------------------>//

final ownerRepoProvider = Provider<OwnerRepository>(
    (ref) => OwnerRepositoryImpl(ref.watch(boatsDatabaseProvider)));
final ownerFutureProvider = FutureProvider.autoDispose((ref) async {
  final response = boatsDatabaseProvider.read(ref.container);
  ref.onDispose(() => response.close());

  final handler = ownerRepoProvider.read(ref.container);
  ref.onDispose(() => handler.closeDatabase());

  final form =
      boatFormStateNotifierProvider.notifier.select((value) => value.stream);
  form.select((value) {
    value.listen((event) {
      do {
        final ownerEntity = event.ownerEntity.toJson();
        if (ownerEntity.isNotEmpty) {
          handler.createOwner(
              event.formOwnerAddState!.ownerNameFormz!.value,
              event.formOwnerAddState!.ownerPhoneFormz!.value,
              event.formOwnerAddState!.status!.isSuccess);
          response.insertOwner(ownerEntity);
        }
      } while (event.ownerEntity.isValid);
    });
  });
  ref.keepAlive();
  return response;
});

//<-----------------------[Address]------------------------------------>//

final addressRepoProvider = Provider<AddressRepository>(
    (ref) => AddressRepositoryImpl(ref.watch(boatsDatabaseProvider)));
final addressFutureProvider = FutureProvider.autoDispose((ref) async {
  final response = boatsDatabaseProvider.read(ref.container);
  ref.onDispose(() => response.close());

  final handler = addressRepoProvider.read(ref.container);
  ref.onDispose(() => handler.closeDatabase());

  final form =
      boatFormStateNotifierProvider.notifier.select((value) => value.stream);
  form.select((value) {
    value.listen((event) {
      do {
        final addressEntity = event.addressEntity.toJson();
        if (addressEntity.isNotEmpty) {
          handler.createAddress(
              event.formAddressAddState!.dockingFormz!.value,
              event.formAddressAddState!.cityNameFormz!.value,
              event.formAddressAddState!.zipCodeFormz!.value,
              event.formAddressAddState!.geoCoordFormz!.value,
              event.formAddressAddState!.status!.isSuccess);
          response.insertAddress(addressEntity);
        }
      } while (event.addressEntity.isValid);
    });
  });
  ref.keepAlive();
  return response;
});
