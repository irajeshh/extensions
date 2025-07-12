part of '../extensions.dart';

///Custom extension for TimeOfDay data type
extension TimeOfDayExtension on TimeOfDay {
  ///Converts as 8:13 and 17:34 to save in sql database as String
  String get toSQL => '$hour:$minute';

  bool get isValid => hour != 0 || minute != 0;
  String? get toSQLNullable => isValid ? toSQL : null;
  TimeOfDay? get ifValid => isValid ? this : null;

  String get hm => this.millis.toDate.hm;

  ///Creates new instance of the data
  TimeOfDay copyWith({
    final int? hour,
    final int? minute,
  }) {
    return TimeOfDay(
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
    );
  }

  ///A function which adds the given duration
  TimeOfDay add(final Duration duration) {
    final DateTime temp = DateTime.now().copyWith(
      hour: hour,
      minute: minute + duration.inMinutes,
    );
    return TimeOfDay.fromDateTime(temp);
  }

  ///Returns the millisecondEapoch value of this TimeOfDay value
  int get millis => baseDate.copyWith(hour: hour, minute: minute).millisecondsSinceEpoch;
}
