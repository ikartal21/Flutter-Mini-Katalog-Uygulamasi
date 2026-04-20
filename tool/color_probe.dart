import 'package:flutter/material.dart';

void main() {
  final scheme = ColorScheme.fromSeed(seedColor: Colors.teal, brightness: Brightness.light);
  debugPrint('seed=${Colors.teal.value.toRadixString(16)}');
  debugPrint('surface=${scheme.surface.value.toRadixString(16)}');
  debugPrint('surfaceContainerLowest=${scheme.surfaceContainerLowest.value.toRadixString(16)}');
  debugPrint('surfaceContainerLow=${scheme.surfaceContainerLow.value.toRadixString(16)}');
  debugPrint('surfaceContainer=${scheme.surfaceContainer.value.toRadixString(16)}');
  debugPrint('background=${scheme.surface.value.toRadixString(16)}');
}
