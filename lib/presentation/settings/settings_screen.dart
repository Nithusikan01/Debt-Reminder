import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/constants/currency_presets.dart';
import '../../core/theming/app_colors.dart';
import '../../data/providers.dart';
import '../common/app_bottom_nav.dart';
import '../common/app_fab.dart';
import 'settings_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencyCode = ref.watch(currencyCodeProvider).valueOrNull ?? defaultCurrencyCode;
    final priceCodeGroups = ref.watch(priceCodeGroupsProvider).valueOrNull ?? const [];
    final hasPriceCode = priceCodeGroups.any((g) => g.letters.isNotEmpty);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 110),
              children: [
                Text('Settings', style: GoogleFonts.fraunces(fontSize: 26, fontWeight: FontWeight.w600)),
                const SizedBox(height: 22),
                _SectionLabel('Preferences'),
                const SizedBox(height: 10),
                _SettingsRow(
                  icon: Icons.paid_outlined,
                  label: 'Currency',
                  trailing: currencyCode,
                  onTap: () => _pickCurrency(context, ref, currencyCode),
                ),
                const SizedBox(height: 22),
                _SectionLabel('Privacy'),
                const SizedBox(height: 10),
                _SettingsRow(
                  icon: Icons.vpn_key_outlined,
                  label: 'Price Code',
                  subtitle: 'Encode amounts with letters',
                  badge: hasPriceCode ? 'Saved' : null,
                  onTap: () => context.push('/settings/price-code'),
                ),
                const SizedBox(height: 22),
                _SectionLabel('Reminders'),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.brandSoft,
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: const Icon(Icons.notifications_outlined, size: 17, color: AppColors.brand),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Reminder schedule',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                            SizedBox(height: 2),
                            Text(
                              '7, 5, 3 and 1 days before each due date.',
                              style: TextStyle(fontSize: 12, color: AppColors.text2, height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                _SectionLabel('About'),
                const SizedBox(height: 10),
                const _SettingsRow(
                  icon: Icons.info_outline,
                  label: 'TR Ledger',
                  trailing: 'v0.1.0',
                ),
              ],
            ),
            const AppFab(),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(current: AppTab.settings),
    );
  }

  Future<void> _pickCurrency(BuildContext context, WidgetRef ref, String currentCode) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: RadioGroup<String>(
            groupValue: currentCode,
            onChanged: (value) {
              if (value != null) {
                ref.read(settingsControllerProvider).setCurrencyCode(value);
              }
              Navigator.of(context).pop();
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 18, 20, 4),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Currency', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  ),
                ),
                ...currencyPresets.map((code) => RadioListTile<String>(
                      value: code,
                      title: Text('$code (${currencySymbols[code]})'),
                    )),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.text3,
        letterSpacing: 0.5,
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final String? trailing;
  final String? badge;
  final VoidCallback? onTap;

  const _SettingsRow({
    required this.icon,
    required this.label,
    this.subtitle,
    this.trailing,
    this.badge,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = Container(
      padding: const EdgeInsets.all(14),
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
            child: Icon(icon, size: 17, color: AppColors.brand),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(subtitle!, style: const TextStyle(fontSize: 12, color: AppColors.text2)),
                ],
              ],
            ),
          ),
          if (badge != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.brandSoft,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(badge!,
                  style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: AppColors.brand)),
            ),
            const SizedBox(width: 8),
          ],
          if (trailing != null)
            Text(trailing!, style: const TextStyle(fontSize: 13, color: AppColors.text2)),
          if (onTap != null) ...[
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right, size: 18, color: AppColors.text3),
          ],
        ],
      ),
    );

    if (onTap == null) return content;
    return InkWell(onTap: onTap, borderRadius: BorderRadius.circular(16), child: content);
  }
}
