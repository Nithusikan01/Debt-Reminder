import 'package:flutter/material.dart';

import '../../../core/enums/frequency_type.dart';

class FrequencyPicker extends StatelessWidget {
  final FrequencyType selected;
  final int? intervalDays;
  final int? dayOfMonth;
  final ValueChanged<FrequencyType> onTypeChanged;
  final ValueChanged<int?> onIntervalDaysChanged;
  final ValueChanged<int?> onDayOfMonthChanged;

  const FrequencyPicker({
    super.key,
    required this.selected,
    required this.intervalDays,
    required this.dayOfMonth,
    required this.onTypeChanged,
    required this.onIntervalDaysChanged,
    required this.onDayOfMonthChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Repeats'),
        const SizedBox(height: 8),
        SegmentedButton<FrequencyType>(
          segments: const [
            ButtonSegment(value: FrequencyType.daily, label: Text('Daily')),
            ButtonSegment(value: FrequencyType.monthlyOnDay, label: Text('Monthly')),
            ButtonSegment(value: FrequencyType.customIntervalDays, label: Text('Custom')),
          ],
          selected: {selected},
          onSelectionChanged: (set) => onTypeChanged(set.first),
        ),
        const SizedBox(height: 12),
        if (selected == FrequencyType.monthlyOnDay)
          TextFormField(
            key: const ValueKey('dayOfMonth'),
            initialValue: dayOfMonth?.toString(),
            decoration: const InputDecoration(labelText: 'Day of month (1-31)'),
            keyboardType: TextInputType.number,
            onChanged: (v) => onDayOfMonthChanged(int.tryParse(v)),
          ),
        if (selected == FrequencyType.customIntervalDays)
          TextFormField(
            key: const ValueKey('intervalDays'),
            initialValue: intervalDays?.toString(),
            decoration: const InputDecoration(labelText: 'Every N days'),
            keyboardType: TextInputType.number,
            onChanged: (v) => onIntervalDaysChanged(int.tryParse(v)),
          ),
      ],
    );
  }
}
