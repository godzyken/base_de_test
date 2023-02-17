import 'package:base_de_test/features/transactions/application/datasource/data_source_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'usecases/uses_cases.dart';

final getBoatListUseCaseProvider = Provider<GetBoatListUseCase>(
    (ref) => GetBoatListUseCaseImpl(ref.watch(boatsRepoProvider)));

final createBoatLocationUseCaseProvider = Provider<CreateBoatLocationCase>(
    (ref) => CreateBoatLocationCaseImpl(ref.watch(boatsRepoProvider)));

final updateBoatLocationUseCaseProvider = Provider<UpdateBoatLocationUseCase>(
    (ref) => UpdateBoatLocationUseCaseImpl(ref.watch(boatsRepoProvider)));

final deleteBoatLocationUseCaseProvider = Provider<DeleteBoatLocationUseCase>(
    (ref) => DeleteBoatLocationUseCaseImpl(ref.watch(boatsRepoProvider)));
