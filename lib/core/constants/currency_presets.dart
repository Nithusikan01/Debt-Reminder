/// Selectable currency codes for the settings screen, plus a display symbol
/// fallback for codes `intl`'s NumberFormat doesn't render the way users expect.
const List<String> currencyPresets = ['LKR', 'INR', 'USD', 'GBP', 'EUR'];

const Map<String, String> currencySymbols = {
  'LKR': 'Rs.',
  'INR': '₹',
  'USD': '\$',
  'GBP': '£',
  'EUR': '€',
};

const String defaultCurrencyCode = 'LKR';
