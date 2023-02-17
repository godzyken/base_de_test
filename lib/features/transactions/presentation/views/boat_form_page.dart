import 'package:base_de_test/features/transactions/domain/entities/boat_entity.dart';
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
  final _locDateFormFocusNode = _DisabledFocusNode();
  late TextEditingController _textEditingController;

  _BoatFormPageState();

  @override
  void initState() {
    super.initState();

    _formViewModel = ref.read(boatFormViewModelProvider(widget.boat));
    _textEditingController = TextEditingController(
        text: DateFormat('yyyy/MM/dd')
            .format(_formViewModel.initialLocDateValue()));
  }

  @override
  void dispose() {
    _locDateFormFocusNode.dispose();

    super.dispose();
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
          _buildLocDateFormWidget()
        ],
      ),
    );
  }

  Widget _buildUserNameFormWidget() {
    return TextFormField(
      initialValue: _formViewModel.initialUserNameValue(),
      maxLength: 20,
      onChanged: (value) => _formViewModel.setName(value),
      validator: (_) => _formViewModel.validateName(),
      decoration: const InputDecoration(
        icon: Icon(Icons.edit),
        labelText: 'Title',
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

  Widget _buildLocDateFormWidget() {
    return TextFormField(
      focusNode: _locDateFormFocusNode,
      controller: _textEditingController,
      maxLength: 50,
      onTap: () => _showDatePicker(context),
      onChanged: (value) => _formViewModel.setName(value),
      validator: (_) => _formViewModel.validateName(),
      decoration: const InputDecoration(
        icon: Icon(Icons.calendar_today_rounded),
        labelText: 'LocDate',
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

  Future<DateTime?> _showDatePicker(final BuildContext context) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _formViewModel.initialLocDateValue(),
      firstDate: _formViewModel.datePickerFirstDate(),
      lastDate: _formViewModel.datePickerLastDate(),
    );
    if (selectedDate != null) {
      _textEditingController.text =
          DateFormat('yyyy/MM/dd').format(selectedDate);
      _formViewModel.setStartLocation(selectedDate);
    }

    return null;
  }

  _showConfirmDeleteBoatLocationDialog() async {
    final bool result = await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: const Text('Delete ToDo?'),
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
