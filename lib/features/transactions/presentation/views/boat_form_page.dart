import 'dart:developer';

import 'package:base_de_test/features/common/presentation/utils/extensions/ui_extension.dart';
import 'package:base_de_test/features/transactions/domain/entities/boat/boat_entity.dart';
import 'package:base_de_test/features/transactions/presentation/controller/boat_notifier.dart';
import 'package:base_de_test/features/transactions/presentation/viewmodel/boatform/boat_form_viewmodel.dart';
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

  /*  void onChangedAvailableValue(String value) {
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
          _buildCategoryOfBoatFormWidget(),
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
        labelText: 'Client Name',
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

  Widget _buildCategoryOfBoatFormWidget() {
    final newTypes = ref.watch(typesOfBoatNotifierProvider);
    log('${newTypes.length}');
    return Container(
      padding: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
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

  Widget _buildLocDateFormWidget() {
    var start = DateTime.now();
    var end = DateTime.now();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: TextFormField(
            focusNode: _rentalDateFormFocusNode,
            controller: _textEditingController,
            maxLength: 70,
            onTap: () => _showDateRangePicker(context),
            onChanged: (value) {
              start = DateTime.parse(value);
              setState(() {
                _textEditingController.text =
                    _formViewModel.setStartLocation(start);
              });
            },
            validator: (_) => _formViewModel.validateDateInset(),
            decoration: const InputDecoration(
              icon: Icon(Icons.calendar_today_rounded),
              labelText: 'rental date',
              helperText: 'Required',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        /*       const SizedBox(
          width: 12,
        ),
        Expanded(
          child: TextFormField(
            focusNode: _returnDateFormFocusNode,
            controller: _textEditingController,
            maxLength: 20,
            onTap: () => _showDateRangePicker(context),
            onChanged: (value) {
              end = DateTime.parse(value);
              setState(() {
                _textEditingController.text =
                    _formViewModel.setStopLocation(end);
              });
            },
            validator: (_) => _formViewModel.validateDateOffset(),
            decoration: const InputDecoration(
              labelText: 'return date',
              helperText: 'Required',
              border: OutlineInputBorder(),
            ),
          ),
        ),*/
      ],
    );
    /*return TextFormField(

    );*/
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
        currentDate: _formViewModel.initialLocDateValue(),
        firstDate: _formViewModel.datePickerFirstDate(),
        lastDate: _formViewModel.datePickerLastDate(),
        initialEntryMode: DatePickerEntryMode.calendar,
        saveText: 'Done');
    if (selectedDate != null) {
      _textEditingController.text =
          DateFormat('dd/MM/yyyy').format(selectedDate.start);
      _formViewModel.setStartLocation(selectedDate.start);
      _formViewModel.setStopLocation(selectedDate.end);

      setState(() => selectedDate);
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

  Future pickDateTime(final BuildContext? context) async {}

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
