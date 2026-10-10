import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theming/app_colors.dart';
import '../../../core/utils/date_formatting.dart';

class TotalOutstandingCard extends StatelessWidget {
  final double total;
  final int count;
  final String currencyCode;

  const TotalOutstandingCard({
    super.key,
    required this.total,
    required this.count,
    required this.currencyCode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 24),
      decoration: BoxDecoration(
        color: AppColors.brand,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.account_balance_wallet_outlined, size: 16, color: AppColors.brandOn),
              const SizedBox(width: 8),
              Text(
                'TOTAL OUTSTANDING',
                style: TextStyle(
                  fontSize: 12.5,
                  letterSpacing: 0.8,
                  color: AppColors.brandOn,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            formatAmount(total, currencyCode),
            style: GoogleFonts.fraunces(
              fontSize: 37,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.15,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Across $count payment${count == 1 ? '' : 's'}',
            style: const TextStyle(fontSize: 13, color: AppColors.brandOn),
          ),
        ],
      ),
    );
  }
}

class SecondaryStatsRow extends StatelessWidget {
  final double thisMonthTotal;
  final int upcomingCount;
  final int overdueCount;
  final String currencyCode;

  const SecondaryStatsRow({
    super.key,
    required this.thisMonthTotal,
    required this.upcomingCount,
    required this.overdueCount,
    required this.currencyCode,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.calendar_today_outlined,
            label: 'This Month',
            child: Text(
              formatAmount(thisMonthTotal, currencyCode),
              style: GoogleFonts.fraunces(fontSize: 19, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            icon: Icons.notifications_outlined,
            label: 'Upcoming',
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '$upcomingCount',
                  style: GoogleFonts.fraunces(fontSize: 19, fontWeight: FontWeight.w600),
                ),
                if (overdueCount > 0) ...[
                  const SizedBox(width: 6),
                  Text(
                    '$overdueCount overdue',
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.dangerText,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget child;

  const _StatCard({required this.icon, required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 15, color: AppColors.text2),
              const SizedBox(width: 6),
              Text(label, style: const TextStyle(fontSize: 12, color: AppColors.text2)),
            ],
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
