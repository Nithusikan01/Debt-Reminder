import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'add_one_time_debt_controller.dart';

class AddOneTimeDebtScreen extends ConsumerStatefulWidget {
  const AddOneTimeDebtScreen({super.key});

  @override
  ConsumerState<AddOneTimeDebtScreen> createState() => _AddOneTimeDebtScreenState();
}

class _AddOneTimeDebtScreenState extends ConsumerState<AddOneTimeDebtScreen> {
  final _formKey = GlobalKey<FormState>();
  final _payeeController = TextEditingController();
  final _amountController = TextEditingController();
  final _chequeController = TextEditingController();
  final _notesController = TextEditingController();
  String? _paymentMethod;
  DateTime? _dueDate;
  bool _saving = false;

  @override
  void dispose() {
    _payeeController.dispose();
    _amountController.dispose();
    _chequeController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDueDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked != null) {
      setState(() => _dueDate = picked);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() || _dueDate == null) {
      if (_dueDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please pick a due date')),
        );
      }
      return;
    }

    setState(() => _saving = true);
    await ref.read(addOneTimeDebtControllerProvider).submit(
          payee: _payeeController.text.trim(),
          amount: double.parse(_amountController.text.trim()),
          dueDate: _dueDate!,
          chequeNumber: _chequeController.text.trim().isEmpty
              ? null
              : _chequeController.text.trim(),
          paymentMethod: _paymentMethod,
          notes: _notesController.text.trim().isEmpty
              ? null
              : _notesController.text.trim(),
        );

    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add One-Time Debt')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
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
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(_dueDate == null
                  ? 'Pick due date'
                  : 'Due: ${_dueDate!.toLocal().toString().split(' ').first}'),
              trailing: const Icon(Icons.calendar_month),
              onTap: _pickDueDate,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _paymentMethod,
              decoration: const InputDecoration(labelText: 'Payment method (optional)'),
              items: const [
                DropdownMenuItem(value: 'cash', child: Text('Cash')),
                DropdownMenuItem(value: 'cheque', child: Text('Cheque')),
                DropdownMenuItem(value: 'bank_transfer', child: Text('Bank transfer')),
                DropdownMenuItem(value: 'upi', child: Text('UPI / other digital')),
              ],
              onChanged: (v) => setState(() => _paymentMethod = v),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _chequeController,
              decoration: const InputDecoration(labelText: 'Cheque number (optional)'),
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
