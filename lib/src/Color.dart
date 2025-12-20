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
  Color dark([final double value = 0.45]) => HSLColor.fromColor(this ?? Colors.grey).withLightness(value).toColor();

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

  ///Returns the given color, only if not transparent!
  ///Used in [copyWith] color pickers!
  Color? get ifNotTransparent {
    return this?.value == Colors.transparent.value ? null : this;
  }
}

extension ColorListExtension2 on Color {
  /// Extension on [Color] to resolve opacity based on a [double] value.
  /// The opacity is expected to be between 0.0 (fully transparent) and
  /// 1.0 (fully opaque).
  /// Returns a new color with the applied opacity.
  Color withhOpacity(double value) {
    value = value.clamp(0.0, 1.0);
    final int alpha = (value * 255).round();
    return withAlpha(alpha);
  }
}
