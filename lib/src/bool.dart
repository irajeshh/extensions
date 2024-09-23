part of '../extensions.dart';

///Custom extensions over [bool] values
extension BoolExtension on bool? {
  ///To be used in UI
  String? get yesNo => this == null ? null : (this! ? 'Yes' : 'No');

  ///In sql, there are only int allowed
  int? get toSQL => this == null ? null : (this! ? 1 : 0);
}
