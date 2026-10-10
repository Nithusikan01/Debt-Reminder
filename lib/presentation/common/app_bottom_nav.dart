import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theming/app_colors.dart';

enum AppTab { home, history, alerts, settings }

class AppBottomNav extends StatelessWidget {
  final AppTab current;

  const AppBottomNav({super.key, required this.current});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: Icons.home_outlined,
            label: 'Home',
            active: current == AppTab.home,
            onTap: () => context.go('/'),
          ),
          _NavItem(
            icon: Icons.history,
            label: 'History',
            active: current == AppTab.history,
            onTap: () => context.go('/history'),
          ),
          const SizedBox(width: 58),
          _NavItem(
            icon: Icons.notifications_outlined,
            label: 'Alerts',
            active: current == AppTab.alerts,
            onTap: () => context.go('/notifications'),
          ),
          _NavItem(
            icon: Icons.settings_outlined,
            label: 'Settings',
            active: current == AppTab.settings,
            onTap: () => context.go('/settings'),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.brand : AppColors.text3;
    return InkWell(
      onTap: onTap,
      customBorder: const StadiumBorder(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
