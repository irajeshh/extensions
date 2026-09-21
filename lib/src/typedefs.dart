part of '../extensions.dart';

/// Alias for a JSON object, typically used for representing data in a key-value format.
typedef Json = Map<String, dynamic>;

/// Alias for a JSON object representing HTTP headers, often used for making HTTP requests.
typedef HeaderJson = Map<String, String>;

typedef HeaderEntry = MapEntry<String, String>;

typedef StringIntMap = Map<String, int>;
typedef StringIntMapEntry = MapEntry<String, int>;
typedef IntStringMap = Map<int, String>;
typedef IntStringMapEntry = MapEntry<int, String>;