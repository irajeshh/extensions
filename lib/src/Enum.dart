part of '../extensions.dart';

// ignore: public_member_api_docs
extension EnumExtension on Enum {
  ///Returns the given enum value as String;
  ///Also it converts if camelCase is found!
  String get text => name.camelCaseToString.trim().upperCaseFirst;
}
