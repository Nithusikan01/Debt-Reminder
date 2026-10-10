import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theming/app_colors.dart';
import '../../core/utils/date_formatting.dart';
import '../../data/providers.dart';

class PriceCodeDecoderScreen extends ConsumerStatefulWidget {
  const PriceCodeDecoderScreen({super.key});

  @override
  ConsumerState<PriceCodeDecoderScreen> createState() => _PriceCodeDecoderScreenState();
}

class _PriceCodeDecoderScreenState extends ConsumerState<PriceCodeDecoderScreen> {
  final _controller = TextEditingController();
  String _code = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final groupsAsync = ref.watch(priceCodeGroupsProvider);
    final currencyCode = ref.watch(currencyCodeProvider).valueOrNull ?? 'LKR';

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                  Text('Decode Price',
                      style: GoogleFonts.fraunces(fontSize: 22, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Enter the letter code to reveal the price.',
                style: TextStyle(fontSize: 12.5, color: AppColors.text2),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _controller,
                autofocus: true,
                textCapitalization: TextCapitalization.characters,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                  LengthLimitingTextInputFormatter(24),
                ],
                style: GoogleFonts.fraunces(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.brand,
                  letterSpacing: 4,
                ),
                decoration: InputDecoration(
                  hintText: 'e.g. CFAKA',
                  filled: true,
                  fillColor: AppColors.surface,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: AppColors.brand, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: AppColors.brand, width: 1.5),
                  ),
                ),
                onChanged: (v) => setState(() => _code = v.toUpperCase()),
              ),
              const SizedBox(height: 12),
              groupsAsync.when(
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
                data: (groups) {
                  final mapping = <String, int>{
                    for (final g in groups)
                      for (final letter in g.letters) letter: g.digit,
                  };
                  final trace = _code.split('').where((c) => c.isNotEmpty).map((c) {
                    final digit = mapping[c];
                    return '$c→${digit ?? '?'}';
                  }).join('   ');
                  final decoded = _decode(_code, mapping);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_code.isNotEmpty)
                        Text(trace, style: const TextStyle(fontSize: 12, color: AppColors.text3)),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(22, 20, 22, 22),
                        decoration: BoxDecoration(
                          color: AppColors.brand,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'DECODED AMOUNT',
                              style: TextStyle(fontSize: 12.5, letterSpacing: 0.8, color: AppColors.brandOn),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              decoded == null
                                  ? '—'
                                  : formatAmount(double.parse(decoded), currencyCode),
                              style: GoogleFonts.fraunces(
                                fontSize: 34,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              decoded == null && _code.isNotEmpty
                                  ? 'Unrecognized letter in code'
                                  : '${_code.length} character${_code.length == 1 ? '' : 's'} decoded',
                              style: const TextStyle(fontSize: 13, color: AppColors.brandOn),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _decode(String code, Map<String, int> mapping) {
    if (code.isEmpty) return null;
    final buffer = StringBuffer();
    for (final char in code.split('')) {
      final digit = mapping[char];
      if (digit == null) return null;
      buffer.write(digit);
    }
    return buffer.toString();
  }
}
