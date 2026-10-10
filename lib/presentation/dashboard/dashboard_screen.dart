import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/enums/debt_kind.dart';
import '../../core/theming/app_colors.dart';
import '../../core/utils/date_formatting.dart';
import '../../core/utils/month_grouping.dart';
import '../../data/providers.dart';
import '../../domain/models/dashboard_item.dart';
import '../common/app_bottom_nav.dart';
import '../common/app_fab.dart';
import 'dashboard_controller.dart';
import 'widgets/debt_list_tile.dart';
import 'widgets/month_chip_row.dart';
import 'widgets/overdue_banner.dart';
import 'widgets/summary_cards.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(dashboardItemsProvider);
    final currencyCode = ref.watch(currencyCodeProvider).valueOrNull ?? 'LKR';

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Stack(
          children: [
            itemsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, st) => Center(child: Text('Something went wrong: $err')),
              data: (items) => _DashboardBody(items: items, currencyCode: currencyCode),
            ),
            const AppFab(),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(current: AppTab.home),
    );
  }
}

class _DashboardBody extends StatefulWidget {
  final List<DashboardItem> items;
  final String currencyCode;

  const _DashboardBody({required this.items, required this.currencyCode});

  @override
  State<_DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<_DashboardBody> {
  String? _selectedMonthKey;

  @override
  Widget build(BuildContext context) {
    final items = widget.items;
    final currencyCode = widget.currencyCode;
    final overdueItems = items.where((i) => i.isOverdue).toList();
    final total = items.fold<double>(0, (sum, i) => sum + i.amount);
    final now = DateTime.now();
    final thisMonthTotal = items
        .where((i) => i.dueDate.year == now.year && i.dueDate.month == now.month)
        .fold<double>(0, (sum, i) => sum + i.amount);
    final monthGroups = groupByMonth(items);
    final visibleGroups = _selectedMonthKey == null
        ? monthGroups
        : monthGroups.where((g) => g.key == _selectedMonthKey).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 110),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dashboard',
                  style: GoogleFonts.fraunces(fontSize: 26, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Track what you owe',
                  style: TextStyle(fontSize: 13, color: AppColors.text2),
                ),
              ],
            ),
            InkWell(
              onTap: () => context.push('/notifications'),
              borderRadius: BorderRadius.circular(14),
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(Icons.notifications_outlined, size: 20),
                    if (overdueItems.isNotEmpty)
                      Positioned(
                        top: 8,
                        right: 9,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: AppColors.danger,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.bg, width: 2),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        const _DecodePriceButton(),
        const SizedBox(height: 18),
        TotalOutstandingCard(total: total, count: items.length, currencyCode: currencyCode),
        const SizedBox(height: 12),
        SecondaryStatsRow(
          thisMonthTotal: thisMonthTotal,
          upcomingCount: items.length,
          overdueCount: overdueItems.length,
          currencyCode: currencyCode,
        ),
        if (overdueItems.isNotEmpty) ...[
          const SizedBox(height: 18),
          OverdueBanner(overdueItems: overdueItems, currencyCode: currencyCode),
        ],
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Upcoming Payments',
              style: GoogleFonts.fraunces(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            InkWell(
              onTap: () => context.push('/notifications'),
              child: const Text(
                'See all',
                style: TextStyle(fontSize: 12.5, color: AppColors.brand, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (items.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Center(
              child: Text(
                'No debts yet. Tap + to add one.',
                style: TextStyle(color: AppColors.text2),
              ),
            ),
          )
        else ...[
          MonthChipRow(
            groups: monthGroups,
            selectedKey: _selectedMonthKey,
            onSelect: (key) => setState(() => _selectedMonthKey = key),
          ),
          const SizedBox(height: 18),
          for (final group in visibleGroups) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  group.label.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text3,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  formatAmount(group.total, currencyCode),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.brand,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            for (final item in group.items)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: DebtListTile(
                  item: item,
                  currencyCode: currencyCode,
                  onTap: () {
                    final routeKind = item.kind == DebtKind.oneTime ? 'onetime' : 'occurrence';
                    context.push('/debt/$routeKind/${item.referenceId}');
                  },
                ),
              ),
            const SizedBox(height: 8),
          ],
        ],
      ],
    );
  }
}

class _DecodePriceButton extends StatelessWidget {
  const _DecodePriceButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/settings/price-code/decode'),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.brandSoft,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.brand,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.vpn_key_outlined, size: 16, color: Colors.white),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'Decode a price code',
                style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600, color: AppColors.brand),
              ),
            ),
            const Icon(Icons.chevron_right, size: 18, color: AppColors.brand),
          ],
        ),
      ),
    );
  }
}
