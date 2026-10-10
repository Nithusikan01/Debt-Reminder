import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theming/app_colors.dart';

/// Raised circular add button, floating above the bottom nav bar, matching
/// the design canvas. Offers one-time vs recurring debt via a popup menu.
class AppFab extends StatelessWidget {
  const AppFab({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 42,
      child: Center(
        child: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'onetime') {
              context.push('/add-one-time');
            } else {
              context.push('/add-recurring');
            }
          },
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'onetime', child: Text('One-time debt')),
            PopupMenuItem(value: 'recurring', child: Text('Recurring debt')),
          ],
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.brand,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.brand.withValues(alpha: 0.35),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 26),
          ),
        ),
      ),
    );
  }
}
