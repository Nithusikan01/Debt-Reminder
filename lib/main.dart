import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app.dart';
import 'data/providers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Fonts are bundled under assets/fonts; never block on a network fetch.
  GoogleFonts.config.allowRuntimeFetching = false;

  final container = ProviderContainer();

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const DebtReminderApp(),
    ),
  );

  // Notification setup (timezone database, permissions, reminder
  // reconciliation) is slow and not needed to draw the dashboard, so it
  // runs after the first frame instead of holding up the splash screen.
  WidgetsBinding.instance.addPostFrameCallback((_) {
    unawaited(_initNotifications(container));
  });
}

Future<void> _initNotifications(ProviderContainer container) async {
  try {
    final notificationService = container.read(notificationServiceProvider);

    await notificationService.init(
      onNotificationTap: (payload) {
        if (payload == null) return;
        final separatorIndex = payload.indexOf(':');
        if (separatorIndex == -1) return;
        final kind = payload.substring(0, separatorIndex);
        final id = payload.substring(separatorIndex + 1);
        final routeKind = kind == 'onetime' ? 'onetime' : 'occurrence';
        appRouter.push('/debt/$routeKind/$id');
      },
    );

    await notificationService.requestPermissions();

    await container.read(notificationReconcilerProvider).reconcileAll();
  } catch (e, st) {
    debugPrint('Notification setup failed: $e\n$st');
  }
}
