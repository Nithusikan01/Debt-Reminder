import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/enums/debt_kind.dart';
import '../../core/theming/app_colors.dart';
import '../../data/providers.dart';
import '../../domain/models/dashboard_item.dart';
import '../common/app_bottom_nav.dart';
import '../common/app_fab.dart';
import '../dashboard/dashboard_controller.dart';
import '../dashboard/widgets/debt_list_tile.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

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
              error: (err, st) => Center(child: Text('Error: $err')),
              data: (items) {
                final needsAttention = items.where((i) => i.daysUntilDue <= 1).toList();
                final comingUp = items.where((i) => i.daysUntilDue > 1).toList();

                return ListView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 110),
                  children: [
                    Text(
                      'Notifications',
                      style: GoogleFonts.fraunces(fontSize: 26, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Reminders sorted by urgency',
                      style: TextStyle(fontSize: 13, color: AppColors.text2),
                    ),
                    const SizedBox(height: 22),
                    if (needsAttention.isNotEmpty) ...[
                      _GroupHeader('Needs attention'),
                      const SizedBox(height: 10),
                      ..._buildItems(context, needsAttention, currencyCode),
                      const SizedBox(height: 22),
                    ],
                    if (comingUp.isNotEmpty) ...[
                      _GroupHeader('Coming up'),
                      const SizedBox(height: 10),
                      ..._buildItems(context, comingUp, currencyCode),
                      const SizedBox(height: 22),
                    ],
                    if (items.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Center(
                          child: Text('No reminders yet.', style: TextStyle(color: AppColors.text2)),
                        ),
                      ),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.brandSoft,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Text(
                        'Reminders are sent 7, 5, 3 and 1 days before each due date.',
                        style: TextStyle(fontSize: 12, color: AppColors.brandDark, height: 1.5),
                      ),
                    ),
                  ],
                );
              },
            ),
            const AppFab(),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(current: AppTab.alerts),
    );
  }

  List<Widget> _buildItems(BuildContext context, List<DashboardItem> items, String currencyCode) {
    return items
        .map<Widget>((item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: DebtListTile(
                item: item,
                currencyCode: currencyCode,
                onTap: () {
                  final routeKind = item.kind == DebtKind.oneTime ? 'onetime' : 'occurrence';
                  context.push('/debt/$routeKind/${item.referenceId}');
                },
              ),
            ))
        .toList();
  }
}

class _GroupHeader extends StatelessWidget {
  final String title;
  const _GroupHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.text3,
        letterSpacing: 0.5,
      ),
    );
  }
}
