part of '../extensions.dart';

// ignore: public_member_api_docs
extension Extension on int {
  ///Returns the name of the month if the given number is a valid month index
  String get toMonthName {
    return this > 0 ? months[this - 1] : '$this';
  }

  /// Returns the full name of the month if the given number is a valid month index.
  String get toMonthNameFull {
    return this > 0 ? monthsFullName[this - 1] : '$this';
  }

  ///List of month names
  static const List<String> months = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  /// List of full month names
  static const List<String> monthsFullName = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  ///Checks if this number is a leap year or not
  bool get isLeapYear {
    final int year = toInt();
    if (year % 400 == 0) {
      return true;
    } else if (year % 100 == 0) {
      return false;
    } else if (year % 4 == 0) {
      return true;
    } else {
      return false;
    }
  }

  ///Returns [DateTime] from the given number
  DateTime get toDate => DateTime.fromMillisecondsSinceEpoch(toInt());

  ///Return the file size in a readable format
  String get fileSize {
    String _valueString = '0';
    String _valueUnit = 'KB';
    if (this > 0) {
      final int digitGroups = (log(this) / log(1000)).floor();
      switch (digitGroups) {
        case 0:
          _valueString = NumberFormat('#,##0.#').format(this);
          _valueUnit = 'KB';
          break;
        case 1:
          _valueString = NumberFormat('#,##0.#').format(this / 1000);
          _valueUnit = 'KB';
          break;
        case 2:
          _valueString = NumberFormat('#,##0.#').format(this / pow(1000, 2));
          _valueUnit = 'MB';
          break;
        case 3:
          _valueString = NumberFormat('#,##0.#').format(this / pow(1000, 3));
          _valueUnit = 'GB';
          break;
        case 4:
          _valueString = NumberFormat('#,##0.#').format(this / pow(1000, 4));
          _valueUnit = 'TB';
          break;
        default:
          _valueString = NumberFormat('#,##0.#').format(this / pow(1000, 5));
          _valueUnit = 'PB';
      }
    }
    return '$_valueString $_valueUnit';
  }

  ///Returns the given value, only if that is greater than the given [val]
  int? ifGreater([final int val = 0]) {
    return this > val ? this : null;
  }
}
