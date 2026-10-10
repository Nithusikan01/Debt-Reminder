import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/enums/debt_kind.dart';
import '../../core/utils/date_formatting.dart';
import '../../data/providers.dart';
import 'debt_detail_controller.dart';

class DebtDetailScreen extends ConsumerWidget {
  final DebtKind kind;
  final String id;

  const DebtDetailScreen({super.key, required this.kind, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return kind == DebtKind.oneTime
        ? _OneTimeDebtDetail(id: id)
        : _OccurrenceDetail(id: id);
  }
}

class _OneTimeDebtDetail extends ConsumerWidget {
  final String id;
  const _OneTimeDebtDetail({required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debtAsync = ref.watch(oneTimeDebtByIdProvider(id));
    final currencyCode = ref.watch(currencyCodeProvider).valueOrNull ?? 'LKR';

    return Scaffold(
      appBar: AppBar(title: const Text('Debt Detail')),
      body: debtAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
        data: (debt) {
          if (debt == null) return const Center(child: Text('Not found'));
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('To: ${debt.payee}', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text('Amount: ${formatAmount(debt.amount, currencyCode)}'),
                Text('Due: ${formatDueDate(debt.dueDate)}'),
                if (debt.chequeNumber != null) Text('Cheque #: ${debt.chequeNumber}'),
                if (debt.paymentMethod != null) Text('Method: ${debt.paymentMethod}'),
                if (debt.notes != null) Text('Notes: ${debt.notes}'),
                const SizedBox(height: 24),
                if (!debt.isPaid)
                  FilledButton.icon(
                    icon: const Icon(Icons.check),
                    label: const Text('Mark as paid'),
                    onPressed: () async {
                      await ref.read(debtDetailControllerProvider).markOneTimePaid(id);
                      if (context.mounted) Navigator.of(context).pop();
                    },
                  )
                else
                  const Text('Paid', style: TextStyle(color: Colors.green)),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Delete'),
                  onPressed: () async {
                    await ref.read(debtDetailControllerProvider).deleteOneTime(id);
                    if (context.mounted) Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _OccurrenceDetail extends ConsumerWidget {
  final String id;
  const _OccurrenceDetail({required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final occurrenceAsync = ref.watch(occurrenceByIdProvider(id));
    final currencyCode = ref.watch(currencyCodeProvider).valueOrNull ?? 'LKR';

    return Scaffold(
      appBar: AppBar(title: const Text('Debt Detail')),
      body: occurrenceAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Error: $e')),
        data: (result) {
          if (result == null) return const Center(child: Text('Not found'));
          final occurrence = result.occurrence;
          final parent = result.parent;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(parent.title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text('To: ${parent.payee}'),
                Text('Amount: ${formatAmount(occurrence.amount, currencyCode)}'),
                Text('Due this cycle: ${formatDueDate(occurrence.expectedDueDate)}'),
                if (parent.notes != null) Text('Notes: ${parent.notes}'),
                const SizedBox(height: 24),
                if (!occurrence.isPaid)
                  FilledButton.icon(
                    icon: const Icon(Icons.check),
                    label: const Text('Mark as paid'),
                    onPressed: () async {
                      await ref.read(debtDetailControllerProvider).markOccurrencePaid(id);
                      if (context.mounted) Navigator.of(context).pop();
                    },
                  )
                else
                  const Text('Paid', style: TextStyle(color: Colors.green)),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  icon: const Icon(Icons.archive_outlined),
                  label: const Text('Stop this recurring debt'),
                  onPressed: () async {
                    await ref
                        .read(debtDetailControllerProvider)
                        .archiveRecurring(parent.id);
                    if (context.mounted) Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
