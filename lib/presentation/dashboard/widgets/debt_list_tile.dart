import 'package:flutter/material.dart';

import '../../../core/enums/debt_kind.dart';
import '../../../core/theming/app_colors.dart';
import '../../../core/utils/date_formatting.dart';
import '../../../domain/models/dashboard_item.dart';

class DebtListTile extends StatelessWidget {
  final DashboardItem item;
  final String currencyCode;
  final VoidCallback onTap;

  const DebtListTile({
    super.key,
    required this.item,
    required this.currencyCode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final (badgeBg, badgeFg) = AppColors.urgencyBadgeColors(item.daysUntilDue);
    final badgeLabel = AppColors.urgencyBadgeLabel(item.daysUntilDue);
    final isRecurring = item.kind == DebtKind.recurringOccurrence;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isRecurring ? AppColors.brandSoft : const Color(0xFFF3ECE3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                isRecurring ? Icons.repeat : Icons.receipt_long_outlined,
                size: 20,
                color: isRecurring ? AppColors.brand : const Color(0xFF8A6A3F),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.payee,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${item.title} · due ${formatDueDate(item.dueDate)}'
                    '${item.chequeNumber != null ? ' · Cheque #${item.chequeNumber}' : ''}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, color: AppColors.text2),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formatAmount(item.amount, currencyCode),
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: badgeBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    badgeLabel,
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      color: badgeFg,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
