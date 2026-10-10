import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theming/app_colors.dart';
import '../../data/providers.dart';
import '../../data/repositories/price_code_repository.dart';
import 'price_code_setup_controller.dart';

class PriceCodeSetupScreen extends ConsumerWidget {
  const PriceCodeSetupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupsAsync = ref.watch(priceCodeGroupsProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => context.pop(),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.chevron_left, size: 22),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Price Code',
                      style: GoogleFonts.fraunces(fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                  ),
                  groupsAsync.when(
                    data: (groups) {
                      final hasAny = groups.any((g) => g.letters.isNotEmpty);
                      if (!hasAny) return const SizedBox.shrink();
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.brandSoft,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check, size: 12, color: AppColors.brand),
                            SizedBox(width: 4),
                            Text('Saved',
                                style: TextStyle(
                                    fontSize: 10.5, fontWeight: FontWeight.w600, color: AppColors.brand)),
                          ],
                        ),
                      );
                    },
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Text(
                'Assign one or more letters to each digit. Multiple letters can share a digit for extra privacy — the app remembers this code until you reset it.',
                style: TextStyle(fontSize: 12.5, color: AppColors.text2, height: 1.55),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: groupsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, st) => Center(child: Text('Error: $e')),
                data: (groups) => ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                  itemCount: groups.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) => _DigitRow(group: groups[index]),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 26),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.dangerSoft,
                        foregroundColor: AppColors.dangerText,
                        side: BorderSide.none,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      onPressed: () => _confirmReset(context, ref),
                      child: const Text('Reset Code', style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.brand,
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      onPressed: () => context.push('/settings/price-code/decode'),
                      child: const Text('Done — Decode', style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmReset(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset price code?'),
        content: const Text('This removes every letter you\'ve assigned. This can\'t be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Reset', style: TextStyle(color: AppColors.danger)),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(priceCodeSetupControllerProvider).resetAll();
    }
  }
}

class _DigitRow extends ConsumerWidget {
  final PriceCodeDigitGroup group;
  const _DigitRow({required this.group});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.brand,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '${group.digit}',
              style: GoogleFonts.fraunces(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                for (final letter in group.letters)
                  _LetterChip(
                    letter: letter,
                    onRemove: () =>
                        ref.read(priceCodeSetupControllerProvider).removeLetter(letter),
                  ),
                InkWell(
                  onTap: () => _addLetter(context, ref, group.digit),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 26,
                    height: 26,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.border, width: 1.5),
                    ),
                    child: const Icon(Icons.add, size: 14, color: AppColors.text3),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addLetter(BuildContext context, WidgetRef ref, int digit) async {
    final controller = TextEditingController();
    final letter = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add a letter for $digit'),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLength: 1,
          textCapitalization: TextCapitalization.characters,
          decoration: const InputDecoration(hintText: 'A-Z'),
          onSubmitted: (v) => Navigator.of(context).pop(v),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: const Text('Add'),
          ),
        ],
      ),
    );

    if (letter == null) return;
    final trimmed = letter.trim();
    if (trimmed.isEmpty || !RegExp(r'^[a-zA-Z]$').hasMatch(trimmed)) return;

    await ref.read(priceCodeSetupControllerProvider).assignLetter(trimmed, digit);
  }
}

class _LetterChip extends StatelessWidget {
  final String letter;
  final VoidCallback onRemove;

  const _LetterChip({required this.letter, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onRemove,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.fromLTRB(9, 4, 6, 4),
        decoration: BoxDecoration(
          color: AppColors.brandSoft,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(letter,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.brand)),
            const SizedBox(width: 5),
            const Icon(Icons.close, size: 12, color: AppColors.brand),
          ],
        ),
      ),
    );
  }
}
