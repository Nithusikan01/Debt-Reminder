import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/enums/debt_kind.dart';
import 'core/theming/app_theme.dart';
import 'presentation/add_one_time_debt/add_one_time_debt_screen.dart';
import 'presentation/add_recurring_debt/add_recurring_debt_screen.dart';
import 'presentation/dashboard/dashboard_screen.dart';
import 'presentation/debt_detail/debt_detail_screen.dart';
import 'presentation/history/history_screen.dart';
import 'presentation/notifications/notifications_screen.dart';
import 'presentation/price_code/price_code_decoder_screen.dart';
import 'presentation/price_code/price_code_setup_screen.dart';
import 'presentation/settings/settings_screen.dart';

/// Global router instance so notification-tap callbacks (which don't have a
/// BuildContext) can navigate via `appRouter.push(...)`.
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const DashboardScreen()),
    GoRoute(
      path: '/add-one-time',
      builder: (context, state) => const AddOneTimeDebtScreen(),
    ),
    GoRoute(
      path: '/add-recurring',
      builder: (context, state) => const AddRecurringDebtScreen(),
    ),
    GoRoute(
      path: '/debt/:kind/:id',
      builder: (context, state) {
        final kindParam = state.pathParameters['kind'];
        final kind = kindParam == 'onetime' ? DebtKind.oneTime : DebtKind.recurringOccurrence;
        return DebtDetailScreen(kind: kind, id: state.pathParameters['id']!);
      },
    ),
    GoRoute(path: '/history', builder: (context, state) => const HistoryScreen()),
    GoRoute(path: '/notifications', builder: (context, state) => const NotificationsScreen()),
    GoRoute(path: '/settings', builder: (context, state) => const SettingsScreen()),
    GoRoute(
      path: '/settings/price-code',
      builder: (context, state) => const PriceCodeSetupScreen(),
    ),
    GoRoute(
      path: '/settings/price-code/decode',
      builder: (context, state) => const PriceCodeDecoderScreen(),
    ),
  ],
);

class DebtReminderApp extends StatelessWidget {
  const DebtReminderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'TR Ledger',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      routerConfig: appRouter,
    );
  }
}
