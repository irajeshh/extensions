part of '../extensions.dart';

///Custom extension
extension ListStringExtention on List<String> {
  ///Removes all brackets and returns the elements
  String get text => '$this'.replaceAll('[', '').replaceAll(']', '');
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
        final List<String> words =
            '$sentence'.toLowerCase().replaceAll(',', '').replaceAll('\n', ' ').split(' ');
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
}
