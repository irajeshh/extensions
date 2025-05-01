part of '../extensions.dart';

///Custom extension
extension ListStringExtention on List<String> {
  ///Removes all brackets and returns the elements
  String get text => '$this'.replaceAll('[', '').replaceAll(']', '');

  ///Converts the given List of Strings to a List of Enums
  List<T> toEnums<T>(final List<T> values) => map<T>((final String e) => e.toEnum<T>(values) ?? values.last).toList();
}

///To simplify the conversion of a List<Enum> to a List<String>
extension ListEnumExtentionNullable on List<Enum>? {
  ///Generates a List<String> from the given List<Enum>
  List<String>? get toNames {
    if (this == null) {
      return null;
    } else {
      return this!.map((final Enum e) => e.name).toList();
    }
  }

  ///Generates a List<String> from the given List<Enum> but with .text
  List<String>? get toTexts {
    if (this == null) {
      return null;
    } else {
      return this!.map((final Enum e) => e.text).toList();
    }
  }
}

// ignore: public_member_api_docs
extension ListExtention on List<dynamic>? {
  ///To generate a list of [Tags] for [Firebase] search functionality from the given list of [sentences]
  ///Example of sentences are [title, description]
  ///All the words fromt he given [sentences] will be splitted to create a minimal list of [tags]
  List<String> get generateTags {
    final List<String> tags = <String>[];
    if (this == null) {
      return <String>[];
    }
    for (final dynamic sentence in this!) {
      if (sentence != null) {
        final List<String> words = '$sentence'.toLowerCase().replaceAll(',', '').replaceAll('\n', ' ').split(' ');
        for (final String word in words) {
          final String tag = word.trim();
          if (tags.contains(tag) == false) {
            tags.add(tag);
          }
        }
      }
    }
    return tags
      ..sort((final String b, final String a) => a.length.compareTo(b.length))
      ..removeWhere((final String element) => element.length < 3);
  }

  ///Converts the given List<dynamic> into a List<String>
  List<String> get toListOfStrings {
    if (this == null) {
      return <String>[];
    } else {
      return List<String>.generate(this!.length, (final int index) => '${this![index]}');
    }
  }

  ///Generates the given List<dynamic> into a List<Json>
  List<Json> get toListOfJsons {
    if (this == null) {
      return <Json>[];
    } else {
      return List<Json>.generate(
        this!.length,
        (final int index) => (this![index] is Json) ? (this![index] as Json) : <String, dynamic>{},
      );
    }
  }

  ///To remove all the duplicate entries in the given array!
  List<String> get removeDuplicates {
    final List<String> _tmp = <String>[];
    if (this != null) {
      for (final dynamic s in this!) {
        if (_tmp.contains('$s') == false) {
          _tmp.add('$s');
        } else {
          ///Already found!
        }
      }
    }
    return _tmp;
  }
}
