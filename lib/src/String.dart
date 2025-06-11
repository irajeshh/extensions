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
    if (isValidEmail) {
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

  int? get nullableInt => <String, String>{'tmp': this}.nullableInt('tmp');

  double? get nullableDouble => <String, String>{'tmp': this}.nullableDouble('tmp');

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

  ///Parses and returns the caption from the given text if it's an URL
  String? get caption {
    if (this == null) {
      return null;
    } else {
      final Uri uri = Uri.parse(this);
      final String? caption = uri.queryParameters.nullableString('caption');
      return caption?.ifValid();
    }
  }

  ///Puts the given caption to the URL
  String putCaption(final String c) {
    final Uri uri = Uri.parse(this);
    final Map<String, String> queryParams = <String, String>{...uri.queryParameters};
    queryParams['caption'] = c;
    return uri.replace(queryParameters: queryParams).toString();
  }

  /// Common method to convert a string to an enum value of a given enum type
  /// If not found, then use [orElse] value as placeholder if given,
  /// or use the last element as value
  T? toEnum<T>(final List<T> values) {
    if (values.whereType<Enum>().map((final Enum v) => v.name).toList().contains(this)) {
      try {
        return values.firstWhere((final _) {
          return '$_'.split('.').last.toLowerCase() == toLowerCase();
        });
      } on Exception catch (_) {
        print('Eception getting enum from ""$this"" e: $_');
      }
    }
    return null;
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
  bool get isJSON => toLowerCase().replaceAll('"', '').startsWith('{') && toLowerCase().endsWith('}');

  ///To convert the given string into camelCase
  String get toCamelCase {
    try {
      // Split the string into words using space or underscore as a delimiter
      final List<String> words = split(RegExp(r'[_\s]+'));

      if (words.isEmpty) {
        return '';
      }

      // Convert the first word to lowercase and others to capitalized
      String camelCaseString = words.first.toLowerCase();
      for (int i = 1; i < words.length; i++) {
        final String word = words[i];
        camelCaseString += word[0].toUpperCase() + word.substring(1).toLowerCase();
      }
      return camelCaseString;
    } on Exception catch (_) {
      return this;
    }
  }

  ///To remove token from firebase storge file URL
  String get withoutToken {
    if (contains('&token=')) {
      return split('&token=').first;
    } else {
      return this;
    }
  }

  ///Eg : "Hello World" => "hello, world" mainly used on firestore search
  ///which has a limitation maximum of 9 words
  List<String> get to9Tags {
    List<String> list = <String>[];
    if (trim().isNotEmpty) {
      list = toLowerCase().split(' ')
        ..sort((final String b, final String a) => a.length.compareTo(b.length))
        ..removeWhere((final String element) => element.length < 3);
      if (list.length > 9) {
        list = list..removeRange(9, list.length);
      }
    }
    return list;
  }
}
