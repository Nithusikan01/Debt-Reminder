import '../../core/enums/reminder_offset.dart';

/// Derives a stable 31-bit int notification id from a debt reference id and
/// reminder offset, so the same (reference, offset) pair always maps to the
/// same plugin notification id and can be cancelled without a lookup.
class NotificationIdCodec {
  const NotificationIdCodec._();

  static int encode(String referenceId, ReminderOffset offset) {
    final key = '$referenceId|${offset.name}';
    var hash = 0x811c9dc5; // FNV-1a 32-bit offset basis
    for (final byte in key.codeUnits) {
      hash ^= byte;
      hash = (hash * 0x01000193) & 0xFFFFFFFF; // FNV prime, keep 32-bit
    }
    return hash & 0x7FFFFFFF; // fit signed 32-bit int, always positive
  }
}
