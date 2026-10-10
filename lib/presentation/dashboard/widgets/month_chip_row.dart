import 'package:flutter/material.dart';

import '../../../core/theming/app_colors.dart';
import '../../../core/utils/month_grouping.dart';

class MonthChipRow extends StatelessWidget {
  final List<MonthGroup> groups;
  final String? selectedKey; // null = "All"
  final ValueChanged<String?> onSelect;

  const MonthChipRow({
    super.key,
    required this.groups,
    required this.selectedKey,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _Chip(label: 'All', selected: selectedKey == null, onTap: () => onSelect(null)),
          for (final group in groups) ...[
            const SizedBox(width: 8),
            _Chip(
              label: group.shortLabel,
              selected: selectedKey == group.key,
              onTap: () => onSelect(group.key),
            ),
          ],
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _Chip({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? AppColors.brand : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? AppColors.brand : AppColors.border),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: selected ? Colors.white : AppColors.text,
          ),
        ),
      ),
    );
  }
}
