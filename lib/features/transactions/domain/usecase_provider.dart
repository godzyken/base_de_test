import 'package:base_de_test/features/transactions/application/datasource/data_source_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'usecases/uses_cases.dart';

//<---------------------/ Boat provider CRUD section /----------------------------->//

final getBoatListUseCaseProvider = Provider<GetBoatListUseCase>(
    (ref) => GetBoatListUseCaseImpl(ref.watch(boatsRepoProvider)));

final createBoatLocationUseCaseProvider = Provider<CreateBoatLocationCase>(
    (ref) => CreateBoatLocationCaseImpl(ref.watch(boatsRepoProvider)));

final updateBoatLocationUseCaseProvider = Provider<UpdateBoatLocationUseCase>(
    (ref) => UpdateBoatLocationUseCaseImpl(ref.watch(boatsRepoProvider)));

final deleteBoatLocationUseCaseProvider = Provider<DeleteBoatLocationUseCase>(
    (ref) => DeleteBoatLocationUseCaseImpl(ref.watch(boatsRepoProvider)));

//<---------------------/ Owner provider CRUD section /----------------------------->//

final getOwnerListUseCaseProvider = Provider<GetOwnerListUseCase>(
    (ref) => GetOwnerListUseCaseImpl(ref.watch(ownerRepoProvider)));

final createOwnerUseCaseProvider = Provider<CreateOwnerEntityCase>(
    (ref) => CreateOwnerEntityCaseImpl(ref.watch(ownerRepoProvider)));

final updateOwnerUseCaseProvider = Provider<UpdateOwnerUseCase>(
    (ref) => UpdateOwnerUseCaseImpl(ref.watch(ownerRepoProvider)));

final deleteOwnerUseCaseProvider = Provider<DeleteOwnerEntityCase>(
    (ref) => DeleteOwnerEntityCaseImpl(ref.watch(ownerRepoProvider)));

//<---------------------/ Address provider CRUD section /----------------------------->//
/*
* Use Link Gps.fr web
[https://www.coordonnees-gps.fr/latitude-longitude/48.856614/2.352221/10/roadmap]
*
*/
final getAddressListUseCaseProvider = Provider<GetAddressListUseCase>(
    (ref) => GetAddressListUseCaseImpl(ref.watch(addressRepoProvider)));

final createAddressUseCaseProvider = Provider<CreateAddressEntityCase>(
    (ref) => CreateAddressEntityCaseImpl(ref.watch(addressRepoProvider)));

final updateAddressUseCaseProvider = Provider<UpdateAddressUseCase>(
    (ref) => UpdateAddressUseCaseImpl(ref.watch(addressRepoProvider)));

final deleteAddressUseCaseProvider = Provider<DeleteAddressEntityCase>(
    (ref) => DeleteAddressEntityCaseImpl(ref.watch(addressRepoProvider)));
