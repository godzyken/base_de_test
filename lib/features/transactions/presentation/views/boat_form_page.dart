import 'dart:developer';

import 'package:base_de_test/features/common/presentation/utils/extensions/ui_extension.dart';
import 'package:base_de_test/features/transactions/domain/entities/boat/boat_entity.dart';
import 'package:base_de_test/features/transactions/domain/entities/boat/boat_id.dart';
import 'package:base_de_test/features/transactions/presentation/controller/boat_notifier.dart';
import 'package:base_de_test/features/transactions/presentation/viewmodel/boatform/boat_form_viewmodel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'boat_list_page.dart';

extension on Boat {
  int get id => 0;

  Boat get boatId => Boat(
      boatId: BoatId(value: id),
      name: name,
      ownerEntity: ownerEntity,
      types: types,
      identityNumber: identityNumber,
      cnp: cnp,
      isAvailable: isAvailable,
      createdAt: createdAt);

  bool get isAvailable => boatId.isAvailable;
}

class BoatFormPage extends ConsumerStatefulWidget {
  final Boat? boat;

  const BoatFormPage(this.boat, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BoatFormPageState();
}

class _BoatFormPageState extends ConsumerState<BoatFormPage> {
  late final AddBoatFormViewModel _formViewModel;
  late final Boat boat;
  late final GlobalKey<FormState> _formKey;
  final List<int> _selectedItems = [];
  final _rentalDateFormFocusNode = _DisabledFocusNode();

  late TextEditingController _dateTextEditingController;
  late TextEditingController _nameEditingController;
  late TextEditingController _ownerEditingController;
  late TextEditingController _roleTextController;

  late ScrollController _selectIdentityNumberController;
  late ScrollController _selectCategoryCnpController;
  late ScrollController _selectTypeOfBoatController;

  _BoatFormPageState();

  @override
  void initState() {
    super.initState();
    _formViewModel = ref.read(boatFormViewModelProvider(widget.boat));
    log('message _formViewModel: ${_formViewModel.createOrUpdateBoat()}');
    boat = ref.watch(boatNotifierProvider);
    log('boat on init: $boat');

    _nameEditingController = TextEditingController();
    _ownerEditingController = TextEditingController();
    _roleTextController = TextEditingController();
    _dateTextEditingController = TextEditingController(
        text: DateFormat('dd/MM/yyyy')
            .format(_formViewModel.initialCreatedDateValue()));
    _formKey = GlobalKey<FormState>(debugLabel: 'formKey: => ');
    _selectCategoryCnpController = ScrollController(
      keepScrollOffset: true,
      initialScrollOffset: 0.0,
    );
    _selectIdentityNumberController = ScrollController(
      keepScrollOffset: true,
      initialScrollOffset: 0.0,
    );
    _selectTypeOfBoatController = ScrollController(
      keepScrollOffset: true,
      initialScrollOffset: 0.0,
    );
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
    _selectTypeOfBoatController.dispose();
    _selectIdentityNumberController.dispose();
    _selectCategoryCnpController.dispose();
    _formViewModel.initialAvailableValue();

    _formKey.currentState?.dispose();

    super.dispose();
  }

  void onSavedName(value) {
    if (_formViewModel.setName(value) != null) {
      ref.read(boatNotifierProvider.notifier).updateName(value);
    }
  }

  void onSavedOwnerName(value) {
    if (_formViewModel.setOwnerName(value) != null) {
      ref.read(boatNotifierProvider.notifier).updateOwnerName(value);
    }
  }

  void _getListPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => BoatListPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_formViewModel.appBarTitle()),
        actions: [
          if (_formViewModel.isNewBoatValue()) _buildDeleteBoatIconWidget(),
        ],
      ),
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return Container(
      padding: const EdgeInsets.only(left: 16, top: 24, right: 16, bottom: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildFormWidget(),
          _buildSaveButtonWidget(),
        ],
      ),
    );
  }

  Widget _buildSaveButtonWidget() {
    return SizedBox(
      key: ValueKey(_formKey),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            log('currentState 2: ');
            _formViewModel.createOrUpdateBoat();
            _getListPage();
          }
          log('currentState 1: ${_formKey.currentState}');
        },
        child: const Text('Save'),
      ),
    );
  }

  Widget _buildFormWidget() {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        ref.listen(boatNotifierProvider, (previous, next) {
          boat.id != previous!.boatId!.value ? next : previous;
        });
        return Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          // onWillPop: onWillPop,
          onChanged: () => _formKey.currentState!.validate(),
          child: Column(
            children: [
              _buildBoatNameFormWidget(),
              const SizedBox(height: 16),
              _buildOwnerNameFormWidget(),
              const SizedBox(height: 16),
              _buildRentalDateFormWidget(),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: _buildIdentityNumberOfBoatFormWidget(),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    flex: 2,
                    child: _buildTypesOfBoatFormWidget(),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    flex: 1,
                    child: _buildCategoryOfBoatFormWidget(),
                  )
                ],
              ),
            ],
          ),
        );
      },
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        // onWillPop: onWillPop,
        onChanged: () => _formKey.currentState!.validate(),
        child: Column(
          children: [
            _buildBoatNameFormWidget(),
            const SizedBox(height: 16),
            _buildOwnerNameFormWidget(),
            const SizedBox(height: 16),
            _buildRentalDateFormWidget(),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: _buildIdentityNumberOfBoatFormWidget(),
                ),
                const SizedBox(width: 4),
                Expanded(
                  flex: 2,
                  child: _buildTypesOfBoatFormWidget(),
                ),
                const SizedBox(width: 4),
                Expanded(
                  flex: 1,
                  child: _buildCategoryOfBoatFormWidget(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBoatNameFormWidget() {
    return TextFormField(
      controller: _nameEditingController,
      maxLength: 20,
      onFieldSubmitted: onSavedName,
      validator: (_) => _formViewModel.validateName(_),
      decoration: const InputDecoration(
        icon: Icon(Icons.edit),
        labelText: 'Boat Name',
        helperText: 'Required',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildOwnerNameFormWidget() {
    return TextFormField(
      controller: _ownerEditingController,
      maxLength: 150,
      onFieldSubmitted: onSavedOwnerName,
      validator: (value) => _formViewModel.validateName(value),
      decoration: const InputDecoration(
        icon: Icon(Icons.view_headline),
        labelText: 'Owner Name',
        helperText: 'Required',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildTypesOfBoatFormWidget() {
    final newTypes = ref.watch(typesOfBoatNotifierProvider);
    return Consumer(builder: (context, ref, child) {
      ref.listen(boatNotifierProvider, (previous, next) {
        boat.id != previous!.boatId!.value ? next : previous;
      });
      return Container(
        padding: const EdgeInsets.all(4),
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
            color: Colors.cyanAccent,
            borderRadius: BorderRadius.all(Radius.circular(3.0))),
        child: ListView.builder(
          controller: _selectTypeOfBoatController,
          itemCount: newTypes.length,
          itemBuilder: (context, index) => ListTile(
            selected: _formViewModel.isNewBoatValue(),
            leading: const Icon(
              Icons.directions_boat_filled_rounded,
              color: Colors.cyan,
            ),
            onTap: () {
              log("push select types boat");
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

  Widget _buildCategoryOfBoatFormWidget() {
    final newCat = ref.watch(categoriesCnpNotifierProvider);
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        ref.listen(
          boatNotifierProvider,
          (previous, next) =>
              boat.id != previous!.boatId!.value ? next : previous,
        );
        return Container(
            padding: const EdgeInsets.all(4),
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
                color: Colors.cyanAccent,
                borderRadius: BorderRadius.all(Radius.circular(3.0))),
            child: ListView.builder(
              controller: _selectCategoryCnpController,
              dragStartBehavior: DragStartBehavior.start,
              itemCount: newCat.length,
              itemBuilder: (context, index) => ListTile(
                leading: const Icon(
                  Icons.category_sharp,
                  color: Colors.cyan,
                ),
                title: Text(
                  newCat[index].name,
                  style: context.textTheme.titleMedium,
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
      child: Container(
        padding: const EdgeInsets.all(4),
        width: 60,
        height: 60,
        decoration: const BoxDecoration(
            color: Colors.cyanAccent,
            borderRadius: BorderRadius.all(Radius.circular(3.0))),
        child: ListView.builder(
          dragStartBehavior: DragStartBehavior.start,
          itemCount: newCat.length,
          itemBuilder: (context, index) => ListTile(
            enabled: true,
            enableFeedback: true,
            titleAlignment: ListTileTitleAlignment.center,
            selected: true,
            leading: const Icon(
              Icons.category_sharp,
              color: Colors.cyan,
            ),
            onTap: () {
              log("push select cat boat");
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
              log("long push select cat boat");
              log('message 1: ${!_selectedItems.contains(index)}');
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
                    log('error 2 somewhere');
                    return;
                  }
                });
              } else {
                log('error 1 somewhere');
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

  Widget _buildIdentityNumberOfBoatFormWidget() {
    final newIdentity = ref.watch(identityNumberNotifierProvider);
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        ref.listen(
          boatNotifierProvider,
          (previous, next) =>
              boat.id != previous!.boatId!.value ? next : previous,
        );
        return Container(
          padding: const EdgeInsets.all(4),
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              color: Colors.cyanAccent,
              border: Border.all(color: Colors.black38),
              borderRadius: const BorderRadius.all(Radius.circular(3.0))),
          child: ListView.builder(
            controller: _selectIdentityNumberController,
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
                style: context.textTheme.titleMedium,
              ),
              enabled: true,
              enableFeedback: true,
              titleAlignment: ListTileTitleAlignment.center,
              selected: true,
              leading: const Icon(
                Icons.perm_identity_sharp,
                color: Colors.black45,
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
            leading: const Icon(
              Icons.perm_identity_sharp,
              color: Colors.black45,
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

  Widget _buildRentalDateFormWidget() {
    return TextFormField(
      focusNode: _rentalDateFormFocusNode,
      controller: _dateTextEditingController,
      inputFormatters: const [],
      maxLength: 70,
      onTap: () => _showDateRangePicker(context),
      validator: (_) => _formViewModel.validateDateInset(),
      decoration: const InputDecoration(
        icon: Icon(Icons.calendar_today_rounded),
        labelText: 'Rental date',
        helperText: 'Required',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildDeleteBoatIconWidget() {
    return IconButton(
      onPressed: () => _showConfirmDeleteBoatLocationDialog(),
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

    log('selected Date: $selectedDate');

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

  _showConfirmDeleteBoatLocationDialog() async {
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
    final boat = ref.listen(
      boatNotifierProvider.notifier,
      (previous, next) {
        next.stream.last == previous?.stream.last
            ? next.stream
            : previous?.stream;
      },
    );

    if (_formViewModel.initialAvailableValue()) {
      final Widget? currentWidget = _formKey.currentWidget;
      final BuildContext? currentContext = _formKey.currentContext;

      currentContext?.visitChildElements((element) {
        for (final el in element.debugGetDiagnosticChain()) {
          if (el.dirty) {
            log('message dirty: $el');
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
