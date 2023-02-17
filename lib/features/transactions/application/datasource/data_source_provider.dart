import 'package:base_de_test/features/transactions/application/datasource/database/boat_database_impl.dart';
import 'package:base_de_test/features/transactions/application/datasource/database/source_base.dart';
import 'package:base_de_test/features/transactions/application/datasource/repository/boats_repository_impl.dart';
import 'package:base_de_test/features/transactions/domain/repositories/boats_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final boatsDatabaseProvider = Provider<SourceBase>((_) => BoatDatabaseImpl());
final boatsRepoProvider = Provider<BoatsRepository>(
    (ref) => BoatsRepositoryImpl(ref.watch(boatsDatabaseProvider)));
