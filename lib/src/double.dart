part of '../extensions.dart';

///Indian Rupee symbol
const String rupeeSymbol = '₹';

///Custom extensions over [double] value
extension DoubleExtensions on double {
  ///For this project, the gold and currency accuracy must be 2 digit precise
  ///asked by client
  ///Converts the given double value to [12.54] format
  double get toFixedDigit {
    return double.tryParse(toStringAsFixed(2)) ?? toDouble();
  }

  ///It does the same job similar to toFixedDigit, but it accepts parameters, so we can use it anywhere.
  String fixedDigit({required final int decimalPlace}) {
    final double dbl = toFixedDigit;
    // Convert the double to a string with the specified decimal places
    final String formattedCurrency = dbl.toStringAsFixed(decimalPlace);

    // Split the formatted string into its integer and fractional parts
    final List<String> parts = formattedCurrency.split('.');
    final String integerPart = parts[0];
    String fractionalPart = parts.length > 1 ? parts[1] : '';

    // Add trailing zeros if necessary
    if (fractionalPart.length < decimalPlace) {
      fractionalPart = fractionalPart.padRight(decimalPlace, '0');
    }

    // Combine the integer and fractional parts to form the currency string
    final String result = integerPart + (fractionalPart.isNotEmpty ? '.$fractionalPart' : '');

    return result;
  }

  String get toPercent => '${this.toInt()}%';
  String get toPDFPercentage => '${this.toFixedDigit}%';

  ///Used in UI
  String get toRupees => _to(forPDF: false);

  ///Used in PDF
  String get toPDFRupees => _to(forPDF: true);

  ///Converts the given double as indian rupees
  ///To convert the num into indian currency but for different mode of usage
  String _to({required final bool forPDF}) {
    final String prefix = forPDF ? 'Rs' : rupeeSymbol;
    final NumberFormat formatter = NumberFormat.currency(locale: 'en_IN', symbol: prefix);
    return formatter.format(this);
  }

  ///Eg: 1000 will be converted as One Thousand
  String get toReadableCurrency {
    /// A map that stores the words corresponding to the digits in Indian currency (0-19, 20, 30, 40, 50, 60, 70, 80, 90).
    final Map<int, String> _words = <int, String>{
      0: '',
      1: 'One',
      2: 'Two',
      3: 'Three',
      4: 'Four',
      5: 'Five',
      6: 'Six',
      7: 'Seven',
      8: 'Eight',
      9: 'Nine',
      10: 'Ten',
      11: 'Eleven',
      12: 'Twelve',
      13: 'Thirteen',
      14: 'Fourteen',
      15: 'Fifteen',
      16: 'Sixteen',
      17: 'Seventeen',
      18: 'Eighteen',
      19: 'Nineteen',
      20: 'Twenty',
      30: 'Thirty',
      40: 'Forty',
      50: 'Fifty',
      60: 'Sixty',
      70: 'Seventy',
      80: 'Eighty',
      90: 'Ninety',
    };

    /// A list that stores the words corresponding to the digits in Indian currency (hundred, thousand, lakh, crore).
    final List<String> _digits = <String>['', 'Hundred', 'Thousand', 'Lakh', 'Crore'];

    if (this < 0) {
      return 'Zero';
    }
    if (this > 999999999) {
      return 'Number is too large';
    }
    int wholeNumber = floor();
    int decimal = ((this - wholeNumber) * 100).round();
    String hundred;
    final int digitsLength = wholeNumber.toString().length;
    int i = 0;
    final List<String> str = <String>[];
    while (i < digitsLength) {
      final int divider = (i == 2) ? 10 : 100;
      final int currentNumber = wholeNumber % divider;
      wholeNumber = wholeNumber ~/ divider;
      i += (divider == 10) ? 1 : 2;
      if (currentNumber > 0) {
        final String plural = (str.isNotEmpty && currentNumber > 9) ? 's' : '';
        hundred = (str.length == 1 && str[0] != '') ? ' and ' : '';
        str.add(
          (currentNumber < 21)
              ? '${_words[currentNumber]} ${_digits[str.length]}$plural $hundred'
              : '${_words[(currentNumber / 10).floor() * 10]} ${_words[currentNumber % 10]} ${_digits[str.length]}$plural $hundred',
        );
      } else {
        str.add('');
      }
    }
    String rupees = str.reversed.join();
    String paise;

    final int paisaLength = decimal.toString().length;
    int j = 0;
    final List<String> str2 = <String>[];

    if (decimal > 0) {
      while (j < paisaLength) {
        final int divider = (j == 2) ? 10 : 100;
        final int currentNumber = decimal % divider;
        decimal = decimal ~/ divider;
        j += (divider == 10) ? 1 : 2;
        if (currentNumber > 0) {
          final String plural = (str2.isNotEmpty && currentNumber > 9) ? 's' : '';
          hundred = (str2.length == 1 && str2[0] != '') ? ' and ' : '';
          str2.add(
            (currentNumber < 21)
                ? '${_words[currentNumber]} ${_digits[str2.length]}$plural $hundred'
                : '${_words[(currentNumber / 10).floor() * 10]} ${_words[currentNumber % 10]} ${_digits[str2.length]}$plural $hundred',
          );
        } else {
          str2.add('');
        }
      }
    } else {
      str2.add('');
    }

    paise = str2.reversed.join();

    if (rupees == '') {
      rupees = 'Zero';
    }

    return '$rupees Rupees${paise != '' ? ' and $paise Paise' : ''}';
  }

  ///Returns the given value, only if that is greater than the given [val]
  double? ifGreater([final double val = 0]) {
    return this > val ? this : null;
  }
}
