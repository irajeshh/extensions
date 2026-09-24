part of '../extensions.dart';

///Custom extension
extension ListStringExtention on List<String> {
  ///Removes all brackets and returns the elements
  String get text => '$this'.replaceAll('[', '').replaceAll(']', '');

  ///Converts the given List of Strings to a List of Enums
  // List<T> toEnums<T>(final List<T> values) => map<T>((final String e) => e.toEnum<T>(values) ?? values.last).toList();
  List<T> toEnums<T>(final List<T> values) {
    final List<T> result = <T>[];
    forEach((final String e) {
      final T? enumVal = e.toEnum<T>(values);
      if (enumVal != null) {
        result.add(enumVal);
      }
    });
    return result;
  }
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
  /// Common English stop words to exclude from tag generation
  static const Set<String> _stopWords = <String>{
    // Articles
    'a', 'an', 'the',
    // Pronouns
    'i', 'me', 'my', 'we', 'our', 'you', 'your', 'he', 'him', 'his',
    'she', 'her', 'it', 'its', 'they', 'them', 'their', 'this', 'that',
    'these', 'those', 'who', 'whom', 'which', 'what',
    // Auxiliary / Common verbs
    'is', 'am', 'are', 'was', 'were', 'be', 'been', 'being',
    'has', 'have', 'had', 'do', 'does', 'did', 'will', 'would',
    'shall', 'should', 'can', 'could', 'may', 'might', 'must',
    // Verbs
    'like', 'make', 'made', 'going', 'went', 'said', 'come', 'take',
    // Prepositions
    'in', 'on', 'at', 'to', 'for', 'of', 'with', 'by', 'from',
    'up', 'about', 'into', 'over', 'after', 'out', 'off',
    'through', 'between', 'during', 'before', 'without', 'within',
    'under', 'above', 'below', 'along', 'across', 'around',
    'among', 'against', 'near',
    // Conjunctions
    'and', 'but', 'or', 'nor', 'so', 'yet', 'both', 'either', 'neither',
    // Adverbs
    'more', 'most', 'less', 'much', 'many', 'still', 'always',
    'never', 'really', 'already', 'often',
    // Other common words
    'not', 'no', 'than', 'too', 'very', 'just', 'also', 'now', 'here',
    'there', 'then', 'if', 'when', 'where', 'how', 'all', 'each',
    'every', 'any', 'some', 'such', 'only', 'own', 'same', 'other',
    'new', 'old', 'get', 'got', 'one', 'two',
    'back', 'even', 'way', 'let', 'well',
  };

  List<String> get generateTags {
    final List<String> tags = <String>[];
    if (this == null) {
      return <String>[];
    }
    // Process each sentence John Basky
    for (final dynamic sentence in this!) {
      if (sentence != null) {
        final List<String> words =
            '$sentence'.toLowerCase().replaceAll(',', '').replaceAll('\n', ' ').split(' ');
        // Add full words as tags John, Basky
        for (final String word in words) {
          final String tag = word.trim();
          if (tags.contains(tag) == false && tag.isValid && !_stopWords.contains(tag)) {
            tags.add(tag);

            // Characters of words  Joh, John, Bas, Bask, Basky
            for (int i = 3; i <= tag.length; i++) {
              final String prefix = tag.substring(0, i);
              if (!tags.contains(prefix) && prefix.length >= 3) {
                tags.add(prefix);
              }
            }
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

  ///If the given list contains the given object in any format
  bool has(final Object? o) {
    return (this ?? <dynamic>[])
        .map((final Object? e) => e.equatable)
        .toList()
        .contains(o?.equatable);
  }

  ///If the given list is not empty, then return the casted list of type [T]
  List<T>? ifNotEmpty<T>() {
    if (this == null || this!.isEmpty) {
      return null;
    } else {
      return this!.cast<T>();
    }
  }
}
