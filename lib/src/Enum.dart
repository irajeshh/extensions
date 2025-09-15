part of '../extensions.dart';

// ignore: public_member_api_docs
extension EnumExtension on Enum {
  ///Returns the given enum value as String;
  ///Also it converts if camelCase is found!
  String get text {
    // If all uppercase return as is
    if (name.toUpperCase() == name) return name;
    // If all lowercase, return as is with first letter capitalized
    if (name.toLowerCase() == name) return name.upperCaseFirst;
    // If mixed case (camelCase), convert to space-separated words
    return name.camelCaseToString.trim().upperCaseFirst;
  }
}
