part of '../extensions.dart';

///Custom extensions over any [Object] values
extension ObjectExtension on Object? {
  ///Converts the given [Object] to a [String] for duplicate checking
  String get equatable => this?.toString().toLowerCase().filtered ?? 'null';
}
