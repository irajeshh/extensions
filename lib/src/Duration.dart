part of '../extensions.dart';

/// Extension on [Duration] to provide human readable formatting
extension DurationExtension on Duration {
  /// Returns duration in a human-readable format e.g. "2d 4h", "8h", "30m"
  String get toByToReadable {
    final Duration diff = abs();
    final int days = diff.inDays;
    final int hours = diff.inHours.remainder(24);
    final int minutes = diff.inMinutes.remainder(60);
    String duration = '';
    if (days > 0) {
      duration = '${days}d ';
    }
    if (hours > 0 || days > 0 || minutes == 0) {
      duration += '${hours}h';
    } else {
      duration = '${minutes}m';
    }
    return duration;
  }

  /// Alias for [toByToReadable]
  String get readable => toByToReadable;
}
