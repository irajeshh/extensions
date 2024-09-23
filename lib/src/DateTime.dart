part of '../extensions.dart';

// ignore: public_member_api_docs
extension DateExtension on DateTime {
  String _twoDigit(final int value) {
    return value.toString().padLeft(2, '0');
  }

  ///Returns Date in [2023-04-08] format
  String get ymd => '$year-${_twoDigit(month)}-${_twoDigit(day)}';

  ///Returns Hour & Minute in [07:03 AM] format
  String get hm {
    final int hours = hour;
    final String amPm = hours >= 12 ? 'PM' : 'AM';
    final int h = hours > 12 ? hours - 12 : hours;
    final String h2 = _twoDigit(h);
    final String m = _twoDigit(minute);
    return '$h2:$m $amPm';
  }

  ///Returns Date & Time in [2023-04-08 @ 07:03 AM] format
  String get ymdhm => '$ymd @ $hm';

  ///Returns the no of days in the given date
  int get noOfDaysInMonth {
    final int year = this.year;
    final int month = this.month;
    int days = 31;
    final int mtn = month;
    if (mtn == 2) {
      days = year.isLeapYear ? 29 : 28;
    } else if (<int>[4, 6, 9, 11].contains(mtn)) {
      days = 30;
    }
    return days;
  }

  ///Returns the DateTime value as a human readable format just like social media
  String timeAgo({final String? prefix}) {
    final DateTime dateTime = this;
    final Duration difference = DateTime.now().difference(dateTime);
    final bool isPast = millisecondsSinceEpoch <= DateTime.now().millisecondsSinceEpoch;
    String ago;

    if (difference.inDays > 8) {
      ago = dateTime.toString().substring(0, 10);
    } else if ((difference.inDays / 7).floor() >= 1) {
      ago = isPast ? '1 week ago' : '1 week';
    } else if (difference.inDays >= 2) {
      ago = isPast ? '${difference.inDays} days ago' : '${difference.inDays} days';
    } else if (difference.inDays >= 1) {
      ago = isPast ? 'Yesterday' : 'Tomorrow';
    } else if (difference.inHours >= 2) {
      ago = '${difference.inHours} hours ${isPast ? 'ago' : ''}';
    } else if (difference.inHours >= 1) {
      ago = '1 hour ${isPast ? 'ago' : ''}';
    } else if (difference.inMinutes >= 2) {
      ago = '${difference.inMinutes} minutes ${isPast ? 'ago' : ''}';
    } else if (difference.inMinutes >= 1) {
      ago = '1 minute ${isPast ? 'ago' : ''}';
    } else if (difference.inSeconds >= 3) {
      ago = '${difference.inSeconds} seconds ${isPast ? 'ago' : ''}';
    } else {
      ago = isPast ? 'Just now' : 'now';
    }
    return prefix == null ? ago : '$prefix $ago';
  }

  ///Returns the no of days between this date and given date
  int daysBetween(final DateTime to) {
    DateTime from = this;

    ///Avoid hours & minutes
    from = DateTime(year, month, day);
    final DateTime _to = DateTime(to.year - 1);
    return (_to.difference(from).inHours / 24).round();
  }

  ///Returns the date in the format of [25] [Jan] [2023]
  String get dayMonthYear => '${_twoDigit(day)} ${month.toMonthName} $year';
}

///This value is used to compare [TimeOfDay] values accross the project.
///So this should not be changed!.
DateTime baseDate = DateTime(2000, 1, 1);
