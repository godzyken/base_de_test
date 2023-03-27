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

final boatsDatabaseProvider =
    Provider<SourceBase>((_) => BoatDatabaseImpl.instance);

final boatsRepoProvider = Provider<BoatsRepository>(
    (ref) => BoatsRepositoryImpl(ref.watch(boatsDatabaseProvider)));
final boatFutureProvider = FutureProvider.autoDispose((ref) async {
  final response = boatsDatabaseProvider.read(ref.container);
  ref.onDispose(() => response.close());

  final handler = boatsRepoProvider.read(ref.container);
  ref.onDispose(() => handler.closeDatabase());

  final form =
      boatFormStateNotifierProvider.notifier.select((value) => value.stream);
  form.select((value) => value.listen((event) {}));
  ref.keepAlive();
  return response;
});

final ownerRepoProvider = Provider<OwnerRepository>(
    (ref) => OwnerRepositoryImpl(ref.watch(boatsDatabaseProvider)));

final addressRepoProvider = Provider<AddressRepository>(
    (ref) => AddressRepositoryImpl(ref.watch(boatsDatabaseProvider)));
