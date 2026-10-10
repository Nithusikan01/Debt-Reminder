import 'package:drift/drift.dart';

/// One letter-to-digit assignment in the user's price code. Several letters
/// may map to the same digit (many-to-one); each letter itself maps to
/// exactly one digit, which is what makes decoding unambiguous.
@DataClassName('PriceCodeLetterRow')
class PriceCodeLetters extends Table {
  TextColumn get letter => text()(); // single uppercase A-Z character
  IntColumn get digit => integer()(); // 0-9

  @override
  Set<Column> get primaryKey => {letter};
}
