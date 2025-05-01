part of '../extensions.dart';

// ignore: public_member_api_docs
extension JsonExtension on Json {
  ///Returns a valid [String] which has characters length greater than [1] and not equal to ["null"]
  ///Otherwise [null] will be returned.
  ///Used inside [fromJson]
  String? nullableString(final String key, {final bool alllowEmpty = true}) {
    final String? text = this[key] == null ? null : '${this[key]}';

    ///If empty string is not allowed, then check if the string is empty string or not
    ///If empty, then return [null]
    if (alllowEmpty == false && text != null) {
      return text.isValid ? text : null;
    }

    return text;
  }

  ///Returns a [String] which is not [null]
  String safeString(final String key, {final String orElse = ''}) {
    return nullableString(key) ?? orElse;
  }

  /// This returns any given input as [int].
  /// Usage: some of the [double] formats are causing issues when delivering from the front end.
  /// If the parsed data is [null], the [orElse] data will be used as output.
  /// If no [orElse] value is given, [0] will be returned.
  int safeInt(
    final String key, {
    final int orElse = 0,
  }) =>
      int.tryParse('${this[key]}') ?? orElse;

  /// Returns [double] if any values are found as valid.
  double? nullableDouble(final String key) => double.tryParse('${this[key]}')?.toFixedDigit;

  ///Parses the double values from Json
  double safeDouble(final String key, {final double? orElse}) {
    final double result = nullableDouble(key) ?? orElse ?? 0;
    return result.toFixedDigit;
  }

  /// Returns [int] if any values are found as valid.
  int? nullableInt(final String key) => int.tryParse('${this[key]}');

  ///Parses the value as [bool]
  bool safeBool(final String key, {final bool orElse = false}) => (this[key] ?? orElse) as bool;

  ///Parses the [createdAt] value as [int]
  ///A common access is applied, because 99% of the models we create will
  int get createdAt => safeInt('createdAt', orElse: DateTime.now().millisecondsSinceEpoch);

  ///Last time the data is updated at, If no updated at value found, then created at value will be considered
  int get updatedAt => safeInt('updatedAt', orElse: DateTime.now().millisecondsSinceEpoch);

  ///Parses the given Json with the given key and returns if any Json is available
  Json? nullableJson(final String key) => this[key] is Json ? (this[key] as Json) : null;

  ///Returns a safe Json
  Json safeJson(final String key) => nullableJson(key) ?? <String, dynamic>{};

  ///Generates a List of dynamic from the given key inside the Json
  List<T> safeList<T>(final String key) {
    final List<T> list = <T>[];
    if (this[key] is List) {
      for (final dynamic e in this[key] as List<dynamic>) {
        if (e is T) {
          list.add(e);
        } else {
          debugPrint('mismatching data format!');
        }
      }
    }
    return list;
  }

  ///Returns the List from the given [key]
  List<String> safeListOfStrings(
    final String key, {
    final List<String> orElse = const <String>[],
  }) =>
      this[key] is List<dynamic> ? (this[key] as List<dynamic>).toListOfStrings : orElse;

  ///Returns the enum type from the identified [String]
  T? nullableEnum<T>(final String key, final List<T> values) {
    return nullableString(key)?.toEnum<T>(values);
  }

  ///Returns the enum type from the identified [String]
  T safeEnum<T>(final String key, final List<T> values, {final T? orElse}) {
    return nullableEnum(key, values) ?? orElse ?? values.last;
  }

  ///Return the list of given Models which are to be generated from a Json factory constructor
  List<T> safeModels<T>(final String key, final T Function(Json j) fromJson) {
    return safeList<Json>(key).map<T>(fromJson).toList();
  }

  ///Returns the list of Enums from given Json
  List<T> safeEnums<T>(final String key, final List<T> values) => safeList<String>(key).toEnums(values);

  ///Trying to render an Icon based on given [codePoint] value
  IconData? icon(final String key) {
    final int? codePoint = nullableInt(key);
    return codePoint == null ? null : IconData(codePoint, fontFamily: 'MaterialIcons');
  }

  ///Parses the color from the given Json
  Color? color(final String key, {final Color? orElse}) {
    return '${this[key]}'.color(orElse: orElse);
  }

  ///Returns the date object from the given Json data
  DateTime safeDateTime(final String key, {final DateTime? orElse}) {
    return nullableDateTime(key) ?? orElse ?? DateTime.now();
  }

  ///Returns the date object from the given Json data
  ///If the data is not valid, this will return [null]
  DateTime? nullableDateTime(final String key) {
    if (this[key] is int) {
      return DateTime.fromMillisecondsSinceEpoch(this[key] as int);
    } else if (this[key] is String) {
      return DateTime.tryParse('${this[key]}');
    } else if (this[key] is DateTime) {
      return this[key] as DateTime;
    }
    return null;
  }

  ///To return the time value from given json
  TimeOfDay? nullableTimeOfDay(final String key) {
    if (this[key] == null) {
      return null;
    } else {
      return safeTimeOfDay(key);
    }
  }

  ///Parses TimeOfDay from the given Json
  TimeOfDay safeTimeOfDay(final String key) {
    TimeOfDay timeOfDay = const TimeOfDay(hour: 0, minute: 0);
    final String timeString = '${this[key]}';
    final List<String> parts = timeString.split(':');

    if (parts.length == 2) {
      final int hour = int.tryParse(parts[0]) ?? 0;
      final int minute = int.tryParse(parts[1]) ?? 0;

      if (hour >= 0 && hour <= 23 && minute >= 0 && minute <= 59) {
        timeOfDay = TimeOfDay(hour: hour, minute: minute);
      }
    }
    return timeOfDay;
  }

  ///Removes all the [key], [value] pairs which has [null] values
  Json get treeshaken {
    final Json raw = <String, dynamic>{};

    forEach((final String key, final Object? value) {
      if (value != null) {
        ///Array
        if (value is List) {
          if (value.isNotEmpty) {
            raw.putIfAbsent(key, () => value);
          }

          ///Map
        } else if (value is Map) {
          if (value.keys.isNotEmpty) {
            raw.putIfAbsent(key, () => value);
          }

          ///bool
        } else if (value is bool) {
          if (value == true) {
            raw.putIfAbsent(key, () => value);
          }

          ///Other data types
        } else {
          raw.putIfAbsent(key, () => value);
        }
      }
    });
    return raw;
  }
}

extension MapExtension<K, V> on Map<K, V> {
  /// Inserts [value] for [key] if it does not exist.
  /// Updates [key] with [value] if [key] already exists.
  void set(final K key, final V value) {
    if (containsKey(key)) {
      /// Update existing key with new value.
      update(key, (final _) => value);
    } else {
      /// Insert new key-value pair.
      putIfAbsent(key, () => value);
    }
  }
}
