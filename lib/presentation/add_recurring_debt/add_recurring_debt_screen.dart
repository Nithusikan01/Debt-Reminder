import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/enums/frequency_type.dart';
import 'add_recurring_debt_controller.dart';
import 'widgets/frequency_picker.dart';

class AddRecurringDebtScreen extends ConsumerStatefulWidget {
  const AddRecurringDebtScreen({super.key});

  @override
  ConsumerState<AddRecurringDebtScreen> createState() => _AddRecurringDebtScreenState();
}

class _AddRecurringDebtScreenState extends ConsumerState<AddRecurringDebtScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _payeeController = TextEditingController();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();

  FrequencyType _frequencyType = FrequencyType.monthlyOnDay;
  int? _intervalDays;
  int? _dayOfMonth;
  DateTime? _anchorDate;
  bool _saving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _payeeController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickAnchorDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked != null) {
      setState(() {
        _anchorDate = picked;
        _dayOfMonth ??= picked.day;
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() || _anchorDate == null) {
      if (_anchorDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please pick the first due date')),
        );
      }
      return;
    }
    if (_frequencyType == FrequencyType.monthlyOnDay &&
        (_dayOfMonth == null || _dayOfMonth! < 1 || _dayOfMonth! > 31)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid day of month (1-31)')),
      );
      return;
    }
    if (_frequencyType == FrequencyType.customIntervalDays &&
        (_intervalDays == null || _intervalDays! <= 0)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid interval in days')),
      );
      return;
    }

    setState(() => _saving = true);
    await ref.read(addRecurringDebtControllerProvider).submit(
          title: _titleController.text.trim(),
          payee: _payeeController.text.trim(),
          defaultAmount: double.parse(_amountController.text.trim()),
          frequencyType: _frequencyType,
          intervalDays: _frequencyType == FrequencyType.customIntervalDays ? _intervalDays : null,
          dayOfMonth: _frequencyType == FrequencyType.monthlyOnDay ? _dayOfMonth : null,
          anchorDate: _anchorDate!,
          notes: _notesController.text.trim().isEmpty ? null : _notesController.text.trim(),
        );

    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Recurring Debt')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'e.g. Shop Rent, Electricity, Chit Fund',
              ),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _payeeController,
              decoration: const InputDecoration(labelText: 'To whom (payee)'),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Required';
                final parsed = double.tryParse(v.trim());
                if (parsed == null || parsed <= 0) return 'Enter a valid amount';
                return null;
              },
            ),
            const SizedBox(height: 16),
            FrequencyPicker(
              selected: _frequencyType,
              intervalDays: _intervalDays,
              dayOfMonth: _dayOfMonth,
              onTypeChanged: (t) => setState(() => _frequencyType = t),
              onIntervalDaysChanged: (v) => setState(() => _intervalDays = v),
              onDayOfMonthChanged: (v) => setState(() => _dayOfMonth = v),
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(_anchorDate == null
                  ? 'Pick first due date'
                  : 'First due: ${_anchorDate!.toLocal().toString().split(' ').first}'),
              trailing: const Icon(Icons.calendar_month),
              onTap: _pickAnchorDate,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'Notes (optional)'),
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _saving ? null : _submit,
              child: _saving
                  ? const SizedBox(
                      height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
