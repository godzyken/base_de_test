import 'dart:developer';

import 'package:base_de_test/features/common/presentation/utils/extensions/ui_extension.dart';
import 'package:base_de_test/features/transactions/domain/entities/boat/boat_entity.dart';
import 'package:base_de_test/features/transactions/presentation/controller/boat_notifier.dart';
import 'package:base_de_test/features/transactions/presentation/viewmodel/boatform/boat_form_viewmodel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class BoatFormPage extends ConsumerStatefulWidget {
  final Boat? boat;

  const BoatFormPage(this.boat, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BoatFormPageState();
}

class _BoatFormPageState extends ConsumerState<BoatFormPage> {
  late final BoatLocationFormViewModel _formViewModel;
  final _formKey = GlobalKey<FormState>();
  final _rentalDateFormFocusNode = _DisabledFocusNode();
  late TextEditingController _textEditingController;
  late final Boat boat;

  _BoatFormPageState();

  @override
  void initState() {
    super.initState();

    _formViewModel = ref.read(boatFormViewModelProvider(widget.boat));
    _textEditingController = TextEditingController(
        text: DateFormat('dd/MM/yyyy')
            .format(_formViewModel.initialLocDateValue()));
    boat = ref.read(boatNotifierProvider);
  }

  @override
  void dispose() {
    _rentalDateFormFocusNode.dispose();

    super.dispose();
  }

  /*  void onChangedName(String value) {
    ref.read(boatNotifierProvider.notifier).updateName(value);
  }*/

  /*  void onChangedRentalStart(String value) {
    ref.read(boatNotifierProvider.notifier).updateName(value);
  }*/

  /*  void onChangedRentalEnd(String value) {
    ref.read(boatNotifierProvider.notifier).updateName(value);
  }*/

  /*  void onChangedTypesOfBoat(String value) {
    ref.read(boatNotifierProvider.notifier).updateName(value);
  }*/

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
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          final currentState = _formKey.currentState;
          if (currentState != null && currentState.validate()) {
            _formViewModel.createOrUpdateBoat();
            Navigator.pop(context);
          }
        },
        child: const Text('Save'),
      ),
    );
  }

  Widget _buildFormWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildUserNameFormWidget(),
          const SizedBox(height: 16),
          _buildOwnerNameFormWidget(),
          const SizedBox(height: 16),
          _buildLocDateFormWidget(),
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
  }

  Widget _buildUserNameFormWidget() {
    return TextFormField(
      initialValue: _formViewModel.initialUserNameValue(),
      maxLength: 20,
      onChanged: (value) => _formViewModel.setName(value),
      // onChanged: (value) => onChangedName(value),
      validator: (_) => _formViewModel.validateName(),
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
      initialValue: _formViewModel.initialOwnerNameValue(),
      maxLength: 150,
      onChanged: (value) => _formViewModel.setOwnerName(value),
      validator: (_) => _formViewModel.validateName(),
      decoration: const InputDecoration(
        icon: Icon(Icons.view_headline),
        labelText: 'Owner Name',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildTypesOfBoatFormWidget() {
    final newTypes = ref.watch(typesOfBoatNotifierProvider);
    log('${newTypes.length}');
    return Container(
      padding: const EdgeInsets.all(4),
      width: 60,
      height: 60,
      decoration: const BoxDecoration(
          color: Colors.cyanAccent,
          borderRadius: BorderRadius.all(Radius.circular(3.0))),
      child: ListView.builder(
        itemCount: newTypes.length,
        itemBuilder: (context, index) => ListTile(
          selected: true,
          leading: const Icon(
            Icons.directions_boat_filled_rounded,
            color: Colors.cyan,
          ),
          onTap: () {},
          title: Text(
            newTypes[index].name,
            style: context.textTheme.titleMedium,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryOfBoatFormWidget() {
    final newCat = ref.watch(categoriesCnpNotifierProvider);
    log('${newCat.length}');
    return Container(
      padding: const EdgeInsets.all(4),
      width: 60,
      height: 60,
      decoration: const BoxDecoration(
          color: Colors.cyanAccent,
          borderRadius: BorderRadius.all(Radius.circular(3.0))),
      child: ListView.builder(
        dragStartBehavior: DragStartBehavior.start,
        controller:
            ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true),
        itemCount: newCat.length,
        itemBuilder: (context, index) => ListTile(
          selected: true,
          leading: const Icon(
            Icons.category_sharp,
            color: Colors.cyan,
          ),
          onTap: () {},
          title: Text(
            newCat[index].name,
            style: context.textTheme.titleMedium,
          ),
        ),
      ),
    );
  }

  Widget _buildIdentityNumberOfBoatFormWidget() {
    final newIdentity = ref.watch(identityNumberNotifierProvider);
    log('${newIdentity.length}');
    return Container(
      padding: const EdgeInsets.all(4),
      width: 60,
      height: 60,
      decoration: BoxDecoration(
          color: Colors.cyanAccent,
          border: Border.all(color: Colors.black38),
          borderRadius: const BorderRadius.all(Radius.circular(3.0))),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: newIdentity.length,
        itemBuilder: (context, index) => ListTile(
          selected: true,
          leading: const Icon(
            Icons.perm_identity_sharp,
            color: Colors.black45,
          ),
          onTap: () {},
          title: Text(
            newIdentity[index].name,
            style: context.textTheme.titleMedium,
          ),
        ),
      ),
    );
  }

  Widget _buildLocDateFormWidget() {
    return TextFormField(
      focusNode: _rentalDateFormFocusNode,
      controller: _textEditingController,
      maxLength: 70,
      onTap: () => _showDatePicker(context),
      onChanged: (value) => _formViewModel.createOrUpdateBoat(),
      validator: (_) => _formViewModel.validateDateInset(),
      decoration: const InputDecoration(
        icon: Icon(Icons.calendar_today_rounded),
        labelText: 'created date',
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

  Future<bool?> _onChangedAvailableValue(final DateTime d, bool value) async {
    if (d.isUtc) {
      value = true;
      ref.read(boatNotifierProvider.notifier).updateIsAvailableValue(value);
      return boat.isAvailable;
    } else {
      value = false;
      ref.read(boatNotifierProvider.notifier).updateIsAvailableValue(value);
      return boat.isAvailable;
    }
  }

  Future<DateTime?> _showDatePicker(final BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: _formViewModel.initialLocDateValue(),
        currentDate: _formViewModel.initialLocDateValue(),
        firstDate: _formViewModel.datePickerFirstDate(),
        lastDate: _formViewModel.datePickerLastDate(),
        initialEntryMode: DatePickerEntryMode.calendar,
        initialDatePickerMode: DatePickerMode.day,
        confirmText: 'Done');
    if (selectedDate != null) {
      _textEditingController.text =
          DateFormat('dd/MM/yyyy').format(selectedDate);
      _onChangedAvailableValue(selectedDate, true);
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
      _textEditingController.text = DateFormat.HOUR24_MINUTE;
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
}

class _DisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
