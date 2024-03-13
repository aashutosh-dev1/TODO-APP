import 'package:flutter/material.dart';

class CompletedUtils {
  static String getCompletedLabel(int compelted) {
    switch (compelted) {
      case 0:
        return 'Incomplete';
      case 1:
        return 'Completed';

      default:
        return 'Incomplete';
    }
  }

  static Color getCompletedColor(int completed) {
    switch (completed) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.green;

      default:
        return Colors.red;
    }
  }

  static int getCompletedValue(String completed) {
    switch (completed) {
      case 'incomplete':
        return 0;
      case 'completed':
        return 1;

      default:
        return 0;
    }
  }
}
