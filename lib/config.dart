part of './extensions.dart';

///A configuration file which can be used to control the functions across different
///projects without affecting other projects
class ExtensionsConfig {
  const ExtensionsConfig._();

  ///To show the [toRupees] & [toPDFRupees] functions with rounded off the given input
  static bool _roundOffRupees = false;

  ///By default if given input is less than this point it will be reduced
  ///If equal to or higher than, it will be increased
  static double _roundOffPoint = 0.5;

  ///Let say the input is 40.05 and it should be kept as it is 40.05
  ///We need to use this value, otherwise it will be increased to 41 or decreased to 40
  static bool _keepRoundOffPoint = true;

  ///To remove [.00] from [Rs91.00] and make it [Rs91]
  static bool _removeZeros = false;

  ///To configure the extensions
  static void initiate({
    final bool? roundOffRupees,
    final double? roundOffPoint,
    final bool? keepRoundOffPoint,
    final bool? removeZeros,
  }) {
    _roundOffRupees = roundOffRupees ?? _roundOffRupees;
    _roundOffPoint = roundOffPoint ?? _roundOffPoint;
    _keepRoundOffPoint = keepRoundOffPoint ?? _keepRoundOffPoint;
    _removeZeros = removeZeros ?? _removeZeros;
  }
}
