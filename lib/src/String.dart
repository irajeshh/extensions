part of '../extensions.dart';

// ignore: public_member_api_docs
extension StringExtension on String {
  ///Returns the given text by only making the first character in capital and rest in lowe case.
  String get upperCaseFirst {
    if (length > 1) {
      return '${this[0].toUpperCase()}${substring(1, length).toLowerCase()}';
    } else {
      return this;
    }
  }

  ///Returns the given text by only making the first character in capital and rest in lowe case.
  String get upperCaseFirstLeaveOthers {
    if (length > 1) {
      return '${this[0].toUpperCase()}${substring(1, length)}';
    } else {
      return this;
    }
  }

  ///Puts the given String inside qutation
  String get quoted => '❝$this❞';

  ///Removes all the special characters from the given String
  String get filtered {
    return replaceAll(RegExp(r'[^\w\s]+'), '')
        .replaceAll(' ', '')
        .replaceAll('_', '')
        .replaceAll('*', '')
        .replaceAll('_', '')
        .replaceAll('-', '')
        .replaceAll('#', '')
        .replaceAll('\n', '')
        .replaceAll('!', '')
        .replaceAll('[', '')
        .replaceAll('(', '')
        .replaceAll(')', '')
        .replaceAll(']', '');
  }

  ///Returns a valid [String] which has characters length greater than [1] and not equal to ["null"]
  ///Otherwise [null] will be returned.
  ///Used on [UI] [Add] [Edit] page [Txtfield] values
  ///If minimum length is given, then any text which is less than [minLength] will be returned as [null]
  String? ifValid({final String prefix = '', final int minLength = 1}) {
    final String _text = this;
    bool isValid = _text.characters.isNotEmpty && _text != 'null';
    isValid = _text.length >= minLength;
    return isValid ? '$prefix$_text' : null;
  }

  ///If the current text is a valid email address then return it otherwise make it [null]
  String? ifValidEmail() {
    if (this.isValidEmail) {
      return this;
    } else {
      return null;
    }
  }

  ///Returns only if the given input is a valid url.
  ///Note: you can pass a [Json] and it's [key] to parse the [value]
  ///or you can pass the [String] as direct input
  static String? validatedUrl(final Object? stringOrJson, [final String? key]) {
    String finalInput = '';
    if (stringOrJson is Json) {
      finalInput = '${stringOrJson[key]}';
    } else {
      finalInput = '$stringOrJson';
    }
    final bool isValid = finalInput.contains('http') && finalInput.contains('.');
    return isValid ? finalInput : null;
  }

  ///Parses int? from the given String
  int? get toInt => int.tryParse(this);

  ///Checks if this string is a valid Email
  bool get isValidEmail => contains('@') && contains('.') && length > 5;

  ///This function converts the given String which is in camelCase
  String get camelCaseToString {
    // Use a regular expression to insert a space before each capital letter
    return replaceAllMapped(RegExp('([A-Z])'), (final Match match) {
      return ' ${match.group(0)}';
    });
  }

  ///If the given string is valid ie not empty
  bool get isValid => trim().isNotEmpty;

  ///If the given string is a valid readable URL
  bool get isValidUrl => contains('http') && contains('.') && contains('/');

  /// Common method to convert a string to an enum value of a given enum type
  /// If not found, then use [orElse] value as placeholder if given,
  /// or use the last element as value
  T? toEnum<T>(final List<T> values) {
    if (isEmpty) {
      return null;
    } else {
      try {
        return values.firstWhere((final _) => '$_'.split('.').last.toLowerCase() == toLowerCase());
      } on Exception catch (_) {
        return null;
      }
    }
  }

  ///Parses the color from the string
  Color? color({final Color? orElse}) {
    Color? res;
    final int? number = <String, String>{'n': this}.nullableInt('n');
    if (number != null) {
      res = Color(number);
    }
    return res ?? orElse;
  }

  ///If the string is a valid [url], then only return this otherwise make it [null]
  String? get ifValidUrl => isValidUrl ? this : null;

  ///If the given String can be parsed as a JSON
  bool get isJSON =>
      toLowerCase().replaceAll('"', '').startsWith('{') && toLowerCase().endsWith('}');
}
