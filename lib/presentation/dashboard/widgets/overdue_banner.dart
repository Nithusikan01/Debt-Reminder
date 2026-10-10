import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theming/app_colors.dart';
import '../../../core/utils/date_formatting.dart';
import '../../../domain/models/dashboard_item.dart';

class OverdueBanner extends StatelessWidget {
  final List<DashboardItem> overdueItems;
  final String currencyCode;

  const OverdueBanner({super.key, required this.overdueItems, required this.currencyCode});

  @override
  Widget build(BuildContext context) {
    if (overdueItems.isEmpty) return const SizedBox.shrink();
    final first = overdueItems.first;
    final label = overdueItems.length == 1
        ? '1 payment is overdue'
        : '${overdueItems.length} payments are overdue';

    return InkWell(
      onTap: () => context.push('/notifications'),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          color: AppColors.dangerSoft,
          border: Border.all(color: AppColors.dangerBorder),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: AppColors.danger, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.dangerText,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${first.payee} · ${formatAmount(first.amount, currencyCode)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.dangerText.withValues(alpha: 0.85),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.dangerText, size: 18),
          ],
        ),
      ),
    );
  }
}
