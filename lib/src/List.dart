part of '../extensions.dart';

///Custom extension
extension ListStringExtention on List<String> {
  ///Removes all brackets and returns the elements
  String get text => '$this'.replaceAll('[', '').replaceAll(']', '');

  ///Converts the given List of Strings to a List of Enums
  List<T> toEnums<T>(final List<T> values) => map<T>((final String e) => e.toEnum<T>(values) ?? values.last).toList();
}

extension ListOfEnumsExt on List<Enum> {
  ///Converts the given List of Enums to a List of .text values
  List<String> get toTexts => map((final Enum f) => f.text).toList();

  ///Converts the given List of Enums to a List of .name values
  List<String> get toNames => map((final Enum f) => f.name).toList();

  ///Readable version of the List of Enum texts
  String get text => toTexts.text;
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

  // ///Generates the given List<dynamic> into a List<Json>
  // List<Json> get toListOfJsons {
  //   if (this == null) {
  //     return <Json>[];
  //   } else {
  //     return List<Json>.generate(
  //       this!.length,
  //       (final int index) => (this![index] is Json) ? (this![index] as Json) : <String, dynamic>{},
  //     );
  //   }
  // }

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

  ///If the given list contains the given object in any format
  bool has(final Object? o) {
    return (this ?? <dynamic>[]).map((final Object? e) => e.equatable).toList().contains(o?.equatable);
  }
}
