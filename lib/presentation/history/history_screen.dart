import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/enums/debt_kind.dart';
import '../../core/theming/app_colors.dart';
import '../../core/utils/date_formatting.dart';
import '../../data/providers.dart';
import '../common/app_bottom_nav.dart';
import '../common/app_fab.dart';
import 'history_controller.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(historyItemsProvider);
    final currencyCode = ref.watch(currencyCodeProvider).valueOrNull ?? 'LKR';

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Stack(
          children: [
            itemsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Error: $e')),
              data: (items) {
                return ListView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 110),
                  children: [
                    Text(
                      'History',
                      style: GoogleFonts.fraunces(fontSize: 26, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Payments you\'ve already settled',
                      style: TextStyle(fontSize: 13, color: AppColors.text2),
                    ),
                    const SizedBox(height: 18),
                    if (items.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Center(
                          child: Text('No paid debts yet.', style: TextStyle(color: AppColors.text2)),
                        ),
                      )
                    else
                      ...items.map((item) {
                        final routeKind = item.kind == DebtKind.oneTime ? 'onetime' : 'occurrence';
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: InkWell(
                            onTap: () => context.push('/debt/$routeKind/${item.referenceId}'),
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
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: AppColors.brandSoft,
                                      borderRadius: BorderRadius.circular(11),
                                    ),
                                    child: const Icon(Icons.check, size: 18, color: AppColors.brand),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(item.payee,
                                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                                        const SizedBox(height: 2),
                                        Text(
                                          '${item.title} · was due ${formatDueDate(item.dueDate)}',
                                          style: const TextStyle(fontSize: 12, color: AppColors.text2),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    formatAmount(item.amount, currencyCode),
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                  ],
                );
              },
            ),
            const AppFab(),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(current: AppTab.history),
    );
  }
}
