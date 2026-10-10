import '../local/database.dart';

/// All letters currently assigned to one digit, for the setup screen.
class PriceCodeDigitGroup {
  final int digit;
  final List<String> letters;

  const PriceCodeDigitGroup({required this.digit, required this.letters});
}

class PriceCodeRepository {
  final AppDatabase _db;

  PriceCodeRepository(this._db);

  /// One group per digit 0-9, in order, each with its currently assigned
  /// letters (possibly empty).
  Stream<List<PriceCodeDigitGroup>> watchGroupedByDigit() {
    return _db.select(_db.priceCodeLetters).watch().map((rows) {
      final byDigit = <int, List<String>>{
        for (var d = 0; d <= 9; d++) d: [],
      };
      for (final row in rows) {
        byDigit[row.digit]!.add(row.letter);
      }
      return [
        for (var d = 0; d <= 9; d++)
          PriceCodeDigitGroup(digit: d, letters: byDigit[d]!..sort()),
      ];
    });
  }

  Future<Map<String, int>> getLetterToDigitMap() async {
    final rows = await _db.select(_db.priceCodeLetters).get();
    return {for (final row in rows) row.letter: row.digit};
  }

  Future<bool> hasAnyMapping() async {
    final rows = await _db.select(_db.priceCodeLetters).get();
    return rows.isNotEmpty;
  }

  Future<void> assignLetter(String letter, int digit) async {
    final normalized = letter.toUpperCase();
    await _db.into(_db.priceCodeLetters).insertOnConflictUpdate(
          PriceCodeLettersCompanion.insert(letter: normalized, digit: digit),
        );
  }

  Future<void> removeLetter(String letter) async {
    await (_db.delete(_db.priceCodeLetters)
          ..where((t) => t.letter.equals(letter.toUpperCase())))
        .go();
  }

  Future<void> resetAll() async {
    await _db.delete(_db.priceCodeLetters).go();
  }

  /// Decodes a letter code into its digit string using the current mapping.
  /// Returns null if any character isn't a mapped letter.
  Future<String?> decode(String code) async {
    final mapping = await getLetterToDigitMap();
    final buffer = StringBuffer();
    for (final char in code.toUpperCase().split('')) {
      final digit = mapping[char];
      if (digit == null) return null;
      buffer.write(digit);
    }
    return buffer.toString();
  }
}
