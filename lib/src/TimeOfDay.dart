part of '../extensions.dart';

///Custom extension for TimeOfDay data type
extension TimeOfDayExtension on TimeOfDay {
  ///Converts as 8:13 and 17:34 to save in sql database as String
  String get toSQL => '${hour}:${minute}';

  ///Creates new instance of the data
  TimeOfDay copyWith({
    int? hour,
    int? minute,
  }) {
    return TimeOfDay(
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
    );
  }

  ///A function which adds the given duration
  TimeOfDay add(Duration duration) {
    final DateTime temp = DateTime.now().copyWith(
      hour: this.hour,
      minute: this.minute + duration.inMinutes,
    );
    return TimeOfDay.fromDateTime(temp);
  }

  ///Returns the millisecondEapoch value of this TimeOfDay value
  int get millis => baseDate.copyWith(hour: this.hour, minute: this.minute).millisecondsSinceEpoch;
}
