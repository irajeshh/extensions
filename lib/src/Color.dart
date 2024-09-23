part of '../extensions.dart';

///Color extension
extension ColorExtension on Color? {
  ///Returns Black or While color better readablity for this backgroundColor
  Color get readable =>
      (this ?? Colors.grey).computeLuminance() > 0.35 ? Colors.black : Colors.white;

  ///It returns the [darken Color] of the given [color] with the [value] adjustment.
  ///Usage: [0.1] is too dark & [1] is too light.
  ///There are no identified [value], which returns the [original] color
  ///And the [result] will be changing for diffrent [color] inputs.
  Color dark([final double value = 0.45]) =>
      HSLColor.fromColor(this ?? Colors.grey).withLightness(value).toColor();

  ///Returns color from the given String
  static Color? colorFromString(final Object? color) {
    if (color == null) {
      return null;
    }
    int? value;
    if (color is String) {
      value = int.tryParse(color);
    }
    if (color is int) {
      value = color;
    }
    return value == null ? null : Color(value);
  }

  ///Returns the HEX code value of the color
  String? get hexCode => this == null ? null : '#${this?.value.toRadixString(16)}';
}
