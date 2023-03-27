import 'dart:developer' as developer;

import 'package:base_de_test/features/transactions/domain/entities/entities.dart';
import 'package:base_de_test/features/transactions/presentation/controller/boat_notifier.dart';
import 'package:base_de_test/features/transactions/presentation/viewmodel/boatform/boat_form_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../common/presentation/utils/extensions/extensions.dart';

extension on Boat {
  int get id => 0;

  Boat get boatId => Boat(
      boatId: BoatId(value: id),
      name: name,
      addressId: addressId,
      types: types,
      identityNumber: identityNumber,
      cnp: cnp,
      isAvailable: isAvailable,
      createdAt: createdAt,
      ownerId: ownerId);

  bool get isAvailable => boatId.isAvailable;
}

class BoatFormPage extends ConsumerStatefulWidget {
  final Boat? boat;

  const BoatFormPage(this.boat, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BoatFormPageState();
}

class _BoatFormPageState extends ConsumerState<BoatFormPage> {
  late AddBoatFormViewModel _formViewModel;
  Boat? boat;
  final _formKey = GlobalKey<FormState>();
  final List<int> _selectedItems = [];
  final _rentalDateFormFocusNode = _DisabledFocusNode();

  late TextEditingController _dateTextEditingController;
  final _nameEditingController = TextEditingController();
  final _ownerEditingController = TextEditingController();
  final _phoneEditingController = TextEditingController();
  final _roleTextController = TextEditingController();
  final _cityTextController = TextEditingController();
  final _zipTextController = TextEditingController();
  final _errorTextController = TextEditingController();

  final _scaffoldController = ScrollController();
  final _selectIdentityNumberController = ScrollController();
  final _selectCategoryCnpController = ScrollController();
  final _selectTypeOfBoatController = ScrollController();
  final _selectDockingController = ScrollController();

  final _statesController = MaterialStatesController();
  int oldLength = 0;
  int currentStep = 0;
  int id = 0;

  _BoatFormPageState();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (kFlutterMemoryAllocationsEnabled) {
        boat = ref.watch(boatNotifierProvider);
        MemoryAllocations.instance.dispatchObjectCreated(
          library: 'init boat',
          className: 'boat',
          object: boat!,
        );
        _nameEditingController.addListener(_printLatestBoatNameValue);
        _ownerEditingController.addListener(_printLatestOwnerNameValue);
        _ownerEditingController.addListener(_printLatestOwnerPhoneValue);
        _roleTextController.addListener(_printLatestBoatRoleValue);
        _cityTextController.addListener(_printLatestBoatRoleValue);
        _zipTextController.addListener(_printLatestBoatRoleValue);
        _selectCategoryCnpController.addListener(() async {
          if (_selectCategoryCnpController.position.pixels >
              _selectCategoryCnpController.position.maxScrollExtent -
                  MediaQuery.of(context).size.height) {
            if (oldLength == ref.read(categoriesCnpNotifierProvider).length) {
              ref
                  .read(categoriesCnpNotifierProvider.notifier)
                  .selectCategoriesCNP(boat!.cnp);
            }
          }
        });
        _selectIdentityNumberController.addListener(() async {
          if (_selectCategoryCnpController.position.pixels >
              _selectCategoryCnpController.position.maxScrollExtent -
                  MediaQuery.of(context).size.height) {
            if (oldLength == ref.read(identityNumberNotifierProvider).length) {
              ref
                  .read(identityNumberNotifierProvider.notifier)
                  .selectIdentityNumber(boat!.identityNumber);
            }
          }
        });
        _selectTypeOfBoatController.addListener(() async {
          if (_selectTypeOfBoatController.position.pixels >
              _selectTypeOfBoatController.position.maxScrollExtent -
                  MediaQuery.of(context).size.height) {
            if (oldLength == ref.read(typesOfBoatNotifierProvider).length) {
              ref
                  .read(typesOfBoatNotifierProvider.notifier)
                  .selectTypes(boat!.types);
            }
          }
        });

        _statesController.addListener(_printLatestControllerValue);

        developer.log('boat on init: $boat');
      }
    });
    _dateTextEditingController = TextEditingController(
        text: DateFormat('dd/MM/yyyy').format(DateTime.now()));
    _formViewModel = ref.read(boatFormViewModelProvider(widget.boat));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _nameEditingController.clear();
    _ownerEditingController.clear();
    _roleTextController.clear();
    _cityTextController.clear();
    _zipTextController.clear();
    _dateTextEditingController.clear();
    _selectCategoryCnpController.removeListener(() async {
      if (_selectCategoryCnpController.position.pixels >
          _selectCategoryCnpController.position.maxScrollExtent -
              MediaQuery.of(context).size.height) {
        if (oldLength == ref.read(categoriesCnpNotifierProvider).length) {
          ref
              .read(categoriesCnpNotifierProvider.notifier)
              .selectCategoriesCNP(boat!.cnp);
        }
      }
    });
    _selectIdentityNumberController.removeListener(() async {
      if (_selectCategoryCnpController.position.pixels >
          _selectCategoryCnpController.position.maxScrollExtent -
              MediaQuery.of(context).size.height) {
        if (oldLength == ref.read(identityNumberNotifierProvider).length) {
          ref
              .read(identityNumberNotifierProvider.notifier)
              .selectIdentityNumber(boat!.identityNumber);
        }
      }
    });
    _selectTypeOfBoatController.removeListener(() async {
      if (_selectCategoryCnpController.position.pixels >
          _selectCategoryCnpController.position.maxScrollExtent -
              MediaQuery.of(context).size.height) {
        if (oldLength == ref.read(typesOfBoatNotifierProvider).length) {
          ref
              .read(typesOfBoatNotifierProvider.notifier)
              .selectTypes(boat!.types);
        }
      }
    });
    _statesController.removeListener(() async {
      _statesController.value.clear();
    });
    _formViewModel = ref.read(boatFormViewModelProvider(widget.boat));
  }

  @override
  void didUpdateWidget(BoatFormPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    oldWidget.createElement();
  }

  @override
  void dispose() {
    _rentalDateFormFocusNode.dispose();
    _dateTextEditingController.dispose();
    _nameEditingController.dispose();
    _ownerEditingController.dispose();
    _roleTextController.dispose();
    _cityTextController.dispose();
    _zipTextController.dispose();
    _scaffoldController.dispose();
    _selectTypeOfBoatController.dispose();
    _selectIdentityNumberController.dispose();
    _selectCategoryCnpController.dispose();
    _statesController.dispose();
    _formViewModel.initialAvailableValue();

    _formKey.currentState?.dispose();

    super.dispose();
  }

  void onSavedName(value) {
    if (_formViewModel.setName(value) != null) {
      ref.read(boatNotifierProvider.notifier).updateName(value);
    }
  }

  void onSavedCityName(value) {
    if (_formViewModel.setCityName(value) != null) {
      ref.read(addressNotifierProvider.notifier).updateCity(value);
    }
  }

  void onSavedZipCode(value) {
    if (_formViewModel.setZipCode(value) != null) {
      ref.read(addressNotifierProvider.notifier).updateZipCode(value);
    }
  }

  void onSavedOwnerPhone(value) {
    if (_formViewModel.setOwnerPhone(value) != null) {
      ref.read(ownerEntityNotifierProvider.notifier).updateOwnerPhone(value);
    }
  }

  void onSavedRole(value) {
    if (_formViewModel.setRole(value) != null) {
      ref.read(boatNotifierProvider.notifier).updateRole(value);
    }
  }

  void _printLatestBoatNameValue() {
    developer
        .log('print last boat name text field: ${_nameEditingController.text}');
  }

  void _printLatestOwnerNameValue() {
    developer.log(
        'print last owner name text field: ${_ownerEditingController.text}');
  }

  void _printLatestBoatRoleValue() {
    developer
        .log('print last boat role text field: ${_roleTextController.text}');
  }

  void _printLatestOwnerPhoneValue() {
    developer.log(
        'print last Date rang text field: ${_phoneEditingController.text}');
  }

  void _printLatestControllerValue() {
    developer
        .log('print last start controller state: ${_statesController.value}');

    ref.read(boatNotifierProvider.notifier).updateId(id);
    // Navigator.pop(context, true);
    context.go('/boat-list');
  }

  void _onCreateBoat() {
    developer.log('lulu');
    final currentState = _formKey.currentState;
    if (boat != null && currentState!.validate()) {
      int id = 1 + DateTime.now().millisecondsSinceEpoch;
      final newBoat = Boat(
        boatId: BoatId(value: id++),
        name: _nameEditingController.text,
        ownerId: OwnerId(value: id++),
        addressId: AddressId(value: id++),
        isAvailable: _formViewModel.isNewBoatValue(),
        createdAt: _formViewModel.initialCreatedDateValue(),
        role: _roleTextController.text,
      );
      developer.log('boat on create: $newBoat');
      ref.read(boatFormStateNotifierProvider.notifier).addBoat(newBoat);
      context.go('/boat-list');
    }
    developer.log('lolo');
    return;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
          body: CustomScrollView(
        controller: _scaffoldController,
        shrinkWrap: true,
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 100.0,
            title: Text(_formViewModel.appBarTitle()),
            actions: [
              if (_formViewModel.isNewBoatValue())
                _buildDeleteBoatIconWidget(context),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(10),
            sliver: SliverToBoxAdapter(
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: _buildBodyWidget(context),
              ),
            ),
          )
        ],
      ));

  Widget _buildBodyWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, top: 5, right: 8, bottom: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildFormWidget(context),
          _buildSaveButtonWidget(context),
        ],
      ),
    );
  }

  Widget _buildSaveButtonWidget(BuildContext context) {
    return SizedBox(
      key: ValueKey(_formKey),
      width: double.infinity,
      child: ElevatedButton(
        statesController: _statesController,
        onPressed: _onCreateBoat,
        child: const Text('Save'),
      ),
    );
  }

  Widget _buildFormWidget(BuildContext context) {
    List<Step> getSteps() {
      return <Step>[
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const Text("Boat Name"),
          content: Wrap(
            children: [
              _buildBoatNameFormWidget(context),
              const SizedBox(
                height: 10,
              ),
              _buildTypesOfBoatFormWidget(context),
              const SizedBox(
                height: 10,
              ),
              _buildCategoryOfBoatFormWidget(context),
              const SizedBox(
                height: 10,
              ),
              _buildIdentityNumberOfBoatFormWidget(context),
              const SizedBox(
                height: 10,
              ),
              _buildBoatRoleFormWidget(context),
              const SizedBox(
                height: 10,
              ),
              _buildRentalDateFormWidget(context),
            ],
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text("Owner contact"),
          content: Wrap(
            children: [
              _buildOwnerNameFormWidget(context),
              const SizedBox(
                height: 10,
              ),
              _buildOwnerPhoneFormWidget(context),
            ],
          ),
        ),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: const Text("Location"),
          content: Wrap(
            children: [
              _buildBoatDockingFormWidget(context),
              const SizedBox(
                height: 10,
              ),
              _buildCityFormWidget(context),
              const SizedBox(
                height: 10,
              ),
              _buildZipCodeFormWidget(context),
            ],
          ),
        ),
      ];
    }

    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        ref.listen(boatNotifierProvider, (previous, next) {
          boat?.id != previous!.boatId!.value ? next : previous;
        });
        return Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Stepper(
                type: StepperType.vertical,
                currentStep: currentStep,
                physics: const ClampingScrollPhysics(),
                onStepCancel: () =>
                    setState(() => currentStep == 0 ? null : currentStep -= 1),
                onStepContinue: () {
                  bool isLastStep = (currentStep == getSteps().length - 1);
                  if (isLastStep) {
                    setState(() {
                      developer.log('last step: $isLastStep');
                      developer.log('last Boat: $boat');
                      _formViewModel.createOrUpdateBoat();
                    });
                  } else {
                    setState(() {
                      developer.log('et la ?');
                      developer.log('last Boat: $Boat');
                      currentStep += 1;
                      developer.log('current step : $currentStep');
                    });
                  }
                },
                onStepTapped: (step) => setState(() => currentStep = step),
                steps: getSteps()));
      },
    );
  }

  //-------------------> Boat Identity Form Widget <--------------------------//
  Widget _buildBoatNameFormWidget(BuildContext context) {
    return TextInputField(
      controller: _nameEditingController,
      maxLength: 20,
      onFieldSubmitted: onSavedName,
      onChanged: (value) => _formViewModel.setName(value),
      validator: (value) => _formViewModel.validateName(value!),
      decoration: InputDecoration(
        icon: const Icon(Icons.edit),
        labelText: context.tr.ownerName,
        helperText: context.tr.required,
        border: const OutlineInputBorder(),
      ),
      hintText: context.tr.enterUsername,
      label: context.tr.userName,
    );
  }

  Widget _buildBoatRoleFormWidget(BuildContext context) {
    return TextInputField(
      controller: _roleTextController,
      maxLength: 20,
      onFieldSubmitted: onSavedRole,
      validator: (value) => _formViewModel.validateRole(value!),
      decoration: InputDecoration(
        icon: const Icon(Icons.announcement_sharp),
        labelText: context.tr.boatRole,
        helperText: context.tr.required,
        border: const OutlineInputBorder(),
      ),
      hintText: context.tr.boatRole,
      onChanged: (String value) => _formViewModel.setRole(value),
      label: context.tr.boatRole,
    );
  }

  Widget _buildTypesOfBoatFormWidget(BuildContext context) {
    final newTypes = ref.watch(typesOfBoatNotifierProvider);
    return Consumer(builder: (context, ref, child) {
      ref.listen(boatNotifierProvider, (previous, next) {
        boat?.id != previous!.boatId!.value ? next : previous;
      });
      return SizedBox.fromSize(
        size: MediaQuery.of(context).size.flipped / 5.5,
        child: ListView.builder(
          shrinkWrap: true,
          controller: _selectTypeOfBoatController,
          itemCount: newTypes.length,
          itemBuilder: (context, index) => ListTile(
            selected: _formViewModel.isNewBoatValue(),
            leading: Icon(
              Icons.directions_boat_filled_rounded,
              color: Colors.cyan,
              size: MediaQuery.of(context).size.width / 20,
            ),
            onTap: () {
              developer.log("push select types boat");
              ref
                  .read(boatNotifierProvider.notifier)
                  .updateTypes(newTypes[index].name);
            },
            title: Text(
              newTypes[index].name,
              style: context.textTheme.titleMedium,
            ),
          ),
        ),
      );
    });
  }

  Widget _buildCategoryOfBoatFormWidget(BuildContext context) {
    final newCat = ref.watch(categoriesCnpNotifierProvider);
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        ref.listen(
          boatNotifierProvider,
          (previous, next) =>
              boat?.id != previous!.boatId!.value ? next : previous,
        );
        return SizedBox.fromSize(
            size: MediaQuery.of(context).size.flipped / 5.5,
            child: ListView.builder(
              controller: _selectCategoryCnpController,
              shrinkWrap: true,
              dragStartBehavior: DragStartBehavior.start,
              itemCount: newCat.length,
              itemBuilder: (context, index) => ListTile(
                leading: Icon(
                  Icons.category_sharp,
                  color: Colors.cyan,
                  size: MediaQuery.of(context).size.width / 20,
                ),
                title: Text(
                  newCat[index].name,
                  // style: context.textTheme.titleMedium,
                ),
                enabled: true,
                enableFeedback: true,
                selected: _selectCategoryCnpController.keepScrollOffset,
                titleAlignment: ListTileTitleAlignment.center,
                onTap: () {
                  ref
                      .read(boatNotifierProvider.notifier)
                      .updateCategory(newCat[index].name);
                },
              ),
            ));
      },
      child: SizedBox.fromSize(
        size: MediaQuery.of(context).size.flipped / 5.5,
        child: ListView.builder(
          dragStartBehavior: DragStartBehavior.start,
          itemCount: newCat.length,
          itemBuilder: (context, index) => ListTile(
            enabled: true,
            enableFeedback: true,
            titleAlignment: ListTileTitleAlignment.center,
            selected: true,
            leading: Icon(
              Icons.category_sharp,
              color: Colors.cyan,
              size: MediaQuery.of(context).size.width / 20,
            ),
            onTap: () {
              developer.log("push select cat boat");
              if (_selectedItems.contains(index)) {
                setState(() {
                  _selectedItems.removeWhere((element) => element == index);
                  _selectCategoryCnpController.position;
                  _selectedItems.elementAt(index);
                  if (newCat.isNotEmpty) {
                    newCat.elementAt(index);
                    _formViewModel.setCategoryCnp(newCat);
                    _formKey.currentState!.save();
                  }
                });
              }
            },
            onLongPress: () {
              developer.log("long push select cat boat");
              developer.log('message 1: ${!_selectedItems.contains(index)}');
              if (!_selectedItems.contains(index)) {
                setState(() {
                  _selectedItems.removeWhere(
                    (element) => element == index,
                  );
                });
              } else if (_selectedItems.contains(index)) {
                _formKey.currentState!.save();

                setState(() {
                  _selectedItems.add(index);
                  if (newCat.isNotEmpty) {
                    newCat.elementAt(index);
                    _formViewModel.setCategoryCnp(newCat);
                  } else {
                    developer.log('error 2 somewhere');
                    return;
                  }
                });
              } else {
                developer.log('error 1 somewhere');
                return;
              }
            },
            title: Text(
              newCat[index].name,
              style: context.textTheme.titleMedium,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIdentityNumberOfBoatFormWidget(BuildContext context) {
    final newIdentity = ref.watch(identityNumberNotifierProvider);
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        ref.listen(
          boatNotifierProvider,
          (previous, next) =>
              boat?.id != previous!.boatId!.value ? next : previous,
        );
        return SizedBox.fromSize(
          size: MediaQuery.of(context).size.flipped / 5.5,
          child: ListView.builder(
            controller: _selectIdentityNumberController,
            shrinkWrap: true,
            dragStartBehavior: DragStartBehavior.start,
            itemCount: newIdentity.length,
            itemBuilder: (BuildContext context, int index) => ListTile(
              onTap: () {
                ref
                    .read(boatNotifierProvider.notifier)
                    .updateIdentityNumber(newIdentity[index].name);
              },
              title: Text(
                newIdentity[index].name,
                // style: context.textTheme.titleMedium,
              ),
              enabled: true,
              enableFeedback: true,
              titleAlignment: ListTileTitleAlignment.center,
              selected: true,
              leading: Icon(
                Icons.perm_identity_sharp,
                color: Colors.black45,
                size: MediaQuery.of(context).size.width / 20,
              ),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            color: Colors.cyanAccent,
            border: Border.all(color: Colors.black38),
            borderRadius: const BorderRadius.all(Radius.circular(3.0))),
        child: ListView.builder(
          shrinkWrap: true,
          controller: _selectIdentityNumberController,
          itemCount: newIdentity.length,
          itemBuilder: (context, index) => ListTile(
            enabled: true,
            enableFeedback: true,
            titleAlignment: ListTileTitleAlignment.center,
            selected: true,
            leading: Icon(
              Icons.perm_identity_sharp,
              color: Colors.black45,
              size: MediaQuery.of(context).size.shortestSide,
            ),
            onTap: () => _selectedItems.contains(index),
            onLongPress: () {
              if (newIdentity.isNotEmpty) {}
            },
            title: Text(
              newIdentity[index].name,
              style: context.textTheme.titleMedium,
            ),
          ),
        ),
      ),
    );
  }

  //-------------------> Owner Identity Form Widget <-------------------------//
  Widget _buildOwnerNameFormWidget(BuildContext context) {
    final newOwner = ref.read(ownerEntityNotifierProvider.notifier);

    return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
      ref.listen(
          ownerEntityNotifierProvider,
          (previous, next) => boat?.ownerId?.value != previous?.ownerId.value
              ? newOwner.updateOwnerId(next.ownerId.value)
              : previous);

      return TextInputField(
        controller: _ownerEditingController,
        maxLength: 150,
        onFieldSubmitted: (value) => newOwner.updateOwnerName(value),
        onChanged: (value) => _formViewModel.setOwnerName(value),
        validator: (value) => _formViewModel.validateName(value!),
        decoration: InputDecoration(
          icon: const Icon(Icons.view_headline),
          labelText: context.tr.enterOwnerName,
          helperText: context.tr.required,
          border: const OutlineInputBorder(),
        ),
        hintText: context.tr.enterOwnerName,
        label: context.tr.ownerName,
      );
    });
  }

  Widget _buildOwnerPhoneFormWidget(BuildContext context) {
    return TextInputField(
      controller: _phoneEditingController,
      maxLength: 16,
      onFieldSubmitted: onSavedOwnerPhone,
      inputType: TextInputType.phone,
      validator: (value) => _formViewModel.validatePhone(value!),
      decoration: InputDecoration(
        icon: const Icon(Icons.add_call),
        labelText: context.tr.enterOwnerPhone,
        helperText: context.tr.required,
        border: const OutlineInputBorder(),
      ),
      hintText: context.tr.enterOwnerPhone,
      label: context.tr.ownerPhone,
      onChanged: (String value) => _formViewModel.setOwnerPhone(value),
    );
  }

  //-------------------> Boat Location Form Widget <--------------------------//
  Widget _buildBoatDockingFormWidget(BuildContext context) {
    final docking = ref.watch(dockingNotifierProvider);
    return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
      ref.listen(
          boatNotifierProvider,
          (previous, next) =>
              boat?.id != previous!.boatId!.value ? next : previous);
      return SizedBox.fromSize(
        size: MediaQuery.of(context).size.flipped / 5.5,
        child: ListView.builder(
          controller: _selectDockingController,
          shrinkWrap: true,
          dragStartBehavior: DragStartBehavior.start,
          itemCount: docking.length,
          itemBuilder: (BuildContext context, int index) => ListTile(
            onTap: () => ref
                .read(dockingNotifierProvider.notifier)
                .selectDockingType(docking[index]),
            title: Text(
              docking[index].name,
              // style: context.textTheme.titleMedium,
            ),
            enabled: true,
            enableFeedback: true,
            titleAlignment: ListTileTitleAlignment.center,
            selected: true,
            leading: Icon(
              Icons.anchor_sharp,
              color: Colors.black45,
              size: MediaQuery.of(context).size.width / 20,
            ),
          ),
        ),
      );
    });
  }

  Widget _buildCityFormWidget(BuildContext context) {
    return TextInputField(
      controller: _cityTextController,
      maxLength: 20,
      onFieldSubmitted: onSavedCityName,
      validator: (value) => _formViewModel.validateName(value!),
      decoration: InputDecoration(
        icon: const Icon(Icons.directions_boat_sharp),
        labelText: context.tr.addressCity,
        helperText: context.tr.required,
        border: const OutlineInputBorder(),
      ),
      hintText: context.tr.enterAddressCity,
      onChanged: (String value) => _formViewModel.setCityName(value),
      label: context.tr.addressCity,
    );
  }

  Widget _buildZipCodeFormWidget(BuildContext context) {
    return TextInputField(
      controller: _zipTextController,
      maxLength: 20,
      onFieldSubmitted: onSavedZipCode,
      validator: (value) => _formViewModel.validateName(value!),
      decoration: InputDecoration(
        icon: const Icon(Icons.location_city_rounded),
        labelText: context.tr.addressZipCode,
        helperText: context.tr.required,
        border: const OutlineInputBorder(),
      ),
      hintText: context.tr.enterAddressZipCode,
      onChanged: (String value) => _formViewModel.setZipCode(value),
      label: context.tr.addressZipCode,
    );
  }

  //-------------------> Availability Form Widget <---------------------------//
  Widget _buildRentalDateFormWidget(BuildContext context) {
    return TextFormField(
      focusNode: _rentalDateFormFocusNode,
      controller: _dateTextEditingController,
      inputFormatters: const [],
      maxLength: 70,
      onTap: () => _showDateRangePicker(context),
      validator: (_) => _formViewModel.validateDateInset(),
      decoration: InputDecoration(
        icon: const Icon(Icons.calendar_today_rounded),
        labelText: context.tr.rentalDate,
        helperText: context.tr.required,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDeleteBoatIconWidget(BuildContext context) {
    return IconButton(
      onPressed: () => _showConfirmDeleteBoatLocationDialog(context),
      icon: const Icon(Icons.delete),
    );
  }

  Future<DateTimeRange?> _showDateRangePicker(
      final BuildContext context) async {
    final DateTimeRange? selectedDate = await showDateRangePicker(
        context: context,
        initialDateRange: _formViewModel.initDateRangeValue(),
        currentDate: _formViewModel.initialCreatedDateValue(),
        firstDate: _formViewModel.datePickerFirstDate(),
        lastDate: _formViewModel.datePickerLastDate(),
        initialEntryMode: DatePickerEntryMode.calendar,
        confirmText: 'Done');

    developer.log('selected Date: $selectedDate');

    if (selectedDate != null) {
      final newDateSelect = selectedDate;

      _dateTextEditingController.text =
          DateFormat('dd/MM/yyyy').format(newDateSelect.start);
      ref
          .read(boatNotifierProvider.notifier)
          .updateRentalDate(newDateSelect.start.toIso8601String());

      ref
          .read(boatNotifierProvider.notifier)
          .updateReturnedDate(newDateSelect.end.toIso8601String());

      ref.read(boatNotifierProvider.notifier).updateIsAvailableValue(true);
      return newDateSelect;
    }
    return null;
  }

/*
  Future<TimeOfDay?> _showTimePicker(final BuildContext context) async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: _formViewModel.initialLocStartTimeValue(),
    );
    if (selectedTime != null) {
      _dateTextEditingController.text = DateFormat.HOUR24_MINUTE;
      _formViewModel.setStartTimeLocation(selectedTime);
      _formViewModel.setEndTimeLocation(selectedTime);
    }
    return null;
  }
*/

  _showConfirmDeleteBoatLocationDialog(BuildContext context) async {
    final bool result = await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: const Text('Delete boat?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('DELETE'),
            ),
          ],
        );
      },
    );
    if (result) {
      _formViewModel.deleteBoatLocation();

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  Future<bool> onWillPop() async {
    ref.listen(
      boatNotifierProvider.notifier,
      (previous, next) => next.stream.last == previous?.stream.last
          ? next.stream
          : previous?.stream,
    );

    if (_formViewModel.initialAvailableValue()) {
      final Widget? currentWidget = _formKey.currentWidget;
      final BuildContext? currentContext = _formKey.currentContext;

      currentContext?.visitChildElements((element) {
        for (final el in element.debugGetDiagnosticChain()) {
          if (el.dirty) {
            developer.log('message dirty: $el');
            if (el.debugIsDefunct) {
              currentWidget?.key;
              reassemble();
            }
          } else if (el.mounted) {
            currentWidget?.key == _formKey;
          } else if (el.debugIsActive) {
            currentContext.debugDoingBuild == el.debugDoingBuild;
          }
        }
      });
    }

    return ref.refresh(boatNotifierProvider).isAvailable;
  }

  @override
  int get hashCode => Object.hash(boat, _formKey);

  @override
  dynamic noSuchMethod(Invocation invocation) {}

  @override
  Type get runtimeType {
    return widget.runtimeType;
  }

  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return super == other;
  }
}

class _DisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
